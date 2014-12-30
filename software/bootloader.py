#!/usr/bin/python

import re
import operator
import usb

# plans...
# load in hex file - possibly munged to separate out the flash bits etc...
# probably best do this directly, and load into program, flash and config mems.


CLEAR_FLASH = 100
SEND_DATA = 101
GET_CHIP_INFO = 102
REQUEST_DATA = 103
SEND_RESET = 105

# I2C commands 
WRITE_I2C_DATA = 110
READ_I2C_DATA = 111
CHECK_I2C_READY = 112


def clean_list(buffer):
    for i in range(0,len(buffer)):
        if buffer[i] is None:
            buffer[i] = 0

class HexFileError(Exception):
    def _init__(self,value):
        self.value = value
    def __str__(self):
        return repr(self.value)

class HexFile:
    def __init__(self,fname):
        self.program = [None] * 0x10000
        self.config = [None] * 0x10
        self.eeprom = [None] * 0x100
        self.devid = [None] * 0x08
        active = self.program
        f = file(fname,"rU")
        for s in f:
            if (s[0] == ":"):
                #good - it starts sensibly...
                bytes = s.strip()[1:].decode("hex")
                numbers = map(ord,bytes)
                reclen = numbers[0]
                offset = numbers[1]*256 + numbers[2]
                rectype = numbers[3]
                data = numbers[4:-1]
                checksum = reduce(operator.add,numbers) & 0xff
                if ((checksum != 0) or (reclen != len(data))):
                    raise HexFileError("Bad checksum")
            else:
                raise HexFileError("Bad format")
            #so far, so good. Now to slot the data in...
            if (rectype not in (0,1,4)):
                # rectype not known. Fall over
                raise HexFileError("Unknown record format")
            if (rectype == 0):
                active[offset:offset+reclen] = data
            if (rectype == 1):
                #end of file
                return None
            if (rectype == 4):
                if offset != 0:
                    #really should be zero...
                    raise HexFileError("Bad format")
                if reclen != 2:
                    #incorrect length
                    raise HexFileError("Bad format")
                if data[1]==0x00:
                    active = self.program
                if data[1]==0x20:
                    active = self.devid
                if data[1]==0x30:
                    active = self.config
                if data[1]==0xf0:
                    active = self.eeprom


class ProgrammerError(Exception):
    def _init__(self,value):
        self.value = value
    def __str__(self):
        return repr(self.value)

class Programmer:
    def __init__(self,vID = 0xa0a0, pID = 0x0002, configuration = 0, interface = 0):
        for bus in usb.busses():
            for dev in bus.devices:
                if (dev.idVendor == vID) & (dev.idProduct == pID):
                    handle = dev.open()
                    handle.setConfiguration(configuration)
                    #handle.claimInterface(interface)
                    self.handle = handle
                    return None
        raise ProgrammerError("Bootloader not found")
        
    def read_data(self,command,address,size):
        index = 0
        if address > 0xFFFF:
            index = address >> 16
            address = address & 0xFFFF
        buf = self.handle.controlMsg(usb.ENDPOINT_IN | usb.TYPE_VENDOR | usb.RECIP_OTHER,command,size,value=address,index=index)
        if len(buf) != size:
            raise ProgrammerError("Error reading data")
        return buf

    def write_data(self,command,address,data):
    #construct data package - size is 64 bits...
        index = 0
        if address > 0xFFFF:
            index = address >> 16
            address = address & 0xFFFF
        r = self.handle.controlMsg(usb.ENDPOINT_OUT | usb.TYPE_VENDOR | usb.RECIP_OTHER,command,data,value=address,index=index)
        if r != len(data):
            raise ProgrammerError("Error writing data")
        return r

    def write_program(self,hexfile,set_range=None,set_progress=None):
        #this is to write 64 byte blocks...
        if set_range:
            set_range(len(hexfile.program))
        for i in range(0,len(hexfile.program),64):
            #check to see if there is any data...
            subset = hexfile.program[i:i+64]
            if subset.count(None) < 64:
                clean_list(subset)
                self.write_data(ERASE_FLASH,i,[1])
                for j in range(0,64,16):
                    self.write_data(WRITE_FLASH,i+j,subset[j:j+16])
            if set_progress:
                set_progress(i)

    def write_config(self,hexfile):
        subset = hexfile.config[0:16]
        if subset.count(None) < len(subset):
            self.write_data(ERASE_FLASH,0x300000,[1])
            self.write_data(WRITE_CONFIG,0x300000,subset)

    def write_devid(self,hexfile):
        subset = hexfile.config[0:8]
        if subset.count(None) < len(subset):
            clean_list(subset)
            self.write_data(ERASE_FLASH,0x200000,[1])
            self.write_data(WRITE_CONFIG,0x200000,subset)

    def write_flash(self,hexfile,set_range=None,set_progress=None):
        if set_range:
            set_range(256)
	for i in range(0,256,16):
            subset = hexfile.eeprom[i:i+16]
            if subset.count(None) < 16:
                clean_list(subset)
                self.write_data(WRITE_EEDATA,i,subset)
            if set_progress:
                set_progress(i)

    def reset(self):
        self.write_data(RESET,0,[0])
        
    def write_i2c(self,address,data):
        return self.write_data(WRITE_I2C_DATA,address,data)
        
    def read_i2c(self,address,size):
        return self.read_data(READ_I2C_DATA,address,size)
        
    def read_i2c_address(self,address,register,size,word=False):
        if word:
            self.write_i2c(address,[register>>8, register & 0xff])
        else:
            self.write_i2c(address,[register])
        return self.read_i2c(address,size)

    def check_i2c(self,address):
        return self.read_data(CHECK_I2C_READY,address,1)
        
if __name__=="__main__":
    import time
    EEPROM=0x50
    MPU = 0x68
    p = Programmer()
    print p.check_i2c(MPU)
    print p.read_data(REQUEST_DATA,0x0100,2)
    p.write_i2c(MPU,[0x0e])
    print p.read_i2c(MPU,2)
    #print p.check_i2c(EEPROM)
    time.sleep(0.1)
    print p.check_i2c(EEPROM)
    print p.write_i2c(EEPROM,(0x00,0x10,0xde,0xad,0xbe,0xe5))
    time.sleep(0.1)
    print p.check_i2c(EEPROM)
    time.sleep(0.1)
    p.write_i2c(EEPROM,[0x00,0x10])
    time.sleep(0.1)
    print ([hex(x) for x in p.read_i2c(EEPROM,4)])

