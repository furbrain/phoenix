#include "config.h"
#include "i2c_util.h"
#include <libpic30.h>

/*define eeprom memory type*/
#define EEPROM_SIZE 0x8000
#define LEG_STORE_ADDRESS 0x80
#define LEG_COUNT (EEPROM_SIZE-0x80)/0x10
extern unsigned int eeprom __attribute__((space(external(size(EEPROM_SIZE)))));
#define EEPROM_VAR(var, origin) __external__ var __attribute__((address(origin),space(external(eeprom))))


struct CONFIG config = {
            { //calib section
                {{1.0,0,0},{0,1.0,0},{0,0,1.0}}, //accel matrix
                {{1.0,0,0},{0,1.0,0},{0,0,1.0}}, //mag matrix
                1.0                              //laser offset
            },
            POLAR,                               //Polar display style
            METRIC                               //metric units
        };
//FIRMWARE VERSION is held at position zero in the eeprom - but there
//doesn't seem to be any way to reliably specify an address of zero - bug in XC16
//so we'll just have to access it manually
EEPROM_VAR(struct CONFIG config_store,2); //have config_store in bottom part of ram
EEPROM_VAR(struct LEG leg_store[LEG_COUNT],LEG_STORE_ADDRESS);

/* eeprom access functions */
void __read_external(unsigned int address, unsigned int memory_space, void *buffer, unsigned int len) {
    if (memory_space==eeprom) {
        while (len>0) {
            /* read 64 bits at a time */
            if (len>64) {
                read_eeprom_data(address,buffer,64);
                address += 64;
                buffer += 64;
                len -= 64;
            } else {
            /* read any remainder */
                read_eeprom_data(address,buffer,len);
                len = 0;
            }
        }
    }
}

void __write_external(unsigned int address,unsigned int memory_space,void *buffer,unsigned int len) {
    unsigned int page_boundary;
    unsigned int write_count;
    if (memory_space==eeprom) {
        while (len>0) {
            page_boundary = (address & 0xffc0)+0x40;
            /* is last address in same page as current address */
            if ((address+len) > page_boundary) {
                write_count = page_boundary-address;
            } else {
                write_count = len;
            }
            write_eeprom_data(address,buffer,(write_count));
            __delay_ms(5);
            len -= write_count;
            address += write_count;
            buffer += write_count;
        }
    }
}

void config_init(){
    /* check firmware version  and update if appropriate */
    uint16_t firmware;
    __read_external(0x0,eeprom,&firmware,2);
    if (firmware!=FIRMWARE_VERSION) {
        firmware = FIRMWARE_VERSION;
        __write_external(0x0,eeprom,&firmware,2);
    }
    if (config_store.display_style==0xff) {
        //initialise config
        config_save();                   //save defaults to eeprom
    } else {
	config = config_store; 		// load saved data from eeprom
    }

}
void config_save(){
    config_store = config;
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

