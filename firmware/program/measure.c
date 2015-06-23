#include "config.h"
#include <math.h>
#include <stdio.h>
#include <string.h>
#include "measure.h"
#include "interface.h"
#include "display.h"
#include "sensors.h"
#include "maths.h"

#define FEET_PER_METRE 3.281
#define DEGREES_PER_RADIAN 57.296
#define GRADS_PER_DEGREE 1.111111111



const char *cartesian_items[] = {"East:","North:","Vert:","Lg:    Ext:"};
const char *polar_items[] = {"Comp:","Clino:","Dist:","Lg:    Ext:"};

const char cartesian_format[] = " %+.2f ";
const char *polar_format[] = {" %03.1f "," %+02.1f "," %.2f "," %.2f "};


void get_readings(double *orientation, double *distance){
	int reading_count = 0;
	int i,j;
	double temp_o[3];
	int32_t temp_dist,dist=0;
	int16_t distances[20];
	struct RAW_SENSORS sensors;
	struct COOKED_SENSORS cooked;
	int32_t mags[3] = {0,0,0};
	int32_t accels[3] = {0,0,0};

	display_on(false);
	laser_on(false);
	delay_ms(20);
	sensors_init_compass();
	for(i=0;i<80;++i) {
		delay_ms(10);
		sensors_read_raw(&sensors,false);
		for (j=0;j<3;++j) {
			mags[j] += sensors.mag[j];
			accels[j] += sensors.accel[j];
		}
	}
	for(j=0;j<3;++j) {
		sensors.mag[j] = mags[j]/80;
		sensors.accel[j] = accels[j]/40;
	}
	sensors_raw_to_cooked(&cooked,&sensors);
	sensors_get_orientation(&cooked,orientation);
	normalise(orientation);
	sensors_enable_lidar(true);
	i=j=0;
	while ((i<20) && (j<50)) {
		j++;
		temp_dist = sensors_read_lidar();
		if ((temp_dist>0) && (temp_dist<10000)) {
			distances[i] = temp_dist;
			i++;
		}
	}
	if (i>10) {
		*distance = find_median(distances,i)/100.0;
	} else {
		*distance = -10;
	}
	sensors_enable_lidar(false);
	laser_on(true);
	display_on(true);
}


double get_extension(double *o, double distance) {
	//remember orientations are normalised...
	return sqrt(o[0]*o[0]+o[1]*o[1])*distance;
}
/* set items to compass,clino,distance and extension, respectively */
void calculate_bearings(double *orientation, double *items, double distance, bool grads, bool imperial){
	items[0] = atan2(orientation[0],orientation[1])*DEGREES_PER_RADIAN;
	if (items[0]<0) items[0]+=360;
	items[1] = atan2(orientation[2],get_extension(orientation,1))*DEGREES_PER_RADIAN;
	if (grads) {
		items[0] *= GRADS_PER_DEGREE;
		items[1] *= GRADS_PER_DEGREE;
	}
	items[2] = distance;
	items[3] = get_extension(orientation,distance);
	if (imperial) {
		items[2] *= FEET_PER_METRE;
		items[3] *= FEET_PER_METRE;
	}
}

/* set items to easting, northing, vertical offset and extension, respectively */
void calculate_deltas(double *orientation, double *items, double distance, bool imperial){
	int i;
	for(i=0;i<3;++i) {
		items[i] = orientation[i]*distance;
	}
	items[3] = get_extension(orientation,distance);
	if (imperial) {
		for (i=0;i<4;++i) {
			items[i] *= FEET_PER_METRE;
		}
	}
}

void test() {
	int32_t readings[15];
	char text[17];
	int i, count;
	struct RAW_SENSORS sensors;
	display_on(false);
	laser_on(false);
	for(i=0;i<12;++i) {
		count = 0;
		sensors_read_raw(&sensors,false);
		readings[i] = sensors.mag[0];
		delay_ms(100);
	}
	for(i=0;i<4;++i) {
		sprintf(text,"%5ld%5ld%5ld",readings[i*3],readings[(i*3)+1],readings[(i*3)+2]);
		display_write_text(i*2,0,text,&small_font,false);
	}
	sensors_enable_lidar(false);
	display_on(true);
	laser_on(true);
	delay_ms(8000);
	return;
}

void measure() {
	int item = 0;
	bool readings_available = false;
	double items[4];
	double orientation[4];
	double extension,distance;
	int i, cycle;
	char text[17];
	char format[17];
	char degree_sign;
	char length_sign;
	distance = 10.0;
	length_sign = (config.length_units==IMPERIAL)?'\'':'m';
	degree_sign = (config.display_style==GRAD)?'g':'`';
	cycle = 0;
	//test stuff here...
// 	test();
// 	return;
	//end test
	display_clear_screen();
	display_write_text(4,0,"*----",&large_font,false);
	while (true) {
		cycle++;
		if (readings_available) {
			for (i=0; i<4; i++) {
				if (config.display_style==CARTESIAN) {
					sprintf(format,cartesian_format,items[i]);
					display_write_text(i*2,0,cartesian_items[i],&small_font,false);
				} else {
					sprintf(format,polar_format[i],items[i]);
					display_write_text(i*2,0,polar_items[i],&small_font,false);
				}
				if ((i<2) && (config.display_style!=CARTESIAN)) {
					format[strlen(format)-1] = degree_sign;
				} else {
					format[strlen(format)-1] = length_sign;
				}
				if (i==3) {
					display_write_text(6,26,"123",&small_font,false);
				}
				display_write_text(i*2,127,format,&small_font,true);
			}
		}
		switch(get_action()) {
			case FLIP_UP:
			case FLIP_DOWN:
				break;
			case SINGLE_CLICK:
				//sensors_enable_lidar(false);
				break;
			case NONE:
				if (cycle<30) break;
				cycle=0;
			case LONG_CLICK:
				get_readings(orientation,&distance);
				switch (config.display_style) {
					case GRAD:
					case POLAR:
						calculate_bearings(orientation,
										   items,
										   distance,
										   config.display_style==GRAD,
										   config.length_units==IMPERIAL);
						break;
					case CARTESIAN:
						calculate_deltas(orientation,
										 items,
										 distance,
										 config.length_units==IMPERIAL);
						break;
				}
				/* take measurement */
				readings_available = true;
				break;
			case DOUBLE_CLICK:
				return;
				hibernate();
				break;
		}
		delay_ms(50);
	}
}
