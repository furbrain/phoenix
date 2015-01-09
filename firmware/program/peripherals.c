#define USE_AND_OR
#include "config.h"
#include "peripherals.h"
#include <outcompare.h>
#include <ports.h>
#include <PPS.h>
#include <libpic30.h>
#include <Rtcc.h>

#define TRIS_PERIPHERALS TRISBbits.TRISB14
#define LAT_PERIPHERALS LATBbits.LATB14

#define TRIS_LASER TRISBbits.TRISB1
#define RP_LASER OUT_PIN_PPS_RP1
#define PWM_LASER OUT_FN_PPS_OC3

#define TRIS_BUZZER_A TRISBbits.TRISB0
#define RP_BUZZER_A OUT_PIN_PPS_RP0
#define PWM_BUZZER_A OUT_FN_PPS_OC1

#define TRIS_BUZZER_B TRISBbits.TRISB3
#define RP_BUZZER_B OUT_PIN_PPS_RP3
#define PWM_BUZZER_B OUT_FN_PPS_OC2

#define TRIS_BAT_STATUS TRISBbits.TRISB5
#define PORT_BAT_STATUS PORTBbits.RB5

#define TRIS_NC_1 TRISBbits.TRISB2
#define TRIS_NC_2 TRISBbits.TRISB4
#define TRIS_NC_3 TRISAbits.TRISA4
uint8_t laser_brightness = 0x30;

void peripherals_init() {
	//set TRIS settings
	TRIS_PERIPHERALS  = 0;
	TRIS_LASER = 0;
	TRIS_BUZZER_A = 0;
	TRIS_BUZZER_B = 0;
	TRIS_BAT_STATUS = 1;
	TRIS_NC_1 = 0;
	TRIS_NC_2 = 0;
	TRIS_NC_3 = 0;
	//connect peripherals
	iPPSOutput(RP_LASER,OUT_FN_PPS_OC3);
	iPPSOutput(RP_BUZZER_A,OUT_FN_PPS_OC1);
	iPPSOutput(RP_BUZZER_B,OUT_FN_PPS_OC2);
	
	//turn on clock
	RtccInitClock(); //turn on clock source
	RtccWrOn(); //unlock writes to RTCC control register
	mRtccOn(); //enable RTCC peripheral

}

void peripherals_on(bool on) {
	LAT_PERIPHERALS = !on;
}

void laser_on(bool on) {
	if (on) {
		laser_set_brightness(laser_brightness);
	} else {
		CloseOC3();
	}
}

void laser_set_brightness(uint8_t brightness){
	OpenOC3(OC_SYSCLK_SRC | OC_PWM_EDGE_ALIGN,OC_SYNC_ENABLE | OC_SYNC_TRIG_IN_CURR_OC, 0xFF,laser_brightness);
}

void beep(double freq, uint16_t ms) {
	int period = FCY/freq;
	int duty = period/2;
	OpenOC1(OC_SYSCLK_SRC | OC_PWM_EDGE_ALIGN,OC_SYNC_ENABLE | OC_SYNC_TRIG_IN_CURR_OC, freq, duty);
	OpenOC2(OC_SYSCLK_SRC | OC_PWM_EDGE_ALIGN,OC_SYNC_ENABLE | OC_SYNC_TRIG_IN_OC1 | OC_OUT_INVERT, freq, duty);
	__delay_ms(ms);
}
