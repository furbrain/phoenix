#define USE_AND_OR
#include "config.h"
#include <outcompare.h>
#include <ports.h>
#include <PPS.h>
#include <libpic30.h>
#include <Rtcc.h>
#include <stdio.h>
#include "peripherals.h"
#include "font.h"
#include "debug.h"
#define TRIS_PERIPHERALS TRISBbits.TRISB14
#define LAT_PERIPHERALS LATBbits.LATB14

#define TRIS_LASER TRISBbits.TRISB0
#define LAT_LASER LATBbits.LATB0
#define RP_LASER OUT_PIN_PPS_RP0
#define PWM_LASER OUT_FN_PPS_OC3

#define TRIS_BUZZER_A TRISBbits.TRISB1
#define RP_BUZZER_A OUT_PIN_PPS_RP1
#define PWM_BUZZER_A OUT_FN_PPS_OC1

#define TRIS_BUZZER_B TRISBbits.TRISB3
#define RP_BUZZER_B OUT_PIN_PPS_RP3
#define PWM_BUZZER_B OUT_FN_PPS_OC2

#define TRIS_BAT_STATUS TRISBbits.TRISB5
#define PORT_BAT_STATUS PORTBbits.RB5

#define TRIS_NC_1 TRISBbits.TRISB2
#define TRIS_NC_2 TRISBbits.TRISB4
#define TRIS_NC_3 TRISAbits.TRISA4

#define LASER_DAY_BRIGHTNESS 0xff
#define LASER_NIGHT_BRIGHTNESS 0x30

uint8_t laser_brightness = LASER_NIGHT_BRIGHTNESS;

void peripherals_init() {
	//set TRIS settings
	TRIS_PERIPHERALS  = 0;
	TRIS_LASER = 0;
	LAT_LASER = 0;
	TRIS_BUZZER_A = 0;
	TRIS_BUZZER_B = 0;
	TRIS_BAT_STATUS = 1;
	TRIS_NC_1 = 0;
	TRIS_NC_2 = 1;
	TRIS_NC_3 = 0;
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

void peripherals_on(bool on) {
	LAT_PERIPHERALS = !on;
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
