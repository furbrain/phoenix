#ifndef CONFIG_H
#define CONFIG_H
#define USE_AND_OR
#define FCY 16000000L
#define FCY_PER_MS 16000L //this is useful where working with 16-bit numbers

#define FIRMWARE_VERSION 1
#include <stdint.h>
#include <stdbool.h>

enum DISPLAY_STYLE {
    UNINITIALISED = 0,
    POLAR,
    GRAD,
    CARTESIAN
};

enum LENGTH_UNITS {
    METRIC,
    IMPERIAL
};

struct CONFIG {
    struct {
        float accel[3][3];
        float mag[3][3];
        float laser_offset;
    } calib;
    uint8_t display_style;
    uint8_t length_units;
};

struct LEG {
    /* date/time encoded in BCD format */
    struct {
        uint8_t year;
        uint8_t month;
        uint8_t day;
        uint8_t hour;
        uint8_t minute;
        uint8_t second;
    } dt;        //6 bytes
    /* leg count */
    uint16_t number; //2 bytes
    /* differential readings, stored as multiples of 0.25cm */
    int16_t delta[3]; //6 bytes
    uint16_t pad; //2 bytes - pads out record to total of 16 bytes
};

#ifndef BOOTLOADER
extern struct CONFIG config;

extern uint16_t current_leg;

extern bool day;

void config_init();
void config_save();

void set_metric();
void set_imperial();
void set_cartesian();
void set_polar();
void set_grad();
void set_day();
void set_night();

#endif
#endif
