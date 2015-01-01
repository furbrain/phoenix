#define USE_AND_OR
#define FCY 16000000
#include <libpic30.h>
#include <stdint.h>
#include <timer.h>
#include <ports.h>
#include <stdio.h>
#include "interface.h"
#include "sensors.h"
#include "display.h"
#include "power.h"

#define scroll_text(index,direction) display_scroll_text(2,0,menu_items[index].text,&large_font,direction)
#define delay_ms(delay) __delay_ms(delay)


struct menu_entry {
	int16_t index;
	const char* text;
	int16_t next_menu; /* start of next menu (or this menu if text NULL */
	void (*action) (void); /*action to perform when selected */
};


volatile enum ACTION last_click;

void measure() {}
void quick_cal() {}
void full_cal() {}
void laser_cal() {}
void set_metric() {}
void set_imperial() {}
void set_cartesian() {}
void set_polar() {}
void set_grad() {}
void set_day() {}
void set_night() {}

/* a null-terminated list of menu_entries */
const struct menu_entry menu_items[] = {
	/* main menu */
	{-2,NULL,0,NULL},
	{0,"Measure",-1,measure},
	{1,"Calibrate",10,NULL},
	{2,"Settings",20,NULL},
	{3,"Off",-1,hibernate},
	{4,NULL,0,NULL},
	
	/* calibrate menu */
	{10,"Quick",-1,quick_cal},
	{11,"Laser",-1,laser_cal},
	{12,"Full",-1,full_cal},
	{13,NULL,10,NULL},
	
	/* settings menu */
	{20,"Units",30,NULL},
	{21,"Function",40,NULL},
	{22,"Display",50,NULL},
	{23,NULL,20,NULL},
	
	/* Units menu */
	{30,"Metric",-1,set_metric},
	{31,"Imperial",-1,set_imperial},
	{32,NULL,30,NULL},
	
	/* Function menu */
	{40,"Cartesian",-1,set_cartesian},
	{41,"Polar",-1,set_polar},
	{42,"Grad",-1,set_grad},
	{43,NULL,40,NULL},
	
	/* Display menu */
	{50,"Day",-1,set_day},
	{51,"Night",-1,set_night},
	{52,NULL,50,NULL},
	
	/*end */
	{-1,NULL,-1,NULL}
};

/* set up timer interrupts etc */
/* Timer 2 is click-to-click counter */
/* timer 3 is click length counter */
void interface_init() {
    OpenTimer2(T2_ON | T2_IDLE_CON | T2_PS_1_256 | T2_32BIT_MODE_OFF,0xFFFF);
    OpenTimer3(T3_ON | T3_IDLE_CON | T3_PS_1_256 ,0xFFFF);
    // enable CN23 interrupt
    ConfigIntCN(INT_ENABLE | INT_PRI_3);
    EnableCN23;
    WriteTimer2(0);
    WriteTimer3(0);
}

/* change notification interrupt */
void __attribute__ ((interrupt,no_auto_psv,shadow)) _CNInterrupt() {
    InputChange_Clear_Intr_Status_Bit;
    if (!PORTBbits.RB7) {
        /* it's a release */
        /* if timer3 has interrupted, then this was a long click */
        if (IFS0bits.T3IF) {
            last_click = LONG_CLICK;
        }        
    } else {
        /* it's a press */
        /* if timer2 has *not* interrupted then this is a double click */
        if (!IFS0bits.T2IF) {
            last_click = DOUBLE_CLICK;
        } else {
            /* if it has interrupted already, then we are looking at a new single click */
            /* which could alter become a double click */
            last_click = SINGLE_CLICK;
        }        
        /* reset timers */
        WriteTimer2(0);
        WriteTimer3(0);
        T2_Clear_Intr_Status_Bit;
        T3_Clear_Intr_Status_Bit;
    }
}

/* get the offset of the menu_item with the specified index */
/* return -1 if index not found */
int16_t get_menu_item_offset(int16_t index) {
	int16_t i;
	for (i = 0; menu_items[i].index != -1; ++i) {
		if (menu_items[i].index==index) return i;
	}
	return -1;
}

/* return index of previous menu item, rotate onto last menu item if currently on first item */
int16_t get_previous_menu_item(int16_t index) {
	if (menu_items[index-1].text) return index-1;
	while (menu_items[index+1].text) index++;
	return index;
}

/* return index of next menu item, rotating onto first menu item if currently on last item */
int16_t get_next_menu_item(int16_t index) {
	if (menu_items[index+1].text) {
		return index+1;
	} else {
		return get_menu_item_offset(menu_items[index+1].next_menu);
	}
}

enum ACTION get_action() {
	struct COOKED_SENSORS sensors;
	enum ACTION temp;
	
	sensors_read_cooked(&sensors,false);
	/* look for "flip" movements */
	if (sensors.gyro[0]>40.0) {
		return display_inverted? FLIP_LEFT : FLIP_RIGHT;
	}
	if (sensors.gyro[0]<-40.0) {
		return display_inverted? FLIP_RIGHT : FLIP_LEFT;
	}
	if (sensors.gyro[1]>40.0) {
		return display_inverted? FLIP_DOWN : FLIP_UP;
	}
	if (sensors.gyro[1]<-40.0) {
		return display_inverted? FLIP_UP : FLIP_DOWN;
	}
	/* check to see if display needs flipping */
	/* use 0.5g - gives a hysteresis of about +/- 30 degrees */
	if ((sensors.accel[0]>0.5) && display_inverted) display_flip(false);
	if ((sensors.accel[0]<-0.5) && !display_inverted) display_flip(true);
	/* search for a click */
	if (last_click != NONE) {
		/* momentarily disable interrupts */
		__builtin_disi(0x0100);
		temp = last_click;
		last_click = NONE;
		__builtin_disi(0x0000);
		return temp;
	}
	//nothing else found - so return NONE
	return NONE;
}

bool show_menu(int16_t index, bool first_time) {
    enum ACTION action;
    bool result;
    if (first_time) {
        scroll_text(index,true);
    } else {
        scroll_text(index,true);
    }
    while(true) {
        delay_ms(700);
        action = get_action();
        switch(action){
            case FLIP_DOWN:
                index = get_previous_menu_item(index);
                scroll_text(index,false);
                break;
            case FLIP_UP:
                index = get_next_menu_item(index);
                scroll_text(index,true);
                break;
            case FLIP_RIGHT:
            case SINGLE_CLICK:
                if (menu_items[index].next_menu != -1) {
                    result = show_menu(get_menu_item_offset(menu_items[index].next_menu),false);
                    //display_scroll_text(2,0,"ACTION",&large_font,false);
                    //result = false;
                } else {
                    if (action==SINGLE_CLICK){
                        menu_items[index].action();
                        result = true;
                    } else continue;
                }
                if (result) {
                    if (first_time) {
                        index = FIRST_MENU_ITEM;
                        display_clear_screen();
                        scroll_text(index,true);
                    } else {
                        return true;   
                    }
                } else {
                    //FIXME swipe_text(index,false);
                }
                break;
            case FLIP_LEFT:
                if (!first_time) return false;
                break;
            }   
    }
}
