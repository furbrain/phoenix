#define USE_AND_OR
#include <i2c.h>
#include "i2c_util.h"
#include "config.h"
#include <libpic30.h>
#define OpenI2C OpenI2C1
#define IdleI2C IdleI2C1
#define StartI2C StartI2C1
#define MasterWriteI2C MasterWriteI2C1
#define MastergetsI2C MastergetsI2C1
#define I2CSTATbits I2C1STATbits
#define RestartI2C RestartI2C1
#define StopI2C StopI2C1
#define CloseI2C CloseI2C1

#define TRIS_SDA TRISBbits.TRISB9
#define TRIS_SCL TRISBbits.TRISB8

#define PORT_SDA PORTBbits.RB9
#define PORT_SCL PORTBbits.RB8
#define LAT_SCL LATBbits.LATB9

void i2c_init(int speed){
    int count;
    TRIS_SDA = 1;
    TRIS_SCL = 1;
	LAT_SCL = 1;
	CloseI2C();
	if (PORT_SDA==0) {
		TRIS_SCL = 0;
		for (count=0; count<10; count++) {
			LAT_SCL = 0;
			__delay_us(2);
			LAT_SCL = 1;
			__delay_us(2);
		}
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
	Nop();
	if(I2CSTATbits.ACKSTAT) goto fallover;
	while (length) {
		MasterWriteI2C(*data);        // write a byte
		IdleI2C();
		Nop();
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
	MasterWriteI2C(command);       //Write Slave command and set master for transmission
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
	__delay_us(10);
	i2c_close();
	return -1;
}

int8_t read_i2c_block(uint8_t address, uint8_t *data, uint8_t length, int speed) {
    i2c_init(speed);
	IdleI2C();
	StartI2C();
	IdleI2C();  //Wait till Start sequence is completed
	MasterWriteI2C(address * 2 + 1);
	IdleI2C();
	if (MastergetsI2C(length,data,200)){
		StopI2C();
		__delay_us(10);
		i2c_close();
		return -1;
	}
	StopI2C();              //Terminate communication protocol with stop signal
	IdleI2C();
	i2c_close();
	return 0;
}

int8_t write_i2c_data2(uint8_t address, uint8_t command, uint8_t data, int speed) {
	uint8_t data_list[2];
	data_list[0] = command;
	data_list[1] = data;
	return write_i2c_block(address,data_list,2,speed);
}


int8_t read_eeprom_data(uint16_t address, uint8_t *data, uint8_t length) {
	if (write_i2c_data2(EEPROM_ADDRESS,(uint8_t)(address >> 8),(uint8_t)(address&0xff),I2C_FAST)) return -1;
	return read_i2c_block(EEPROM_ADDRESS,data,length,I2C_FAST);
}


#ifndef BOOTLOADER
int8_t write_i2c_data1(uint8_t address, uint8_t command, int speed) {
	return write_i2c_block(address, &command, 1, speed);
}


int8_t read_i2c_data(uint8_t address, uint8_t command, uint8_t *data, uint8_t length, int speed) {
	int result = 0;
    i2c_init(speed);
	IdleI2C();
	StartI2C();
	IdleI2C();  //Wait till Start sequence is completed
	MasterWriteI2C(address << 1);       //Write Slave address and set master for transmission
	IdleI2C();
	Nop();
	if(I2CSTATbits.ACKSTAT){
		result = -1;
		goto fallover;
	}
	MasterWriteI2C(command);        // write a byte
	IdleI2C();
	Nop();
	if(I2CSTATbits.ACKSTAT){
		result = -2;
		goto fallover;
	}
	RestartI2C();
	IdleI2C();  //Wait till Start sequence is completed
	MasterWriteI2C(address * 2 + 1);
	IdleI2C();
	if(I2CSTATbits.ACKSTAT){
		result = -3;
		goto fallover;
	}
	if (MastergetsI2C(length,data,200)) result=-4;

fallover:
	StopI2C();
	//IdleI2C();
	__delay_us(100);
	i2c_close();
	return result;
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

#endif
