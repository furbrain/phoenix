#define USE_AND_OR
#include <i2c.h>
#include "i2c_util.h"

void i2c_init(){
	OpenI2C1(I2C_ON,37);
}

int8_t write_i2c_block(uint8_t address, uint8_t *data, uint8_t length) {
	IdleI2C1();
	StartI2C1();
	IdleI2C1();  //Wait till Start sequence is completed
	MasterWriteI2C1(address << 1);       //Write Slave address and set master for transmission
	IdleI2C1();
	if(I2C1STATbits.ACKSTAT) goto fallover;
	while (length) {
		MasterputcI2C1(*data);        // write a byte
		IdleI2C1();
		if(I2C1STATbits.ACKSTAT) goto fallover;
		length--;
		data++;
	}
	StopI2C1();              //Terminate communication protocol with stop signal
	IdleI2C1();
	return 0;

fallover:
	StopI2C1();
	IdleI2C1();
	return -1;
}

int8_t write_i2c_command_block(uint8_t address, uint8_t command, uint8_t *data, uint8_t length) {
	IdleI2C1();
	StartI2C1();
	IdleI2C1();  //Wait till Start sequence is completed
	MasterWriteI2C1(address << 1);       //Write Slave address and set master for transmission
	IdleI2C1();
	if(I2C1STATbits.ACKSTAT) goto fallover;
	MasterWriteI2C1(command);       //Write Slave address and set master for transmission
	IdleI2C1();
	if(I2C1STATbits.ACKSTAT) goto fallover;
	while (length) {
		MasterputcI2C1(*data);        // write a byte
		IdleI2C1();
		if(I2C1STATbits.ACKSTAT) goto fallover;
		length--;
		data++;
	}
	StopI2C1();              //Terminate communication protocol with stop signal
	IdleI2C1();
	return 0;

fallover:
	StopI2C1();
	IdleI2C1();
	return -1;
}

int8_t read_i2c_block(uint8_t address, uint8_t *data, uint8_t length) {
	IdleI2C1();
	StartI2C1();
	IdleI2C1();  //Wait till Start sequence is completed
	MasterWriteI2C1(address * 2 + 1);
	IdleI2C1();
	if (MastergetsI2C1(length,data,20)){
		StopI2C1();
		IdleI2C1();
		return -1;
	}
	StopI2C1();              //Terminate communication protocol with stop signal
	IdleI2C1();
	return 0;
}

#ifndef BOOTLOADER
int8_t write_i2c_data1(uint8_t address, uint8_t command) {
	return write_i2c_block(address, &command, 1);
}

int8_t write_i2c_data2(uint8_t address, uint8_t command, uint8_t data) {
	uint8_t data_list[2];
	data_list[0] = command;
	data_list[1] = data;
	return write_i2c_block(address,data_list,2);
}

int8_t read_i2c_data(uint8_t address, uint8_t command, uint8_t *data, uint8_t length) {
	if (write_i2c_data1(address,command)) return -1;
	return read_i2c_block(address,data,length);
}

int8_t write_eeprom_data(uint16_t address, uint8_t *data, uint8_t length) {
	IdleI2C1();
	StartI2C1();
	IdleI2C1();  //Wait till Start sequence is completed
	MasterWriteI2C1(EEPROM_ADDRESS << 1);       //Write Slave address and set master for transmission
	IdleI2C1();
	if(I2C1STATbits.ACKSTAT) {
		StopI2C1();
		IdleI2C1();
		return -1;
	}
	MasterputcI2C1((uint8_t)(address >> 8));
	IdleI2C1();
	MasterputcI2C1((uint8_t)(address&0xff));
	IdleI2C1();
	while (length) {
		MasterputcI2C1(*data);        // write a byte
		IdleI2C1();
		if(I2C1STATbits.ACKSTAT) {
			StopI2C1();
			IdleI2C1();
			return -1;
		}
		length--;
		data++;
	}
	StopI2C1();              //Terminate communication protocol with stop signal
	IdleI2C1();
	return 0;
}

int8_t read_eeprom_data(uint16_t address, uint8_t *data, uint8_t length) {
	if (write_i2c_data2(EEPROM_ADDRESS,(uint8_t)(address >> 8),(uint8_t)(address&0xff))) return -1;
	return read_i2c_block(EEPROM_ADDRESS,data,length);
}
#endif