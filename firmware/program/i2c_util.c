#define USE_AND_OR
#include <i2c.h>
#include "i2c_util.h"
#define OpenI2C OpenI2C1
#define IdleI2C IdleI2C1
#define MasterWriteI2C MasterWriteI2C1
#define MastergetsI2C MastergetsI2C1
#define I2CSTATbits I2C1STATbits
#define StopI2C StopI2C1
#define CloseI2C CloseI2C1

#define TRIS_SDA TRISBbits.TRISB9
#define TRIS_SCL TRISBbits.TRISB8

#define PORT_SDA PORTBbits.RB9
#define PORT_SCL PORTBbits.RB8

void i2c_init(int speed){
    int count = 5;
    TRIS_SDA = 1;
    TRIS_SCL = 1;
    while((PORT_SDA==0) || count-->0) {
        //we have a deadlock
        OpenI2C(I2C_ON,I2C_STANDARD);
        MasterWriteI2C(0);
        CloseI2C();
    } 
    OpenI2C(I2C_ON,speed);
}

void i2c_close(){
    CloseI2C();
}

int8_t write_i2c_block(uint8_t address, const uint8_t *data, uint8_t length,int speed) {
    i2c_init(speed);
	IdleI2C();
	StartI2C();
	IdleI2C();  //Wait till Start sequence is completed
	MasterWriteI2C(address << 1);       //Write Slave address and set master for transmission
	IdleI2C();
	if(I2CSTATbits.ACKSTAT) goto fallover;
	while (length) {
		MasterWriteI2C(*data);        // write a byte
		IdleI2C();
		if(I2CSTATbits.ACKSTAT) goto fallover;
		length--;
		data++;
	}
	StopI2C();              //Terminate communication protocol with stop signal
	IdleI2C();
	i2c_close();
	return 0;

fallover:
	StopI2C();
	IdleI2C();
	i2c_close();
	return -1;
}

int8_t write_i2c_command_block(uint8_t address, uint8_t command, const uint8_t *data, uint8_t length, int speed) {
    i2c_init(speed);
	IdleI2C();
	StartI2C();
	IdleI2C();  //Wait till Start sequence is completed
	MasterWriteI2C(address << 1);       //Write Slave address and set master for transmission
	IdleI2C();
	if(I2CSTATbits.ACKSTAT) goto fallover;
	MasterWriteI2C(command);       //Write Slave address and set master for transmission
	IdleI2C();
	if(I2CSTATbits.ACKSTAT) goto fallover;
	while (length) {
		MasterWriteI2C(*data);        // write a byte
		IdleI2C();
		if(I2CSTATbits.ACKSTAT) goto fallover;
		length--;
		data++;
	}
	StopI2C();              //Terminate communication protocol with stop signal
	IdleI2C();
	i2c_close();
	return 0;

fallover:
	StopI2C();
	IdleI2C();
	i2c_close()
	return -1;
}

int8_t read_i2c_block(uint8_t address, uint8_t *data, uint8_t length, int speed) {
    i2c_init(speed);
	IdleI2C();
	StartI2C();
	IdleI2C();  //Wait till Start sequence is completed
	MasterWriteI2C(address * 2 + 1);
	IdleI2C();
	if (MastergetsI2C(length,data,20)){
		StopI2C();
		IdleI2C();
		return -1;
	}
	StopI2C();              //Terminate communication protocol with stop signal
	IdleI2C();
	i2c_close();
	return 0;
}

#ifndef BOOTLOADER
int8_t write_i2c_data1(uint8_t address, uint8_t command, int speed) {
	return write_i2c_block(address, &command, 1, speed);
}

int8_t write_i2c_data2(uint8_t address, uint8_t command, uint8_t data, int speed) {
	uint8_t data_list[2];
	data_list[0] = command;
	data_list[1] = data;
	return write_i2c_block(address,data_list,2,speed);
}

int8_t read_i2c_data(uint8_t address, uint8_t command, uint8_t *data, uint8_t length, int speed) {
	if (write_i2c_data1(address,command,speed)) return -1;
	return read_i2c_block(address,data,length,speed);
}

int8_t write_eeprom_data(uint16_t address, const uint8_t *data, uint8_t length) {
    i2c_init(I2C_FAST);
	IdleI2C();
	StartI2C();
	IdleI2C();  //Wait till Start sequence is completed
	MasterWriteI2C(EEPROM_ADDRESS << 1);       //Write Slave address and set master for transmission
	IdleI2C();
	if(I2CSTATbits.ACKSTAT) {
		StopI2C();
		IdleI2C();
		return -1;
	}
	MasterWriteI2C((uint8_t)(address >> 8));
	IdleI2C();
	MasterWriteI2C((uint8_t)(address&0xff));
	IdleI2C();
	while (length) {
		MasterWriteI2C(*data);        // write a byte
		IdleI2C();
		if(I2CSTATbits.ACKSTAT) {
			StopI2C();
			IdleI2C();
			return -1;
		}
		length--;
		data++;
	}
	StopI2C();              //Terminate communication protocol with stop signal
	IdleI2C();
	i2c_close();
	return 0;
}

int8_t read_eeprom_data(uint16_t address, uint8_t *data, uint8_t length) {
	if (write_i2c_data2(EEPROM_ADDRESS,(uint8_t)(address >> 8),(uint8_t)(address&0xff),I2C_FAST)) return -1;
	return read_i2c_block(EEPROM_ADDRESS,data,length,I2C_FAST);
}
#endif
