#include "config.h"
#include <libpic30.h>
#include "display.h"
#include "font.h"
#include "interface.h"


void quick_cal() {}
void laser_cal() {}

void align_cal() {
	int on = 0;
	display_clear_screen();  //0123456789ABCDEF  0123456789  0123456789   0123456789ABCDEF
	display_write_multiline(0,"FACTORY USE ONLY\nAlign LIDAR with\nthe laser.\nPress the Button",&small_font);
	while(get_action()!=SINGLE_CLICK) {
		laser_on(on/4); //on 4*125ms
		on = (on+1) % 8;
		__delay_ms(125);
	}
}

void full_cal() {}
