#define USE_AND_OR
#include "config.h"
#include <libpic30.h>
#include <dpslp.h>
#include <ports.h>
#include "power.h"
#include "peripherals.h"
#include "sensors.h"

void hibernate() {
	//swansong
	beep(4000,50);
	beep(3000,50);
	beep(2000,50);
	beep(1000,50);
	
	//turn off laser
	laser_on(false);
	//turn off peripherals
	peripherals_on(false);
	sensors_enable_lidar(false);
	//enable INT0
	__delay_ms(2000);
	//wait a little to avoid any extra button presses etc.
	CloseINT0();
	ConfigINT0(INT_ENABLE | RISING_EDGE_INT | INT_PRI_1);
	// and snoooooze
	GotoDeepSleep();
	//Just in case we haven't gone properly to sleep...
	asm("reset"); //and restart, because we now need to re-initialise all sorts of things.
}
