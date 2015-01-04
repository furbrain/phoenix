#define USE_AND_OR
#include "config.h"

#define USE_AND_OR
#include <libpic30.h>
#include "battery.h"
#include <adc.h>
#include <stdint.h>
#define TRIS_BAT_STATUS TRISBbits.TRISB5
#define LAT_BAT_STATUS LATBbits.LATB5
#define PORT_BAT_STATUS PORTBbits.RB5

#define TRIS_BAT_CHARGE TRISBbits.TRISB13
#define ADC_BAT_CHARGE 11
#define ADC_BAT_CHANNEL ADC_CH0_POS_SAMPLEA_AN11

enum BAT_STATUS get_bat_status(){
	TRIS_BAT_STATUS = 1;
	if (PORT_BAT_STATUS) {
		/* either discharging or fully charged */
		TRIS_BAT_STATUS = 0;
		LAT_BAT_STATUS = 0;
		TRIS_BAT_STATUS = 1;
		if (PORT_BAT_STATUS) {
			/* fully charged */
			return CHARGED;
		} else {
			return DISCHARGING;
		}
	} else {
		/* either discharging or charging */
		TRIS_BAT_STATUS = 0;
		LAT_BAT_STATUS = 1;
		TRIS_BAT_STATUS = 1;
		if (!PORT_BAT_STATUS) {
			/* fully charged */
			return CHARGING;
		} else {
			return DISCHARGING;
		}
	}
}

double get_bat_charge(){
	uint16_t ports = 0x7FFF; //enable band-gap reference
	uint16_t scans;
	double bat_voltage,bg;
	ports ^= 1 << ADC_BAT_CHARGE; //and enable the relevant channel
	TRIS_BAT_CHARGE = 1;
	CloseADC10();
	/*set adc channel*/
	SetChanADC10(ADC_BAT_CHANNEL | 0x0f00);
	/*Configure adc*/
	OpenADC10(ADC_MODULE_OFF | ADC_CLK_AUTO | ADC_AUTO_SAMPLING_ON,
		  ADC_SCAN_ON | ADC_VREF_AVDD_AVSS | ADC_INTR_2_CONV , 
	          ADC_SAMPLE_TIME_1 | ADC_CONV_CLK_2Tcy,
		  ports,
		  0x8800);
	EnableADC1;
	ConvertADC10(); // read from voltage divider
	while(BusySampADC1); /*wait till conversion complete*/
	bat_voltage = ReadADC10(0);
	__delay_ms(1);
	ConvertADC10(); // now read band-gap reference from voltage B
	while(BusySampADC1); /*wait till conversion complete*/
	bg = ReadADC10(1);
	CloseADC10();
	return (2.0*bat_voltage)/(bg/1.2); //multiply by two as voltage has been halved, 1.2 is bandgap voltage.
}
