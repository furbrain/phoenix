#include "config.h"
#include <libpic30.h>
#include <string.h>
#include "display.h"
#include "font.h"
#include "interface.h"
#include "sensors.h"
#include "debug.h"
#include "i2c_util.h"
#include "peripherals.h"



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

void full_cal() {
	struct RAW_SENSORS sensors;
	struct COOKED_SENSORS cooked;
	float degrees=0.0;
	float deg_cal=0.0;
	float deg_limit_p = 1.0;
	float deg_limit_m = -1.0;
	float nearest = 100000.0;
	float distance;
	
	double mag_buffers[400][3];
	int count, len;
	int complete = 0;
	//wait 2 seconds
	__delay_ms(2000);
	//beep
	//average gyro readings over 1s
	for (count=0;count<100;count++) {
		sensors_read_cooked(&cooked,false);
		deg_cal += cooked.gyro[1];
		while (!PORT_SENSOR_INT) __delay_ms(1);
	}
	deg_cal /= 100.0;
	beep_on(4000);
	__delay_ms(200);
	beep_off();
	//record 400 readings 
	count=0;
	while (count < 400) {
		sensors_read_cooked(&cooked,false);
		degrees += (cooked.gyro[1]-deg_cal)/100.0;
		if ((degrees>deg_limit_p)||(degrees<deg_limit_m)) {
			deg_limit_p += 1.0;
			deg_limit_m -= 1.0;
			memcpy(mag_buffers[count],sensors.mag,6);
			count +=1;
		}
		while (!PORT_SENSOR_INT) __delay_ms(1);
	}
	// find closest point
	for (count=320;count<400;count++) {
		distance = (mag_buffers[count][0]-mag_buffers[0][0])*(mag_buffers[count][0]-mag_buffers[0][0]) +
				   (mag_buffers[count][1]-mag_buffers[0][1])*(mag_buffers[count][1]-mag_buffers[0][1]) +
				   (mag_buffers[count][2]-mag_buffers[0][2])*(mag_buffers[count][2]-mag_buffers[0][2]);
		if (distance < nearest) {
			len = count;
			nearest = distance;
		}
	}
	// do pca...
	//beep again
	beep_on(4000);
	__delay_ms(200);
	beep_off();
	//copy data to EEPROM
	write_eeprom(0x200,mag_buffers,2160);
	__delay_ms(100);
	beep_on(4000);
	__delay_ms(200);
	beep_off();
}
