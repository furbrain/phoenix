#ifndef PERIPHERALS_H
#define PERIPHERALS_H
#include <stdbool.h>
#include <stdint.h>

void peripherals_init();

void peripherals_on(bool on);

void laser_on(bool on);

void laser_set_day(bool day);

void beep(uint16_t freq, uint16_t ms);
void beep_on(uint16_t freq);
void beep_off();
#endif