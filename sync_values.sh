#!/bin/bash

SCAD_FILE=3d_models/gears.scad
CONFIG_GEN=arduino/teeth_config.h

gear1_teeth=$(grep 'gear1_teeth ='  < $SCAD_FILE | sed -e 's/gear1_teeth = \(.*\);/\1/g')
gear2_teeth=$(grep 'gear2_teeth ='  < $SCAD_FILE | sed -e 's/gear2_teeth = \(.*\);/\1/g')

echo $gear2_teeth $gear1_teeth

TMPL="#pragma once\n\
#define CONFIG_TEETH_SMALL 13.0\n\
#define CONFIG_TEETH_BIG 51.0\n\
"

echo -e $TMPL > $CONFIG_GEN
