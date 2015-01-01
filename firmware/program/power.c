#define USE_AND_OR
#include <dpslp.h>
#include <ports.h>
#include "power.h"
#include "peripherals.h"

void hibernate() {
	//turn off laser
	laser_on(false);
	//turn off peripherals
	peripherals_on(false);
	//enable INT0
	CloseINT0();
	ConfigINT0(INT_ENABLE | RISING_EDGE_INT | INT_PRI_1);
	// and snoooooze
	GotoDeepSleep();
	//Just in case we haven't gone properly to sleep...
	asm("reset"); //and restart, because we now need to re-initialise all sorts of things.
}