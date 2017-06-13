#!/usr/bin/env python3

import sys
import numpy

BOLT_THREAD = 1.25
NR_TEETH_BIG=53
NR_TEETH_SMALL=11

EARTH_SIDERAL_DAY = 1440
HINGE_ROD_LEN = 200

def rodlen_to_angle(rod_len):
    return numpy.arctan(rod_len / HINGE_ROD_LEN)

def drivegear_angle_to_rodlen(angle):
    return BOLT_THREAD*angle/(2*numpy.pi)

def steppergear_angle_to_drivegear_angle(sangle):
    return sangle * NR_TEETH_SMALL/NR_TEETH_BIG


def debug_from_step_angle(sangle):
    step_angle = float(sangle)

    print("Step angle {}rad".format(step_angle))

    drivegear_angle = steppergear_angle_to_drivegear_angle(step_angle)

    print("Drive gear angle {}rad".format(drivegear_angle))

    rodlen = drivegear_angle_to_rodlen(drivegear_angle)

    print("Rod length {}mm".format(rodlen))

    final_angle = rodlen_to_angle(rodlen)

    print("Final angle {}rad".format(final_angle))

def get_step_angle_from_time(time_in_sec):
    final_angle = time_in_sec *  2 * numpy.pi / (1440*60)
    sangle = numpy.tan(final_angle) * HINGE_ROD_LEN * 2 * numpy.pi * NR_TEETH_BIG / (BOLT_THREAD * NR_TEETH_SMALL)
    print("For {} sec, final angle is {} rad => step angle is {}".format(time_in_sec, final_angle, sangle))
    verif_final = debug_from_step_angle(sangle)
          
get_step_angle_from_time(int(sys.argv[1]))
