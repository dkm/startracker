EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:74xgxx
LIBS:ac-dc
LIBS:actel
LIBS:allegro
LIBS:Altera
LIBS:analog_devices
LIBS:battery_management
LIBS:bbd
LIBS:bosch
LIBS:brooktre
LIBS:cmos_ieee
LIBS:dc-dc
LIBS:diode
LIBS:elec-unifil
LIBS:ESD_Protection
LIBS:ftdi
LIBS:gennum
LIBS:graphic
LIBS:hc11
LIBS:infineon
LIBS:intersil
LIBS:ir
LIBS:Lattice
LIBS:leds
LIBS:LEM
LIBS:logo
LIBS:maxim
LIBS:mechanical
LIBS:microchip_dspic33dsc
LIBS:microchip_pic10mcu
LIBS:microchip_pic12mcu
LIBS:microchip_pic16mcu
LIBS:microchip_pic18mcu
LIBS:microchip_pic24mcu
LIBS:microchip_pic32mcu
LIBS:modules
LIBS:motor_drivers
LIBS:motors
LIBS:msp430
LIBS:nordicsemi
LIBS:nxp
LIBS:nxp_armmcu
LIBS:onsemi
LIBS:Oscillators
LIBS:powerint
LIBS:Power_Management
LIBS:pspice
LIBS:references
LIBS:relays
LIBS:rfcom
LIBS:RFSolutions
LIBS:sensors
LIBS:silabs
LIBS:stm8
LIBS:stm32
LIBS:supertex
LIBS:switches
LIBS:transf
LIBS:triac_thyristor
LIBS:ttl_ieee
LIBS:video
LIBS:wiznet
LIBS:Worldsemi
LIBS:Xicor
LIBS:zetex
LIBS:Zilog
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Arduino_Nano_v3.x A?
U 1 1 5918909A
P 3450 2400
F 0 "A?" H 3250 3425 50  0000 R CNN
F 1 "Arduino_Nano_v3.x" H 3250 3350 50  0000 R CNN
F 2 "Modules:Arduino_Nano" H 3600 1450 50  0001 L CNN
F 3 "" H 3450 1400 50  0001 C CNN
	1    3450 2400
	-1   0    0    1   
$EndComp
$Comp
L Pololu_Breakout_DRV8825 A?
U 1 1 5918917A
P 6750 2050
F 0 "A?" H 6650 2700 50  0000 R CNN
F 1 "Pololu_Breakout_DRV8825" H 6650 2600 50  0000 R CNN
F 2 "Modules:Pololu_Breakout-16_15.2x20.3mm" H 6950 1250 50  0001 L CNN
F 3 "" H 6850 1750 50  0001 C CNN
	1    6750 2050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 59189952
P 3350 1400
F 0 "#PWR?" H 3350 1150 50  0001 C CNN
F 1 "GND" H 3350 1250 50  0000 C CNN
F 2 "" H 3350 1400 50  0001 C CNN
F 3 "" H 3350 1400 50  0001 C CNN
	1    3350 1400
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR?
U 1 1 5918996A
P 3450 1400
F 0 "#PWR?" H 3450 1150 50  0001 C CNN
F 1 "GND" H 3450 1250 50  0000 C CNN
F 2 "" H 3450 1400 50  0001 C CNN
F 3 "" H 3450 1400 50  0001 C CNN
	1    3450 1400
	-1   0    0    1   
$EndComp
$Comp
L +12V #PWR?
U 1 1 59189D08
P 3550 3400
F 0 "#PWR?" H 3550 3250 50  0001 C CNN
F 1 "+12V" H 3550 3540 50  0000 C CNN
F 2 "" H 3550 3400 50  0001 C CNN
F 3 "" H 3550 3400 50  0001 C CNN
	1    3550 3400
	-1   0    0    1   
$EndComp
$Comp
L +12V #PWR?
U 1 1 59189D20
P 6750 1450
F 0 "#PWR?" H 6750 1300 50  0001 C CNN
F 1 "+12V" H 6750 1590 50  0000 C CNN
F 2 "" H 6750 1450 50  0001 C CNN
F 3 "" H 6750 1450 50  0001 C CNN
	1    6750 1450
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR?
U 1 1 59189D9A
P 6150 1750
F 0 "#PWR?" H 6150 1600 50  0001 C CNN
F 1 "+5V" H 6150 1890 50  0000 C CNN
F 2 "" H 6150 1750 50  0001 C CNN
F 3 "" H 6150 1750 50  0001 C CNN
	1    6150 1750
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 1750 6350 1750
Wire Wire Line
	6350 1850 6150 1850
Wire Wire Line
	6150 1850 6150 1750
$Comp
L +5V #PWR?
U 1 1 59189EB8
P 3250 3400
F 0 "#PWR?" H 3250 3250 50  0001 C CNN
F 1 "+5V" H 3250 3540 50  0000 C CNN
F 2 "" H 3250 3400 50  0001 C CNN
F 3 "" H 3250 3400 50  0001 C CNN
	1    3250 3400
	-1   0    0    1   
$EndComp
Wire Wire Line
	6350 2150 5100 2150
Wire Wire Line
	5100 2150 5100 2700
Wire Wire Line
	5100 2700 3950 2700
Wire Wire Line
	6350 2250 5200 2250
Wire Wire Line
	5200 2250 5200 2800
Wire Wire Line
	5200 2800 3950 2800
$Comp
L CONN_01X06 J?
U 1 1 59189F62
P 8050 2100
F 0 "J?" H 8050 2450 50  0000 C CNN
F 1 "CONN_01X06" V 8150 2100 50  0000 C CNN
F 2 "" H 8050 2100 50  0001 C CNN
F 3 "" H 8050 2100 50  0001 C CNN
	1    8050 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	7150 2350 7850 2350
Wire Wire Line
	7150 2250 7400 2250
Wire Wire Line
	7400 2250 7400 2150
Wire Wire Line
	7400 2150 7850 2150
Wire Wire Line
	7150 1950 7500 1950
Wire Wire Line
	7500 1950 7500 1850
Wire Wire Line
	7500 1850 7850 1850
Wire Wire Line
	7150 2050 7850 2050
$Comp
L CONN_01X02 J?
U 1 1 5918A07D
P 4900 1350
F 0 "J?" H 4900 1500 50  0000 C CNN
F 1 "CONN_01X02" V 5000 1350 50  0000 C CNN
F 2 "" H 4900 1350 50  0001 C CNN
F 3 "" H 4900 1350 50  0001 C CNN
	1    4900 1350
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X02 J?
U 1 1 5918A0FA
P 4900 1750
F 0 "J?" H 4900 1900 50  0000 C CNN
F 1 "CONN_01X02" V 5000 1750 50  0000 C CNN
F 2 "" H 4900 1750 50  0001 C CNN
F 3 "" H 4900 1750 50  0001 C CNN
	1    4900 1750
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X02 J?
U 1 1 5918A125
P 4900 2150
F 0 "J?" H 4900 2300 50  0000 C CNN
F 1 "CONN_01X02" V 5000 2150 50  0000 C CNN
F 2 "" H 4900 2150 50  0001 C CNN
F 3 "" H 4900 2150 50  0001 C CNN
	1    4900 2150
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X04 J?
U 1 1 5918A23D
P 4900 900
F 0 "J?" H 4900 1150 50  0000 C CNN
F 1 "CONN_01X04" V 5000 900 50  0000 C CNN
F 2 "" H 4900 900 50  0001 C CNN
F 3 "" H 4900 900 50  0001 C CNN
	1    4900 900 
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR?
U 1 1 5918A639
P 4700 2500
F 0 "#PWR?" H 4700 2350 50  0001 C CNN
F 1 "+5V" H 4700 2640 50  0000 C CNN
F 2 "" H 4700 2500 50  0001 C CNN
F 3 "" H 4700 2500 50  0001 C CNN
	1    4700 2500
	-1   0    0    1   
$EndComp
$Comp
L R R?
U 1 1 5918A670
P 4700 2350
F 0 "R?" V 4780 2350 50  0000 C CNN
F 1 "R" V 4700 2350 50  0000 C CNN
F 2 "" V 4630 2350 50  0001 C CNN
F 3 "" H 4700 2350 50  0001 C CNN
	1    4700 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	4700 2100 4600 2100
Wire Wire Line
	4600 2100 4600 2600
Wire Wire Line
	4600 2600 3950 2600
$Comp
L R R?
U 1 1 5918A6E2
P 4500 1950
F 0 "R?" V 4580 1950 50  0000 C CNN
F 1 "R" V 4500 1950 50  0000 C CNN
F 2 "" V 4430 1950 50  0001 C CNN
F 3 "" H 4500 1950 50  0001 C CNN
	1    4500 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4700 1800 4500 1800
$Comp
L +5V #PWR?
U 1 1 5918A755
P 4500 2100
F 0 "#PWR?" H 4500 1950 50  0001 C CNN
F 1 "+5V" H 4500 2240 50  0000 C CNN
F 2 "" H 4500 2100 50  0001 C CNN
F 3 "" H 4500 2100 50  0001 C CNN
	1    4500 2100
	-1   0    0    1   
$EndComp
$EndSCHEMATC
