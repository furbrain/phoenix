#ifndef PERIPHERALS_H
#define PERIPHERALS_H
#include <stdbool.h>
#include <stdint.h>

enum BAT_STATUS {
	BAT_CHARGING,
	BAT_CHARGED,
	BAT_NO_CHARGE
};

void peripherals_init();

void peripherals_on(bool on);

void laser_on(bool on);

void laser_set_brightness(uint8_t brightness);

void beep(double freq, uint16_t ms);

enum BAT_STATUS get_bat_status();

uint8_t get_battery_charge();
#endif