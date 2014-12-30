#!/usr/bin/python
import time
import RPi.GPIO as gpio
import freetype
import pprint
from itertools import izip_longest
gpio.setmode(gpio.BCM)
DEBUG = False

def chunk(data,chunk_size,padding):
    return list(izip_longest(*[iter(data)]*chunk_size,fillvalue = padding))

if DEBUG:
    def sleep(duration):
        if duration==0:
            print "Sleeping for 0 seconds"
        elif duration<0.000001:
            print "Sleeping for %g nanoseconds" % (duration/0.000000001)
        elif duration<0.001:
            print "Sleeping for %g microseconds" % (duration/0.000001)
        elif duration<1:
            print "Sleeping for %g milliseconds" % (duration/0.001)
    time.sleep = sleep

    def output(pin,level):
        print "setting pin %d to %d" % (pin,level)
    gpio.output = output    
        
        
    def setup(pin,direction,pull_up=gpio.PUD_OFF,initial=gpio.LOW):
        print "initialising pin %d to %d direction, pull-up: %d, state %d" % (pin,direction,pull_up,initial)
    gpio.setup = setup    
        
us = 0.000001 #microseconds

class Display(object):
    CS=0
    RES=1
    DC=4
    WR=17
    RD=21
    
    DATA = [22,10,9,11,24,25,8,7]
    
    #IO level function
    
    def set_pin(self,pin_no,state):
        gpio.output(pin_no,state)
        
    #low level functions    
        
    def send_byte(self,data):
        self.set_pin(self.CS,gpio.LOW)
        self.set_pin(self.WR,gpio.LOW)
        for bit,pin in enumerate(self.DATA):
            self.set_pin(pin,(data & (1 << bit))!=0)
        time.sleep(0.12*us) # wait 120ns
        self.set_pin(self.WR,gpio.HIGH)
        time.sleep(0.015*us)
        self.set_pin(self.CS,gpio.HIGH)
        
    def send_command(self,command, *data):
        #set to command mode
        self.set_pin(self.DC,gpio.LOW)
        self.send_byte(command)
        if data:
            for byte in data:
                self.send_byte(byte)        
        self.set_pin(self.DC,gpio.HIGH)
    
    #high level functions
        
    def power_up(self):
        #set control pins high
        for pin in [self.CS,self.RES,self.DC,self.WR,self.RD]:
            gpio.setup(pin,gpio.OUT,initial=gpio.HIGH)
        #set data pins low
        for pin in self.DATA:
            gpio.setup(pin,gpio.OUT,initial=gpio.LOW)
            self.set_pin(pin,0)
        self.set_pin(self.RES,0)
        time.sleep(3*us) # sleep 3us
        self.set_pin(self.RES,1)
        time.sleep(3*us) # sleep 3us again
        self.send_command(0xAF)
        time.sleep(0.1) # sleep 100ms
        self.send_command(0xA0,0X50) # set OLED to have alternating row lines
        #self.send_command(0xA2,0x60) # set display to start from line 
        self.set_row_count(0x60)
        #self.set_brightness(0xC0)
        #ok ready!
        
    def power_down(self):
        self.send_command(0xAE)
        time.sleep(0.1)
        #ok, powered down
        
    def set_row_count(self,row_count):
        """set total number of rows to be displayed"""
        self.send_command(0xA8,row_count-1)
        
    def set_brightness(self,brightness):
        """set brightness level, 0-255"""
        self.send_command(0x81,brightness)

    def put_image(self,col_start,row_start,col_finish,row_finish,data):
        """Copies some data through to the screen.
        col_finish and row_finish are *not* inclusive
        send data as a list of lists, one list of grayscal bytes for each row"""
        
        self.send_command(0xA6)
        self.send_command(0x15,col_start/2,(col_finish-1)/2)
        self.send_command(0x75,row_start,row_finish-1)
        self.set_pin(self.DC,gpio.HIGH)
        for row in data:
            #pad data as necessary
            row = list(row)
            if col_start%2:
                row = [0]+row
            if col_finish%2:
                row = row + [0]
            if len(row)%2!=0:
                print row
            for pair in chunk(row,2,0):
                self.send_byte((pair[0]>>4) + (pair[1] & 0xF0))
        self.send_command(0xA4)
        
    def clear_screen(self,byte=0x00):
        self.put_image(0,0,0x80,0x60,[[byte]*0x80]*0x60)
    	
disp  = Display()
disp.power_up()
disp.clear_screen(0x00)
time.sleep(10)
disp.clear_screen(0x00)
disp.put_image(0,0,0x80,1,[[0xff]*0x80])
disp.put_image(0,95,0x80,96,[[0xff]*0x80])
disp.put_image(0,0,1,96,[[0xff]]*96)
disp.put_image(127,0,128,96,[[0xff]]*96)
time.sleep(1)
face = freetype.Face('/usr/share/fonts/truetype/droid/DroidSans.ttf')
face.set_char_size(32*64)
x_offset = 10
for char in 'Hello':
    face.load_char(char)
    bitmap = face.glyph.bitmap
    print char, bitmap.width
    rows = chunk(bitmap.buffer,bitmap.width,0)
    #pprint.pprint(rows)
    disp.put_image(x_offset,60-bitmap.rows,x_offset+bitmap.width,60,rows)
    time.sleep(1)
    x_offset += bitmap.width+4
time.sleep(40)
disp.power_down()
