#define USE_AND_OR
#include "config.h"
#include <outcompare.h>
#include <ports.h>
#include <PPS.h>
#include <libpic30.h>
#include <Rtcc.h>
#include <stdio.h>
#include "peripherals.h"

#define LASER_DAY_BRIGHTNESS 0xff
#define LASER_NIGHT_BRIGHTNESS 0x30

uint8_t laser_brightness = LASER_NIGHT_BRIGHTNESS;

void setup_pins() {
	//set TRIS settings
	TRIS_LIDAR_ENABLE = 0;
	LAT_LIDAR_ENABLE = 0;	
	TRIS_PERIPHERALS  = 0;
	LAT_PERIPHERALS = 0;
	TRIS_LASER = 0;
	LAT_LASER = 1;
	TRIS_BUZZER_A = 0;
	TRIS_BUZZER_B = 0;
	TRIS_BAT_STATUS = 1;
	TRIS_BAT_CHARGE = 1;
	TRIS_BUTTON = 1;
	TRIS_NC_1 = 0;
	TRIS_NC_2 = 1;
}

void peripherals_on(bool on) {
	LAT_PERIPHERALS = !on;
}
#ifndef BOOTLOADER
void peripherals_init() {
	//connect peripherals
	iPPSOutput(RP_LASER,OUT_FN_PPS_OC3);
	iPPSOutput(RP_BUZZER_A,OUT_FN_PPS_OC1);
	iPPSOutput(RP_BUZZER_B,OUT_FN_PPS_OC2);
	
	//turn on clock
	RtccInitClock(); //turn on clock source
	RtccWrOn(); //unlock writes to RTCC control register
	mRtccOn(); //enable RTCC peripheral
	
	laser_on(true);

}

void laser_on(bool on) {
	if (on) {
		OpenOC3(OC_SYSCLK_SRC | OC_PWM_EDGE_ALIGN,OC_SYNC_ENABLE | OC_SYNC_TRIG_IN_CURR_OC, 0xFF,laser_brightness);
	} else {
		CloseOC3();
		LAT_LASER = 1;
	}
}

void laser_set_day(bool day){
	if (day) {
		laser_brightness = LASER_DAY_BRIGHTNESS;
	} else {
		laser_brightness = LASER_NIGHT_BRIGHTNESS;
	}
	OpenOC3(OC_SYSCLK_SRC | OC_PWM_EDGE_ALIGN,OC_SYNC_ENABLE | OC_SYNC_TRIG_IN_CURR_OC, 0xFF,laser_brightness);
}

void beep_on(uint16_t freq) {
	uint16_t period;
	uint16_t duty;
	period =(uint16_t)(FCY/freq);
	duty = period/2;
	//debug("%d %d",duty,period);
	OpenOC1(OC_SYSCLK_SRC | OC_PWM_EDGE_ALIGN,OC_SYNC_ENABLE | OC_SYNC_TRIG_IN_CURR_OC, period, duty);
	OpenOC2(OC_SYSCLK_SRC | OC_PWM_EDGE_ALIGN,OC_SYNC_ENABLE | OC_SYNC_TRIG_IN_OC1 | OC_OUT_INVERT, period, duty);
}

void beep_off() {
	CloseOC1();
	CloseOC2();
}

void beep(uint16_t freq, uint16_t ms) {
	beep_on(freq);
	__delay_ms(ms);
	beep_off();
}
#endif