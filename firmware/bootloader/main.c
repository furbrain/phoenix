/*
 * M-Stack USB Bootloader
 *
 *  M-Stack is free software: you can redistribute it and/or modify it under
 *  the terms of the GNU Lesser General Public License as published by the
 *  Free Software Foundation, version 3; or the Apache License, version 2.0
 *  as published by the Apache Software Foundation.  If you have purchased a
 *  commercial license for this software from Signal 11 Software, your
 *  commerical license superceeds the information in this header.
 *
 *  M-Stack is distributed in the hope that it will be useful, but WITHOUT
 *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
 *  License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public License
 *  along with this software.  If not, see <http://www.gnu.org/licenses/>.
 *
 *  You should have received a copy of the Apache License, verion 2.0 along
 *  with this software.  If not, see <http://www.apache.org/licenses/>.
 *
 * Alan Ott
 * Signal 11 Software
 * 2013-05-03
 */
/* define processor clock speed for use in delay funcs*/
#define FCY 16000000
#include "usb.h"
#include <xc.h>
#include <string.h>
#define USE_AND_OR
#include <i2c.h>
#include <PPS.h>
#include <outcompare.h>
#include <libpic30.h>
#include <dpslp.h>
#include <stdint.h>
#include "i2c_util.h"
#include "usb_config.h"
#include "usb_ch9.h"
#include "battery.h"

_CONFIG1(WDTPS_PS16 & FWPSA_PR32 & WINDIS_OFF & FWDTEN_OFF & ICS_PGx3 & GWRP_OFF & GCP_OFF & JTAGEN_OFF)
_CONFIG2(POSCMOD_NONE & I2C1SEL_PRI & IOL1WAY_OFF & OSCIOFNC_OFF & FCKSM_CSDCMD & FNOSC_FRCPLL & PLL96MHZ_ON & PLLDIV_NODIV & IESO_OFF)
_CONFIG3(WPFP_WPFP0 & SOSCSEL_IO & WUTSEL_LEG & WPDIS_WPDIS & WPCFG_WPCFGDIS & WPEND_WPENDMEM)
_CONFIG4(DSWDTPS_DSWDTPS3 & DSWDTOSC_SOSC & RTCOSC_LPRC & DSBOREN_OFF & DSWDTEN_OFF)



/* Variables from linker script.
 * 
 * The way to pass values from the linker script to the program is to create
 * variables in the linker script and extern them in the program.  The only
 * catch is that assignment operations in the linker script only set
 * variable _addresses_, and not variable values.  Thus to get the data in
 * the program, you need to take the _address_ of the variables created by
 * the linker script (and ignore their actual values).  This may seem hacky,
 * but the GNU LD manual cites it as the recommended way to do it.  See
 * section 3.5.5 "Source Code Reference."
 *
 * It's also worth noting that on Extended Data Space (EDS) PIC24F parts,
 * the linker will but a 0x01 in the high byte of each of these addresses. 
 * Unfortunately, it's impossible with GCC to take the address of a
 * varialbe, apply a mask (in our cause we'd want to use 0x00ffffff), and
 * use that value as an initializer for a constant.  Becaause of this, the
 * assignment of the uint32_t "constants" below has to be done in main().
 */
const extern __prog__ uint8_t _IVT_MAP_BASE;
const extern __prog__ uint8_t _APP_BASE;
const extern __prog__ uint8_t _APP_LENGTH;
const extern __prog__ uint8_t _FLASH_BLOCK_SIZE;
const extern __prog__ uint8_t _FLASH_TOP;
const extern __prog__ uint8_t _CONFIG_WORDS_BASE;
const extern __prog__ uint8_t _CONFIG_WORDS_TOP;

#define LINKER_VAR(X) (((uint32_t) &_##X) & 0x00ffffff)
/* "Constants" for linker script values. These are assigned in main() using the
 * LINKER_VAR() macro. See the above comment for rationale. */
static uint32_t IVT_MAP_BASE;
static uint32_t APP_BASE;
static uint32_t APP_LENGTH;
static uint32_t FLASH_BLOCK_SIZE;
static uint32_t FLASH_TOP;
static uint32_t CONFIG_WORDS_BASE;
static uint32_t CONFIG_WORDS_TOP;

/* Flash block(s) where the bootloader resides.*/
#define USER_REGION_BASE  IVT_MAP_BASE
#define USER_REGION_TOP   (FLASH_TOP - FLASH_BLOCK_SIZE) /* The last page has the config words. Don't clear that one*/


/* Instruction sizes */
#ifdef __PIC24F__
	#define INSTRUCTIONS_PER_ROW 64
	#define BYTES_PER_INSTRUCTION 4
	#define WORDS_PER_INSTRUCTION 2
#else
	#error "Define instruction sizes for your platform"
#endif

#define BUFFER_LENGTH (INSTRUCTIONS_PER_ROW * WORDS_PER_INSTRUCTION)

/* Protocol commands */
#define CLEAR_FLASH 100
#define SEND_DATA 101
#define GET_CHIP_INFO 102
#define REQUEST_DATA 103
#define SEND_RESET 105

/* I2C commands */
#define WRITE_I2C_DATA 110
#define READ_I2C_DATA 111
#define CHECK_I2C_READY 112

struct chip_info {
	uint32_t user_region_base;
	uint32_t user_region_top;
	uint32_t config_words_base;
	uint32_t config_words_top;

	uint8_t bytes_per_instruction;
	uint8_t instructions_per_row;
	uint8_t pad0;
	uint8_t pad1;
};

/* Data-to-program: buffer and attributes. */
static uint32_t write_address; /* program space word address */
static size_t write_length;    /* number of words, not bytes */
static uint16_t prog_buf[BUFFER_LENGTH];
static uint8_t i2c_on;

static struct chip_info chip_info = { };

void clear_flash()
{
	uint32_t prog_addr = USER_REGION_BASE;
	size_t offset;

	/* Clear each flash block. TBLPAG/offset is set to the
	 * base address (lowest address) of each block. */
	while (prog_addr < USER_REGION_TOP) {
		TBLPAG = prog_addr >> 16;
		offset = prog_addr & 0xffff;

		__builtin_tblwtl(offset, 0x00);
		NVMCON = 0x4042;
		asm("DISI #5");
		__builtin_write_NVM();

		while (NVMCONbits.WR == 1)
			;

		prog_addr += FLASH_BLOCK_SIZE;
	}
}

void write_flash_row()
{
	size_t offset;
	uint8_t i;
	uint32_t prog_addr = write_address;

	NVMCON = 0x4001;
	TBLPAG = prog_addr >> 16;
	offset = prog_addr & 0xffff;

	/* Write the data provided */
	for (i = 0; i < write_length; i++) {
		__builtin_tblwtl(offset, prog_buf[i]);
		__builtin_tblwth(offset, prog_buf[++i]);
		offset += 2;
	}

	/* Pad the rest of the row out with 0xff */
	for (; i < BUFFER_LENGTH; i += 2) {
		__builtin_tblwtl(offset, 0xffff);
		__builtin_tblwth(offset, 0xffff);
		offset += 2;
	}

	asm("DISI #5");
	__builtin_write_NVM();

	while (NVMCONbits.WR == 1)
		;
}

/* Read an instruction from flash. word_addr is the word address, not
 * the byte address. */
static void read_flash(uint32_t word_addr, uint16_t *low, uint16_t *high)
{
	TBLPAG = word_addr >> 16 & 0xff;
	*high = __builtin_tblrdh(word_addr & 0xffff);
	*low  = __builtin_tblrdl(word_addr & 0xffff);
}

/* Read data starting at prog_addr into the global prog_buf. prog_addr
 * and len are in words, not bytes. */
static void read_prog_data(uint32_t prog_addr, uint32_t len/*words*/)
{
	int i;
	for (i = 0; i < len; i += 2) {
		read_flash(prog_addr + i,
		           &prog_buf[i]   /*low*/,
		           &prog_buf[i+1] /*high*/);
	}
}


static int8_t write_i2c(uint8_t device_address, uint8_t* buffer, uint16_t len) {
	return write_i2c_block(device_address,buffer,len);
}


static int8_t check_i2c_ready(uint8_t device_address) {
	IdleI2C1();
	StartI2C1();
	IdleI2C1();
	MasterWriteI2C1((device_address * 2));       //Write Slave address and set master for transmission
	IdleI2C1();
	if(I2C1STATbits.ACKSTAT) {
		StopI2C1();
		IdleI2C1();
		return -1;
	}
	StopI2C1();
	IdleI2C1();
	return 0;
}


uint8_t reverse(uint8_t b) {
   b = (b & 0xF0) >> 4 | (b & 0x0F) << 4;
   b = (b & 0xCC) >> 2 | (b & 0x33) << 2;
   b = (b & 0xAA) >> 1 | (b & 0x55) << 1;
   return b;
}

void display_show_bat(int charge) {
	static int counter = 0;
	int i;
	// set page and column to top right
	char bat_status[24];
	if (charge==-1) {
		charge = counter;
		counter++;
		if (counter>18) counter = 0;
	}
	bat_status[0] = 0xf8;
	bat_status[1] = 0x04;
	memset(&bat_status[2],0xf4,charge);
	memset(&bat_status[2+charge],0x04,19-charge);
	bat_status[21] = 0xf8;
	bat_status[22] = 0x20;
	bat_status[23] = 0xC0;
	render_data_to_page(0,104,bat_status,24);
	for (i = 0; i< 24; ++i) {
		bat_status[i] = reverse(bat_status[i]);
	}
	render_data_to_page(1,104,bat_status,24);
}


void __attribute__ ((interrupt,no_auto_psv,shadow)) _USB1Interrupt() {
	U1OTGIEbits.SESVDIE = 0;
	IEC5bits.USB1IE = 0;
	__asm__("reset");
}

int main(void)
{
	uint32_t pll_startup_counter = 600;
	int display_initialised = 0;
	int counter = 0;
	enum BAT_STATUS bat_status;
	
	IVT_MAP_BASE = LINKER_VAR(IVT_MAP_BASE);
	APP_BASE = LINKER_VAR(APP_BASE);
	APP_LENGTH = LINKER_VAR(APP_LENGTH);
	FLASH_BLOCK_SIZE = LINKER_VAR(FLASH_BLOCK_SIZE);
	FLASH_TOP = LINKER_VAR(FLASH_TOP);
	CONFIG_WORDS_BASE = LINKER_VAR(CONFIG_WORDS_BASE);
	CONFIG_WORDS_TOP = LINKER_VAR(CONFIG_WORDS_TOP);
	ReleaseDeepSleep();
	/* setup ports */
	/* enable peripherals */
	TRISBbits.TRISB14 = 0;
	LATBbits.LATB14 = 0;
	TRISBbits.TRISB1 = 0;
	LATBbits.LATB1 = 0;

	/* first look to see if we should be running bootloader at all... */
	CLKDIVbits.PLLEN = 1;
	while(pll_startup_counter--);

	i2c_init();
	display_init();
	display_clear_screen();
	usb_init();
	__delay_ms(3);
	while (1) {
		bat_status = get_bat_status();
		if (bat_status==DISCHARGING) break;
		counter++;
		if ((counter & 0x3fff)==0) {
			// only update display every 32 cycles
			if (bat_status==CHARGING) display_show_bat(-1);
			if (bat_status==CHARGED) display_show_bat(18);
		}
		usb_service();
	}
	LATBbits.LATB1 = 1; //turn laser on to indicate startup...
	/* set up a reset that will fire when USB connected... */
	U1OTGIEbits.SESVDIE = 1;
	IEC5bits.USB1IE = 1;
	/* Jump to application */
	__asm__("goto %0"
		: /* no outputs */
		: "r" (IVT_MAP_BASE)
		: /* no clobber*/);

	return 0;
}

static void empty_cb(bool transfer_ok, void *context)
{
	/* Nothing to do here. */
}

static void reset_cb(bool transfer_ok, void *context)
{
	/* Delay before resetting*/
	uint16_t i = 65535;
	while(i--)
		;

	asm("reset");
}

static void write_data_cb(bool transfer_ok, void *context)
{
	/* For OUT control transfers, data from the data stage of the request
	 * is in buf[]. */

	if (transfer_ok)
		write_flash_row();
}

static void write_i2c_cb(bool transfer_ok, void *context)
{
	/* For OUT control transfers, data from the data stage of the request
	 * is in buf[]. */

	if (transfer_ok)
		write_i2c(write_address,(char*)prog_buf,write_length);
}


int8_t app_unknown_setup_request_callback(const struct setup_packet *setup)
{
#define MIN(X,Y) ((X)<(Y)?(X):(Y))

	/* This handler handles request 254/dest=other/type=vendor only.*/
	if (setup->REQUEST.destination == DEST_OTHER_ELEMENT &&
	    setup->REQUEST.type == REQUEST_TYPE_VENDOR &&
	    setup->REQUEST.direction == 0/*OUT*/) {

		if (setup->bRequest == CLEAR_FLASH) {
			/* Clear flash Request */
			clear_flash();
			
			/* There will be NO data stage. This sends back the
			 * STATUS stage packet. */
			usb_send_data_stage(NULL, 0, empty_cb, NULL);
		}
		else if (setup->bRequest == SEND_DATA) {
			/* Write Data Request */
			if (setup->wLength > sizeof(prog_buf))
				return -1;

			write_address = setup->wValue | ((uint32_t) setup->wIndex) << 16;
			write_address /= 2; /* Convert to word address. */
			write_length = setup->wLength;
			write_length /= 2;  /* Convert to word length. */

			/* Make sure it is within writable range (ie: don't
			 * overwrite the bootloader or config words). */
			if (write_address < USER_REGION_BASE)
				return -1;
			if (write_address + write_length > USER_REGION_TOP)
				return -1;

			/* Check for overflow (unlikely on known MCUs) */
			if (write_address + write_length < write_address)
				return -1;

			/* Check length */
			if (setup->wLength > sizeof(prog_buf))
				return -1;

			memset(prog_buf, 0xff, sizeof(prog_buf));
			usb_start_receive_ep0_data_stage((char*)prog_buf, setup->wLength, &write_data_cb, NULL);
		}
		else if (setup->bRequest == SEND_RESET) {
			/* Reset to Application Request*/

			/* There will be NO data stage. This sends back the
			 * STATUS stage packet. */
			usb_send_data_stage(NULL, 0, reset_cb, NULL);
		}
		else if (setup->bRequest == WRITE_I2C_DATA) {
			write_address = setup->wValue;

			/* Check length */
			if (setup->wLength > sizeof(prog_buf))
				return -1;

			if (check_i2c_ready(write_address))
				return -1;
			write_length = setup->wLength;
			usb_start_receive_ep0_data_stage((char*)prog_buf, setup->wLength, &write_i2c_cb, NULL);
		}
	}

	if (setup->REQUEST.destination == DEST_OTHER_ELEMENT &&
	    setup->REQUEST.type == REQUEST_TYPE_VENDOR &&
	    setup->REQUEST.direction == 1/*IN*/) {

		if (setup->bRequest == GET_CHIP_INFO) {
			/* Request Device Info Struct */
			chip_info.user_region_base = USER_REGION_BASE * 2;
			chip_info.user_region_top = USER_REGION_TOP * 2;
			chip_info.config_words_base = CONFIG_WORDS_BASE * 2;
			chip_info.config_words_top = CONFIG_WORDS_TOP * 2;

			chip_info.bytes_per_instruction = BYTES_PER_INSTRUCTION;
			chip_info.instructions_per_row = INSTRUCTIONS_PER_ROW;

			usb_send_data_stage((char*)&chip_info, sizeof(struct chip_info), empty_cb/*TODO*/, NULL);
		}

		if (setup->bRequest == REQUEST_DATA) {
			/* Request program data */
			uint32_t read_address;

			read_address = setup->wValue | ((uint32_t) setup->wIndex) << 16;
			read_address /= 2;

			/* Range-check address */
			if (read_address + setup->wLength > FLASH_TOP)
				return -1;

			/* Check for overflow (unlikely on known MCUs) */
			if (read_address + setup->wLength < read_address)
				return -1;

			/* Check length */
			if (setup->wLength > sizeof(prog_buf))
				return -1;

			
			read_prog_data(read_address, setup->wLength / 2);
			usb_send_data_stage((char*)prog_buf, setup->wLength, empty_cb/*TODO*/, NULL);
		}
		else if (setup->bRequest == READ_I2C_DATA) {
			write_address = setup->wValue;
			if (setup->wLength > sizeof(prog_buf))
 				return -1;
			if (read_i2c_block(setup->wValue,(uint8_t*)prog_buf,setup->wLength))
			    /* read failed */
				return -1;
			usb_send_data_stage((char*)prog_buf, setup->wLength, empty_cb/*TODO*/, NULL);
		}
		else if (setup->bRequest == CHECK_I2C_READY) {
			write_address = setup->wValue;
			if (setup->wLength > 1)
				return -1;
			if (check_i2c_ready(write_address)) {
				prog_buf[0]=0;
			} else {
				prog_buf[0]=1;
			}
			usb_send_data_stage((char*)prog_buf, setup->wLength, empty_cb/*TODO*/, NULL);			
		}
	}

	return 0; /* 0 = can handle this request. */
#undef MIN
}

void app_usb_reset_callback(void)
{

}
