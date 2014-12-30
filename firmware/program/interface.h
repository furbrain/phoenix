#ifndef INTERACE_H
#define INTERFACE_H
#include <stdint.h>
#include <stdbool.h>
#define FIRST_MENU_ITEM 1
enum ACTION {
    NONE = 0,
    FLIP_DOWN,
    FLIP_UP,
    FLIP_LEFT,
    FLIP_RIGHT,
    SINGLE_CLICK,
    LONG_CLICK,
    DOUBLE_CLICK
};


enum ACTION get_action();
bool show_menu(int16_t index, bool first_time);
#endif
