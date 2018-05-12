// -*- mode: c++; -*-
//
// Startracker drives a NEMA17 for compensating the earth rotation
// during long exposure photography.  Original code based on JjRobots
// (see below), but everything has been rewritten since the begining
// of this project.
//
// This was tested with an arduino nano.
// Board wiring (and PCB) are available along with this code.
// See https://framagit.org/marc/startracker
//
// Initial header :
// STARTRACKER MOTOR CONTROL: STEPPER MOTOR CONTROL FOR JJROBOTS POV DISPLAY
// This code is designed for JJROBOTS arDusplay Stepper Motor Control board
// Author: JJROBOTS.COM (Jose Julio & Juan Pedro)
// Licence: GNU GPL
// Stepper : NEMA17
// Driver : A4988 or DRV8825
// Microstepping : configured to 1/16
// Arduino board: Pro micro (leonardo equivalent)

#include <DRV8825.h>

static const unsigned int led_pin = 13;

static const unsigned int step_pin = 3;
static const unsigned int dir_pin = 2;
static const unsigned int m0_pin = 6;
static const unsigned int m1_pin = 5;
static const unsigned int m2_pin = 4;

static const unsigned int enable_pin = led_pin;

// using a 200-step motor (most common)
// pins used are DIR, STEP, MS1, MS2, MS3 in that order
//A4988 stepper(200, 8, 9, 10, 11, 12);
DRV8825 stepper(200, dir_pin, step_pin,
		enable_pin,
		m0_pin, m1_pin, m2_pin);

// set to -1/1 to select rotation
static const bool stepper_direction = true;

#include <Switch.h>

// For things that could have real impact on execution
#ifndef DEBUG
#define DEBUG (0)
#endif

// For very light debug that has *no* chance to interfere
// significatively with execution
#ifndef WEAK_DEBUG
#define WEAK_DEBUG (1)
#endif

#ifndef MODERATE_DEBUG
#define MODERATE_DEBUG (0)
#endif

#if DEBUG
#define dprint(x) Serial.println(x)
#else
#define dprint(x)
#endif

#if WEAK_DEBUG
#define dwprint(x) Serial.println(x)
#else
#define dwprint(x)
#endif

#if MODERATE_DEBUG
#define mprint(x) Serial.println(x)
#else
#define mprint(x)
#endif

//other info needed:
//ratio between the large gear and the small one=0.2549

// Science here !
#include "teeth_config.h"

static const float nr_teeth_small = CONFIG_TEETH_SMALL; // 13.0
static const float nr_teeth_big = CONFIG_TEETH_BIG; // 51.0

static const float axis_hinge_dist_mm = 200;

// Use immediate value. Using symbolic values leads to incorrect value.
static const float earth_rot_speed_rad_msec = 7.272205e-8; //2*PI / (1440*60);

static const float bolt_thread_mm = 1.25;
//static const float coef = 2*PI*axis_hinge_dist_mm * nr_teeth_big / (bolt_thread_mm * nr_teeth_small);

static const unsigned int microstepping_div = 32;
static const unsigned int nr_steps = 200 * microstepping_div;

static const float stepper_gear_rad_per_step = (2*PI) / nr_steps;

#if MODERATE_DEBUG || DEBUG
static unsigned int loop_count = 0;
#endif

// this needs to be reset
static struct rot_state_t {
  unsigned long elapsed_time_millis;
  float stepper_gear_rot_rad = 0;
} rot_state;

static const unsigned int btn1_pin = 8;
Switch button1Switch = Switch(btn1_pin);

// static const unsigned int btn2_pin = 5;
// static const unsigned int btn3_pin = 6;
static const unsigned int end_stop_pin = 10;

static const unsigned long serial_speed = 115200UL;

#define ENABLE_LED_BLINK (0)

#define USE_ACTIVE_WAIT (1)
static const int use_active_wait = USE_ACTIVE_WAIT;
static const long active_threshold = 10;

static struct {
  unsigned long period;
  unsigned long deadline;
  unsigned long remain;
  unsigned int  expired;
} active_timer;

static unsigned long global_period_msec = 100;//(2*60+51)*1000;

static enum control_state_e {
  STARTUP = -1,
  IDLE = 0,
  RUN  = 1,
  RUN_OR_RESET = 2,
  RESET_POSITION = 3,
} control_state = STARTUP;

#define DUMP(v) do {				\
    Serial.print(#v " ");			\
    Serial.println(v, 10);			\
  } while(0)

#if DEBUG || MODERATE_DEBUG
static void debug_long(rot_state_t *s){
  const unsigned long ellapsed_in_msec = s->elapsed_time_millis;
  DUMP(ellapsed_in_msec);
  DUMP(earth_rot_speed_rad_msec);
  DUMP(axis_hinge_dist_mm);
  DUMP(nr_teeth_big);
  DUMP(nr_teeth_small);
  DUMP(bolt_thread_mm);
  DUMP(PI);
}
#endif

static float get_expected_stepper_rot(rot_state_t *s) {
  const float r = tan(earth_rot_speed_rad_msec * s->elapsed_time_millis /* ellapsed_in_sec */)
    * axis_hinge_dist_mm
    * 2 * PI
    * nr_teeth_big
    / (bolt_thread_mm * nr_teeth_small);

#if DEBUG || MODERATE_DEBUG

#if MODERATE_DEBUG
  if (!(loop_count % 100)) {
#endif
  debug_long(s);

  Serial.print("Angle final: ");
  Serial.println(r);

#if MODERATE_DEBUG
  }
#endif /* MODERATE_DEBUG */
#endif /* DEBUG */
  return r;
}

static unsigned int get_step_number(rot_state_t *s, float expected_rotation) {
  const float angle_diff = expected_rotation - s->stepper_gear_rot_rad;
  const float fsteps = angle_diff / stepper_gear_rad_per_step;
  const int steps = floor(fsteps);
  
#if DEBUG
  Serial.print("current rot:");
  Serial.println(s->stepper_gear_rot_rad, 6);
  Serial.print("diff :");
  Serial.print(angle_diff, 6);
  Serial.print(" needed steps : ");
  Serial.print(steps);
  Serial.print(" with fsteps: ");
  Serial.println(fsteps);

  const float round_per_minutes = (60000/global_period_msec)*fsteps*stepper_gear_rad_per_step;
  Serial.print("RAD per minutes (stepper) : ");
  Serial.println(round_per_minutes, 6);
  const float round_per_minutes_drive = round_per_minutes * (nr_teeth_small / nr_teeth_big);
  Serial.print("RAD per minutes (drive) : ");
  Serial.println(round_per_minutes_drive, 6);


#endif
  return steps;
}

static void set_stepper_rotation(rot_state_t *s, float angle){
  const unsigned int needed_steps = get_step_number(s, angle);
  if (stepper_direction) {
    stepper.move(needed_steps);
  } else {
    stepper.move(-needed_steps);
  }

  s->stepper_gear_rot_rad += needed_steps * stepper_gear_rad_per_step;
}


static void start_timer(unsigned long period) {
#if DEBUG
  Serial.println("start timer");
#endif

  if (use_active_wait) {
    // be careful: remain is signed and period is unsigned.
    active_timer.period = active_timer.remain = period;
    active_timer.deadline = millis() + period;
  }

#if DEBUG == 2
  Serial.print("Start Timer: ");
  Serial.println(active_timer.remain);
#endif

}

static void stop_timer(void) {
  if (use_active_wait){
    active_timer.deadline = active_timer.remain = 0;
  }

  //disable timer interrupt
  // disable timer
}

static void handle_active_timer(void){

#if DEBUG == 2
  Serial.print("Timer: ");
  Serial.println(active_timer.remain);
#endif
  unsigned long current_time = millis();

  if (active_timer.deadline){
    active_timer.remain = active_timer.deadline - current_time;
    if (active_timer.remain > active_timer.deadline) {
      // unsigned underflow
      active_timer.remain = 0;
    }
  } else {
    return;
  }

  if (active_timer.remain <= active_threshold) {
    active_timer.remain = active_timer.period;
    active_timer.deadline = current_time + active_timer.period;
    active_timer.expired++;

#if DEBUG || MODERATE_DEBUG
    loop_count++;
#endif

#if DEBUG
    Serial.println("Timer expired");
    Serial.println(active_timer.expired);
    Serial.println(active_timer.remain);
    Serial.println(loop_count);
#endif
  }
}

#if WEAK_DEBUG
static bool new_state = true;

#define STATE(name)				\
  if (new_state) {				\
    Serial.print("ENTERING STATE: ");		\
    Serial.println(#name);			\
    new_state = false;				\
  }
#define NEXT_STATE(name)			\
  do {						\
    new_state = true;				\
    control_state = name;			\
  } while(0)
    
#else
#define STATE(name)
#define NEXT_STATE(name)			\
  control_state = name;

#endif

static void control_automata(void) {

#if DEBUG == 2
  Serial.println("Automata step...");
#endif

  button1Switch.poll();

  switch(control_state){
  case STARTUP: // Should happen only once
    STATE(STARTUP);
    NEXT_STATE(IDLE);
    break;

  case IDLE:
    STATE(IDLE);
    if (button1Switch.pushed()) {
      NEXT_STATE(RUN_OR_RESET);
      dwprint("Pushed: IDLE => RUN_OR_RESET");
    }

    break;

  case RUN_OR_RESET: {
    STATE(RUN_OR_RESET);
    unsigned long reset_delay = millis() + 500;
    NEXT_STATE(RUN);

    // stepper will be used in both exit states
    stepper.enable();

    while(millis() < reset_delay) {
      button1Switch.poll();

      if (button1Switch.pushed()) {
	NEXT_STATE(RESET_POSITION);
	dwprint("Pushed RUN_OR_RESET => RESET_POSITION");
	break;
      }
    }

    if (control_state == RUN) { // means not pushed during waiting time
      dwprint("NOT Pushed RUN_OR_RESET => RUN");
      start_timer(global_period_msec);
    }
    break;
  }
  case RUN:
    STATE(RUN);
    if (button1Switch.pushed()) {
      dwprint("Short press RUN => IDLE");
      stop_timer();
      stepper.disable();
      NEXT_STATE(IDLE);
    } else if (active_timer.expired) {
      active_timer.expired--;
      // emit_motor_step();
      // step_motor();
      rot_state.elapsed_time_millis += active_timer.period;
      const float expected_rot = get_expected_stepper_rot(&rot_state);
      set_stepper_rotation(&rot_state, expected_rot);

#if ENABLE_LED_BLINK
      blink_led();
#endif
    }

    break;

  case RESET_POSITION: {
    STATE(RESET_POSITION);
    unsigned long debounce_reset = millis();
    int reset_done = 0;

    while(!reset_done) {
      if (stepper_direction) {
	stepper.move(-1);
      } else {
	stepper.move(1);
      }

      int level = digitalRead(end_stop_pin);
      if ( level == HIGH) {
	debounce_reset = millis();
      } else {
	if (millis() - debounce_reset > 50) {
	  reset_done = 1;
	}
      }
    }
    NEXT_STATE(IDLE);
    stepper.disable();
    dwprint("Finished RESET, => IDLE");
    break;
  }
  }

#if DEBUG == 2
  Serial.println("End of Automata step...");
#endif

}

void setup() {
  // debug output
  Serial.begin(serial_speed);

  dwprint("Serial setup");

  // Set target motor RPM to 1RPM
  stepper.setRPM(30);
  // Set full speed mode (microstepping also works for smoother hand movement
  stepper.setMicrostep(microstepping_div);
  dwprint("Microstepping is");
  dwprint(microstepping_div);

  stepper.disable();

  // Setup PIN as GPIO output
  pinMode(led_pin, OUTPUT);    // LED pin

  // Button input with pullups enable
  //  pinMode(btn1_pin, INPUT);
  // pinMode(btn2_pin, INPUT_PULLUP);
  // pinMode(btn3_pin, INPUT_PULLUP);
  pinMode(end_stop_pin, INPUT_PULLUP);

  // Initial setup for motor driver
  // digitalWrite(led_pin, HIGH);
  // delay(200);    // Initial delay
  // digitalWrite(led_pin, LOW);

  dwprint("Setup finished, starting loop");
}

void loop(void) {
  if (use_active_wait)
    handle_active_timer();

  control_automata();
}
