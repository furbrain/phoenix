v 20130925 2
C 200 51800 1 0 0 usb-1.sym
{
T 400 51600 5 10 1 1 0 0 1
device=USB
T 300 53500 5 10 1 1 0 0 1
refdes=J4
T 200 51800 5 10 0 0 0 0 1
footprint=SIP5
}
C 3600 52000 1 0 0 MCP73832.sym
{
T 5400 53700 5 10 1 1 0 6 1
refdes=U7
T 4000 53900 5 10 0 0 0 0 1
device=MCP73832
T 4000 54100 5 10 0 0 0 0 1
footprint=SOT25R
}
N 1900 53200 3700 53200 4
N 1900 52300 2700 52300 4
N 2700 52300 2700 51200 4
N 2700 51200 6800 51200 4
N 4500 51200 4500 52100 4
N 1900 52000 2700 52000 4
C 3900 52100 1 90 0 capacitor-1.sym
{
T 3200 52300 5 10 0 0 90 0 1
device=CAPACITOR
T 3600 52800 5 10 1 1 180 0 1
refdes=C16
T 3000 52300 5 10 0 0 90 0 1
symversion=0.1
T 3200 52300 5 10 1 1 0 0 1
value=10uF
T 3600 52500 5 10 0 1 0 0 1
footprint=0603
}
C 6400 51500 1 90 0 capacitor-1.sym
{
T 5700 51700 5 10 0 0 90 0 1
device=CAPACITOR
T 6100 52200 5 10 1 1 180 0 1
refdes=C17
T 5500 51700 5 10 0 0 90 0 1
symversion=0.1
T 5700 51700 5 10 1 1 0 0 1
value=10uF
T 6100 51900 5 10 0 1 0 0 1
footprint=0603
}
N 3700 53200 3700 53000 4
N 3700 52100 3700 51200 4
N 5700 52800 6900 52800 4
N 6200 52800 6200 52400 4
N 6200 51500 6200 51200 4
C 4000 50900 1 0 0 gnd-1.sym
C 2600 53200 1 0 0 generic-power.sym
{
T 2800 53650 5 10 1 1 180 3 1
net=Vusb:1
}
C 6000 52800 1 0 0 generic-power.sym
{
T 6200 53050 5 10 1 1 0 3 1
net=Vbat:1
}
C 6600 52300 1 270 0 battery-1.sym
{
T 7500 52000 5 10 0 0 270 0 1
device=BATTERY
T 7000 52000 5 10 1 1 270 0 1
refdes=B1
T 7900 52000 5 10 0 0 270 0 1
symversion=0.1
T 6600 52300 5 10 0 0 0 0 1
footprint=SIP2
}
N 6800 52800 6800 52300 4
N 6800 51600 6800 51200 4
C 10100 53600 1 180 0 input-1.sym
{
T 10100 53300 5 10 0 0 180 0 1
device=INPUT
T 10100 53500 5 10 1 1 0 0 1
net=BAT_STATUS:1
}
C 2700 53000 1 180 0 input-1.sym
{
T 2700 52700 5 10 0 0 180 0 1
device=INPUT
T 2200 52800 5 10 1 1 0 0 1
netname=USB-
T 2700 53000 5 10 0 0 0 0 1
net=USB-:1
}
C 2700 52700 1 180 0 input-1.sym
{
T 2700 52400 5 10 0 0 180 0 1
device=INPUT
T 2200 52500 5 10 1 1 0 0 1
net=USB+:1
}
C 5000 51200 1 90 0 resistor-2.sym
{
T 4650 51600 5 10 0 0 90 0 1
device=RESISTOR
T 5300 51900 5 10 1 1 180 0 1
refdes=R11
T 5000 51700 5 10 0 1 0 0 1
footprint=0603
T 5000 51500 5 10 1 1 0 0 1
value=2k2
}
N 5700 53200 5700 53500 4
C 9200 53600 1 180 0 resistor-2.sym
{
T 8800 53250 5 10 0 0 180 0 1
device=RESISTOR
T 8400 53700 5 10 1 1 0 0 1
refdes=R12
T 8700 53600 5 10 0 1 90 0 1
footprint=0603
T 8800 53700 5 10 1 1 0 0 1
value=1M
}
N 9300 53500 9200 53500 4
N 8300 53500 5700 53500 4
C 7800 52900 1 180 0 resistor-2.sym
{
T 7400 52550 5 10 0 0 180 0 1
device=RESISTOR
T 7000 53000 5 10 1 1 0 0 1
refdes=R13
T 7300 52900 5 10 0 1 90 0 1
footprint=0603
T 7400 53000 5 10 1 1 0 0 1
value=1M
}
N 7800 52800 8000 52800 4
N 8000 52800 8000 53500 4
