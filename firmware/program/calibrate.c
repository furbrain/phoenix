#include "config.h"
#include <libpic30.h>
#include "display.h"
#include "font.h"
#include "interface.h"
#include "sensors.h"
#include "debug.h"


void quick_cal() {
/* Brief summary of plan:
 * First place the device flat on the ground and leave alone
 * This allows us to calibrate zero-offsets for gyros*/
/* Now rotate around z-axis
 * do first magnetic calibration */
/* read in 400 or so readings while rotating */
/* find min/max for each of x and y  - this is the zero offset
 * offx = (minx+maxx)/2
 * offy = (miny+maxy)/2
 * axisx = 0
 * axisy = 0
 * minaxis = 0
 * for i in readings
	* x = readings[i].x-offx
	* y = readings[i].y-offy
	* hyp = x*x+y*y
	* if hyp>minaxis
		* axisx = x
		* axisy = y
		* minaxis = hyp
/* Now rotate around y-axis, keeping laser fixed on one point
 * this allows us to first calibrate magnetics and then calculate
 * direction of laser beam.
 */
 /* nor rotate around z-axis - allows calibration of y axis accelerometer */
}
void laser_cal() {}

void align_cal() {
	int on = 0;
	int32_t length;
	bool beeping = false;
	lidar_average_count = 8;
	display_clear_screen();  //0123456789ABCDEF  0123456789  0123456789   0123456789ABCDEF
	display_write_multiline(0,"FACTORY USE ONLY\n"
				  "Align LIDAR with\n"
				  "the laser.\n"
				  "Press the Button",&small_font);
	sensors_enable_lidar(true);
	while(get_action()!=SINGLE_CLICK) {
		__delay_ms(125);
		length = sensors_read_lidar();
	}
	display_clear_screen();  //0123456789ABCDEF  0123456789  0123456789   0123456789ABCDEF
	display_write_multiline(0,"Beeper will now\n"
				  "sound when an\n"
				  "object obstructs\n"
				  "the laser beam",&small_font);
	__delay_ms(125);
	while(get_action()!=SINGLE_CLICK) {
		if ((length-1000)>sensors_read_lidar()) {
			if(!beeping)	beep_on(4000);
			beeping = true;
		} else {
			beep_off();
			beeping = false;
		}
		__delay_ms(50);
	}
	sensors_enable_lidar(false);
}

void full_cal() {}
