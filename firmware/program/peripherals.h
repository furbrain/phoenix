#ifndef PERIPHERALS_H
#define PERIPHERALS_H
#include <stdbool.h>
#include <stdint.h>
#include <ports.h>

#define TRIS_LIDAR_ENABLE TRISBbits.TRISB5
#define LAT_LIDAR_ENABLE LATBbits.LATB5

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

#define TRIS_BAT_STATUS TRISAbits.TRISA4
#define LAT_BAT_STATUS LATAbits.LATA4
#define PORT_BAT_STATUS PORTAbits.RA4

#define TRIS_BAT_CHARGE TRISBbits.TRISB13

#define TRIS_SENSOR_INT TRISBbits.TRISB15
#define PORT_SENSOR_INT PORTBbits.RB15

#define TRIS_NC_1 TRISBbits.TRISB2
#define TRIS_NC_2 TRISBbits.TRISB4

#define TRIS_BUTTON TRISBbits.TRISB7
#define PORT_BUTTON PORTBbits.RB7

void setup_pins();

void peripherals_on(bool on);

#ifndef BOOTLOADER
void peripherals_init();

void laser_on(bool on);

void laser_set_day(bool day);
void beep(uint16_t freq, uint16_t ms);
void beep_on(uint16_t freq);
void beep_off();
#endif
#endif