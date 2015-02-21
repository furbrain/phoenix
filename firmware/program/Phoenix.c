/* Template source file generation only partially implemented. */
/* ----------------------------------------------------------------------- */
/* Template source file generated by piklab */
#include "config.h"

#define USE_AND_OR
#include <libpic30.h>
#include <timer.h>
#include "display.h"
#include "font.h"
#include "sensors.h"
#include "interface.h"
#include "peripherals.h"
#include "battery.h"



void main(){
	TRIS_BUTTON = 1;
	OpenTimer45(T45_ON | T45_IDLE_CON | T45_PS_1_256 | T4_32BIT_MODE_ON,0xFFFFFFFFL);
	WriteTimer45(0);
	interface_init();
	while (last_click==NONE) {
		if (ReadTimer45()>0x20000L) {
			/* has taken too long to release the button */
			hibernate();
		}
	}
	last_click = NONE;
	WriteTimer45(0);
    //make sure we get a second confirmation press...
	while (last_click==NONE) {
		if (ReadTimer45()>0x20000L) {
			/* has taken too long to release the button */
			hibernate();
		}
	}
	last_click = NONE;
	CloseTimer45();
    //various init functions
	peripherals_init();
	peripherals_on(true);
	config_init();
	//display_init();
	sensors_init();
	interface_init();
	display_clear_screen();
	//hello
	beep(1000,50);
	beep(2000,50);
	beep(3000,50);
	beep(4000,50);
	
	while(true) show_menu(FIRST_MENU_ITEM,true);
}
