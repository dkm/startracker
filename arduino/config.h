#pragma once

/* Use Arduino NANO led for enable pin of motor.
   Easy way to monitor activity */
static const unsigned int led_pin = 13;

/* DRV8825 pin setup */
static const unsigned int enable_pin = led_pin;
static const unsigned int step_pin = 3;
static const unsigned int dir_pin = 2;
static const unsigned int m0_pin = 6;
static const unsigned int m1_pin = 5;
static const unsigned int m2_pin = 4;

/* set to true/false to change rotation direction */
static const bool stepper_direction = true;

/* Distance between hinge and threaded-rod */
static const float axis_hinge_dist_mm = 200;

/* Initial deployment of threaded rod in millimeters */
static const float initial_rod_deploy = 30;

/* Smallest value for hinge. Going lower would damage the gears/motors */
static const float min_rod_deploy = 30;

/* millimeters per rotation of the threaded-rod */
static const float bolt_thread_mm = 1.25;

/* If true, the hinge is getting opened. If false, hinge is getting
   closed.  When hinge is closing, gravity is helping. When opening,
   motor is working against gravity.
*/
static const bool hinge_opening = true;

/* When using debug over UART */
static const unsigned long serial_speed = 115200UL;

/* For things that could have real impact on execution */
#ifndef DEBUG
#define DEBUG (0)
#endif

/* For things that may have an impact, but should still be okay */
#ifndef MODERATE_DEBUG
#define MODERATE_DEBUG (0)
#endif

/* For very light debug that has *no* chance to interfere */
/* significatively with execution */
#ifndef WEAK_DEBUG
#define WEAK_DEBUG (1)
#endif
