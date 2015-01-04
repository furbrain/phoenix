/* I2C utility funcs*/
#include <stdint.h>

#define EEPROM_ADDRESS 0x50

void i2c_init();

int8_t write_i2c_block(uint8_t address, const uint8_t *data, uint8_t length);

int8_t read_i2c_block(uint8_t address, uint8_t *data, uint8_t length);


#ifndef BOOTLOADER
int8_t write_i2c_data1(uint8_t address, uint8_t command);

int8_t write_i2c_data2(uint8_t address, uint8_t command, uint8_t data);

int8_t write_i2c_command_block(uint8_t address, uint8_t command, const uint8_t *data, uint8_t length);


int8_t read_i2c_data(uint8_t address, uint8_t command, uint8_t *data, uint8_t length);

int8_t write_eeprom_data(uint16_t address, const uint8_t *data, uint8_t length);

int8_t read_eeprom_data(uint16_t address, uint8_t *data, uint8_t length);
#endif