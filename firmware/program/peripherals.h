#ifndef PERIPHERALS_H
#define PERIPHERALS_H
#include <stdbool.h>
#include <stdint.h>

void peripherals_init();

void peripherals_on(bool on);

void laser_on(bool on);

void laser_set_brightness(uint8_t brightness);

void beep(double freq, uint16_t ms);

#endif