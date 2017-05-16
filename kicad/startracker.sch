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
L Arduino_Nano_v3.x A1
U 1 1 5918909A
P 3000 2400
F 0 "A1" H 2800 3425 50  0000 R CNN
F 1 "Arduino_Nano_v3.x" H 2800 3350 50  0000 R CNN
F 2 "Modules:Arduino_Nano" H 3150 1450 50  0001 L CNN
F 3 "" H 3000 1400 50  0001 C CNN
	1    3000 2400
	-1   0    0    1   
$EndComp
$Comp
L Pololu_Breakout_DRV8825 A2
U 1 1 5918917A
P 6750 2050
F 0 "A2" H 6650 2700 50  0000 R CNN
F 1 "Pololu_Breakout_DRV8825" H 6650 2600 50  0000 R CNN
F 2 "Modules:Pololu_Breakout-16_15.2x20.3mm" H 6950 1250 50  0001 L CNN
F 3 "" H 6850 1750 50  0001 C CNN
	1    6750 2050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR4
U 1 1 59189952
P 2900 1400
F 0 "#PWR4" H 2900 1150 50  0001 C CNN
F 1 "GND" H 2900 1250 50  0000 C CNN
F 2 "" H 2900 1400 50  0001 C CNN
F 3 "" H 2900 1400 50  0001 C CNN
	1    2900 1400
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR5
U 1 1 5918996A
P 3000 1400
F 0 "#PWR5" H 3000 1150 50  0001 C CNN
F 1 "GND" H 3000 1250 50  0000 C CNN
F 2 "" H 3000 1400 50  0001 C CNN
F 3 "" H 3000 1400 50  0001 C CNN
	1    3000 1400
	-1   0    0    1   
$EndComp
$Comp
L +12V #PWR6
U 1 1 59189D08
P 3100 3400
F 0 "#PWR6" H 3100 3250 50  0001 C CNN
F 1 "+12V" H 3100 3540 50  0000 C CNN
F 2 "" H 3100 3400 50  0001 C CNN
F 3 "" H 3100 3400 50  0001 C CNN
	1    3100 3400
	-1   0    0    1   
$EndComp
$Comp
L +12V #PWR12
U 1 1 59189D20
P 6750 1450
F 0 "#PWR12" H 6750 1300 50  0001 C CNN
F 1 "+12V" H 6750 1590 50  0000 C CNN
F 2 "" H 6750 1450 50  0001 C CNN
F 3 "" H 6750 1450 50  0001 C CNN
	1    6750 1450
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR11
U 1 1 59189D9A
P 6150 1750
F 0 "#PWR11" H 6150 1600 50  0001 C CNN
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
L +5V #PWR3
U 1 1 59189EB8
P 2800 3400
F 0 "#PWR3" H 2800 3250 50  0001 C CNN
F 1 "+5V" H 2800 3540 50  0000 C CNN
F 2 "" H 2800 3400 50  0001 C CNN
F 3 "" H 2800 3400 50  0001 C CNN
	1    2800 3400
	-1   0    0    1   
$EndComp
Wire Wire Line
	6350 2150 5100 2150
Wire Wire Line
	5100 2150 5100 2700
Wire Wire Line
	5100 2700 3500 2700
Wire Wire Line
	6350 2250 5200 2250
Wire Wire Line
	5200 2250 5200 2800
$Comp
L CONN_01X06 J5
U 1 1 59189F62
P 8050 2100
F 0 "J5" H 8050 2450 50  0000 C CNN
F 1 "CONN_01X06" V 8150 2100 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x06" H 8050 2100 50  0001 C CNN
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
L CONN_01X02 J2
U 1 1 5918A07D
P 4900 1000
F 0 "J2" H 4900 1150 50  0000 C CNN
F 1 "CONN_01X02" V 5000 1000 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02" H 4900 1000 50  0001 C CNN
F 3 "" H 4900 1000 50  0001 C CNN
	1    4900 1000
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X02 J3
U 1 1 5918A0FA
P 4900 1750
F 0 "J3" H 4900 1900 50  0000 C CNN
F 1 "CONN_01X02" V 5000 1750 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02" H 4900 1750 50  0001 C CNN
F 3 "" H 4900 1750 50  0001 C CNN
	1    4900 1750
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X02 J4
U 1 1 5918A125
P 4900 2150
F 0 "J4" H 4900 2300 50  0000 C CNN
F 1 "CONN_01X02" V 5000 2150 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02" H 4900 2150 50  0001 C CNN
F 3 "" H 4900 2150 50  0001 C CNN
	1    4900 2150
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR10
U 1 1 5918A639
P 4700 2500
F 0 "#PWR10" H 4700 2350 50  0001 C CNN
F 1 "+5V" H 4700 2640 50  0000 C CNN
F 2 "" H 4700 2500 50  0001 C CNN
F 3 "" H 4700 2500 50  0001 C CNN
	1    4700 2500
	-1   0    0    1   
$EndComp
$Comp
L R R3
U 1 1 5918A670
P 4700 2350
F 0 "R3" V 4780 2350 50  0000 C CNN
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
	4600 2600 3500 2600
$Comp
L R R1
U 1 1 5918A6E2
P 4500 1950
F 0 "R1" V 4580 1950 50  0000 C CNN
F 1 "R" V 4500 1950 50  0000 C CNN
F 2 "" V 4430 1950 50  0001 C CNN
F 3 "" H 4500 1950 50  0001 C CNN
	1    4500 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4700 1800 4500 1800
$Comp
L +5V #PWR8
U 1 1 5918A755
P 4500 2100
F 0 "#PWR8" H 4500 1950 50  0001 C CNN
F 1 "+5V" H 4500 2240 50  0000 C CNN
F 2 "" H 4500 2100 50  0001 C CNN
F 3 "" H 4500 2100 50  0001 C CNN
	1    4500 2100
	-1   0    0    1   
$EndComp
Wire Wire Line
	4700 1700 4400 1700
Wire Wire Line
	4400 1700 4400 2500
Wire Wire Line
	4400 2500 3500 2500
$Comp
L +5V #PWR9
U 1 1 5919EDE7
P 4700 1350
F 0 "#PWR9" H 4700 1200 50  0001 C CNN
F 1 "+5V" H 4700 1490 50  0000 C CNN
F 2 "" H 4700 1350 50  0001 C CNN
F 3 "" H 4700 1350 50  0001 C CNN
	1    4700 1350
	-1   0    0    1   
$EndComp
Wire Wire Line
	3500 2400 4350 2400
$Comp
L R R2
U 1 1 5919EE32
P 4700 1200
F 0 "R2" V 4780 1200 50  0000 C CNN
F 1 "R" V 4700 1200 50  0000 C CNN
F 2 "" V 4630 1200 50  0001 C CNN
F 3 "" H 4700 1200 50  0001 C CNN
	1    4700 1200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4350 2400 4350 1600
Wire Wire Line
	4350 1600 4550 1600
Wire Wire Line
	4550 1600 4550 950 
Wire Wire Line
	4550 950  4700 950 
Wire Wire Line
	5200 2800 3500 2800
$Comp
L CONN_02X04 LCD1
U 1 1 5919F630
P 2550 800
F 0 "LCD1" H 2550 1050 50  0000 C CNN
F 1 "CONN_02X04" H 2550 550 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x04" H 2550 -400 50  0001 C CNN
F 3 "" H 2550 -400 50  0001 C CNN
	1    2550 800 
	1    0    0    -1  
$EndComp
Wire Wire Line
	2800 950  3500 950 
Wire Wire Line
	3500 950  3500 1700
Wire Wire Line
	2800 850  3600 850 
Wire Wire Line
	3600 850  3600 1800
Wire Wire Line
	3600 1800 3500 1800
Wire Wire Line
	2800 750  3700 750 
Wire Wire Line
	3700 750  3700 1900
Wire Wire Line
	3700 1900 3500 1900
Wire Wire Line
	2800 650  3850 650 
Wire Wire Line
	3850 650  3850 2000
Wire Wire Line
	3850 2000 3500 2000
$Comp
L GND #PWR1
U 1 1 5919F7AD
P 2050 650
F 0 "#PWR1" H 2050 400 50  0001 C CNN
F 1 "GND" H 2050 500 50  0000 C CNN
F 2 "" H 2050 650 50  0001 C CNN
F 3 "" H 2050 650 50  0001 C CNN
	1    2050 650 
	0    1    1    0   
$EndComp
$Comp
L +5V #PWR2
U 1 1 5919F7D9
P 2050 800
F 0 "#PWR2" H 2050 650 50  0001 C CNN
F 1 "+5V" H 2050 940 50  0000 C CNN
F 2 "" H 2050 800 50  0001 C CNN
F 3 "" H 2050 800 50  0001 C CNN
	1    2050 800 
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2300 950  2300 1700
Wire Wire Line
	2300 1700 2500 1700
Wire Wire Line
	2300 850  2200 850 
Wire Wire Line
	2200 850  2200 1800
Wire Wire Line
	2200 1800 2500 1800
Wire Wire Line
	2300 750  2050 750 
Wire Wire Line
	2050 750  2050 800 
Wire Wire Line
	2300 650  2050 650 
Text Label 2850 650  0    60   ~ 0
D4
Text Label 2850 750  0    60   ~ 0
D5
Text Label 2850 850  0    60   ~ 0
D6
Text Label 2850 950  0    60   ~ 0
D7
Text Label 2300 950  0    60   ~ 0
EN
Text Label 2200 850  0    60   ~ 0
RS
Text Label 4550 1700 0    60   ~ 0
BTN2
Text Label 4600 2100 0    60   ~ 0
BTN1
Text Label 4350 1600 0    60   ~ 0
BTN3
$Comp
L Rotary_Encoder_Switch SW?
U 1 1 591A8C1B
P 6150 850
F 0 "SW?" H 6150 1110 50  0000 C CNN
F 1 "Rotary_Encoder_Switch" H 6150 590 50  0000 C CNN
F 2 "" H 6050 1010 50  0001 C CNN
F 3 "" H 6150 1110 50  0001 C CNN
	1    6150 850 
	1    0    0    -1  
$EndComp
Text GLabel 3500 2100 2    60   Input ~ 0
ROT_A
Text GLabel 3800 2200 2    60   Input ~ 0
ROT_C
Text GLabel 3800 2300 2    60   Input ~ 0
ROT_BUT
Wire Wire Line
	3800 2200 3500 2200
Wire Wire Line
	3800 2300 3500 2300
Text GLabel 5850 750  0    60   Input ~ 0
ROT_A
Text GLabel 5500 950  0    60   Input ~ 0
ROT_C
Text GLabel 6450 750  2    60   Input ~ 0
ROT_BUT
Wire Wire Line
	5850 950  5500 950 
$Comp
L GND #PWR?
U 1 1 591A8F4B
P 5350 700
F 0 "#PWR?" H 5350 450 50  0001 C CNN
F 1 "GND" H 5350 550 50  0000 C CNN
F 2 "" H 5350 700 50  0001 C CNN
F 3 "" H 5350 700 50  0001 C CNN
	1    5350 700 
	0    1    1    0   
$EndComp
Wire Wire Line
	5400 700  5400 850 
Wire Wire Line
	5400 850  5850 850 
Wire Wire Line
	5400 700  5350 700 
$Comp
L R R?
U 1 1 591A9002
P 6600 950
F 0 "R?" V 6680 950 50  0000 C CNN
F 1 "R" V 6600 950 50  0000 C CNN
F 2 "" V 6530 950 50  0001 C CNN
F 3 "" H 6600 950 50  0001 C CNN
	1    6600 950 
	0    1    1    0   
$EndComp
$Comp
L +5V #PWR?
U 1 1 591A90A4
P 6750 950
F 0 "#PWR?" H 6750 800 50  0001 C CNN
F 1 "+5V" H 6750 1090 50  0000 C CNN
F 2 "" H 6750 950 50  0001 C CNN
F 3 "" H 6750 950 50  0001 C CNN
	1    6750 950 
	0    1    1    0   
$EndComp
$EndSCHEMATC
