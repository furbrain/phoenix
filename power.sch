v 20130925 2
C 37000 44900 1 0 0 NCP4681.sym
{
T 38800 47000 5 10 1 1 0 6 1
refdes=U1
T 37400 47200 5 10 0 0 0 0 1
device=NCP4681
T 37400 47400 5 10 0 0 0 0 1
footprint=SC70_5
}
C 39700 47700 1 0 0 generic-power.sym
{
T 39900 47950 5 10 1 1 0 3 1
net=Vbat:1
}
C 46800 46400 1 0 0 5V-plus-1.sym
N 36500 44800 46600 44800 4
N 38100 44800 38100 45000 4
C 39700 46700 1 0 1 3.3V-plus-1.sym
N 36500 46500 37100 46500 4
C 36700 45100 1 90 0 capacitor-1.sym
{
T 36000 45300 5 10 0 0 90 0 1
device=CAPACITOR
T 36400 45800 5 10 1 1 180 0 1
refdes=C1
T 35800 45300 5 10 0 0 90 0 1
symversion=0.1
T 36100 45300 5 10 1 1 0 0 1
value=1uF
T 36500 45600 5 10 0 1 0 0 1
footprint=0603
}
C 39700 45100 1 90 0 capacitor-1.sym
{
T 39000 45300 5 10 0 0 90 0 1
device=CAPACITOR
T 39400 45800 5 10 1 1 180 0 1
refdes=C2
T 38800 45300 5 10 0 0 90 0 1
symversion=0.1
T 39100 45300 5 10 1 1 0 0 1
value=1uF
T 39500 45500 5 10 0 1 0 0 1
footprint=0603
}
N 36500 46000 36500 47500 4
N 36500 45100 36500 44800 4
N 39500 44800 39500 45100 4
N 39500 46000 39500 46700 4
N 39500 46500 39100 46500 4
C 40100 46000 1 270 1 pmos-3.sym
{
T 40200 46700 5 10 1 1 180 6 1
refdes=Q1
T 40400 46000 5 10 1 1 0 0 1
device=FDN304P
T 40600 46300 5 10 0 1 0 0 1
footprint=FDN304P
}
N 40100 46500 39500 46500 4
C 41100 46500 1 0 0 generic-power.sym
{
T 41300 46750 5 10 1 1 0 3 1
net=Vperiph:1
}
C 41100 45900 1 180 0 input-1.sym
{
T 41100 45600 5 10 0 0 180 0 1
device=INPUT
T 42600 45900 5 10 1 1 180 0 1
net=PERIPHERAL_EN:1
}
N 40300 45800 40300 46000 4
C 44100 45200 1 0 0 AAT3110.sym
{
T 45900 46900 5 10 1 1 0 6 1
refdes=U2
T 45000 46400 5 10 0 0 0 0 1
device=AAT3110
T 45000 46600 5 10 0 0 0 0 1
footprint=SOT26
}
N 36500 47500 43300 47500 4
N 43300 46000 43300 47500 4
N 45200 44800 45200 45300 4
N 47000 46400 46200 46400 4
C 44000 44900 1 90 0 capacitor-1.sym
{
T 43300 45100 5 10 0 0 90 0 1
device=CAPACITOR
T 43700 45600 5 10 1 1 180 0 1
refdes=C3
T 43100 45100 5 10 0 0 90 0 1
symversion=0.1
T 43200 45100 5 10 1 1 0 0 1
value=10uF
T 43800 45300 5 10 0 1 0 0 1
footprint=0603
}
C 46800 44900 1 90 0 capacitor-1.sym
{
T 46100 45100 5 10 0 0 90 0 1
device=CAPACITOR
T 46500 45600 5 10 1 1 180 0 1
refdes=C4
T 45900 45100 5 10 0 0 90 0 1
symversion=0.1
T 46000 45100 5 10 1 1 0 0 1
value=10uF
T 46600 45300 5 10 0 1 0 0 1
footprint=0603
}
C 45700 48100 1 180 0 capacitor-1.sym
{
T 45500 47400 5 10 0 0 180 0 1
device=CAPACITOR
T 44900 48100 5 10 1 1 0 0 1
refdes=C5
T 45500 47200 5 10 0 0 180 0 1
symversion=0.1
T 45400 48100 5 10 1 1 0 0 1
value=1uF
T 45300 47900 5 10 0 1 90 0 1
footprint=0603
}
N 44800 47900 44800 47100 4
N 44800 47100 45000 47100 4
N 45400 47100 45700 47100 4
N 45700 47100 45700 47900 4
N 43800 45800 43800 46000 4
N 43800 44900 43800 44800 4
N 46600 44900 46600 44800 4
N 46600 45800 46600 46400 4
N 36500 46100 37100 46100 4
N 39900 47700 39900 47500 4
N 44200 46400 44200 48000 4
N 43300 46000 44200 46000 4
C 41400 44500 1 0 0 gnd-1.sym
N 41300 46500 40900 46500 4
C 43000 47900 1 0 0 input-1.sym
{
T 43000 48200 5 10 0 0 0 0 1
device=INPUT
T 42200 47900 5 10 1 1 0 0 1
net=5V_EN:1
}
N 43800 48000 44200 48000 4
