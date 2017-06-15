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
static const unsigned int m0_pin = 5;
static const unsigned int m1_pin = 6;
static const unsigned int m2_pin = 7;

static const unsigned int enable_pin = led_pin;

// using a 200-step motor (most common)
// pins used are DIR, STEP, MS1, MS2, MS3 in that order
//A4988 stepper(200, 8, 9, 10, 11, 12);
DRV8825 stepper(200, dir_pin, step_pin,
		enable_pin,
		m0_pin, m1_pin, m2_pin);

#ifndef DEBUG
#define DEBUG (1)
#endif

//other info needed:
//ratio between the large gear and the small one=0.2549

// Science here !
static const float nr_teeth_small = 11.0;
static const float nr_teeth_big = 53.0;
static const float axis_hinge_dist_mm = 200;

// Use immediate value. Using symbolic values leads to incorrect value.
static const float earth_rot_speed_rad_msec = 7.272205e-8; //2*PI / (1440*60);

static const float bolt_thread_mm = 1.25;
//static const float coef = 2*PI*axis_hinge_dist_mm * nr_teeth_big / (bolt_thread_mm * nr_teeth_small);

static const unsigned int microstepping_div = 2;
static const unsigned int nr_steps = 200 * microstepping_div;

static const float stepper_gear_rad_per_step = (2*PI) / nr_steps;

// this needs to be reset
static struct rot_state_t {
  unsigned long elapsed_time_millis;
  float stepper_gear_rot_rad = 0;
} rot_state;

#define DUMP(v) do { \
  Serial.print(#v " "); \
  Serial.println(v, 10);			\
} while(0)

static void debug_long(rot_state_t *s){
  const unsigned long ellapsed_in_sec = s->elapsed_time_millis/1000;
  DUMP(ellapsed_in_sec);
  DUMP(earth_rot_speed_rad_msec);
  DUMP(axis_hinge_dist_mm);
  DUMP(nr_teeth_big);
  DUMP(nr_teeth_small);
  DUMP(bolt_thread_mm);
  DUMP(PI);
}

static float get_expected_stepper_rot(rot_state_t *s) {
  const unsigned long ellapsed_in_sec = s->elapsed_time_millis/1000;
  const float r = tan(earth_rot_speed_rad_msec * s->elapsed_time_millis /* ellapsed_in_sec */) * axis_hinge_dist_mm * 2 * PI * nr_teeth_big / (bolt_thread_mm * nr_teeth_small);

#if DEBUG
  debug_long(s);
  Serial.print("Angle final: ");
  Serial.println(r);
#endif
  return r;
}

static unsigned int get_step_number(rot_state_t *s, float expected_rotation) {
  const float angle_diff = expected_rotation - s->stepper_gear_rot_rad;
  const float fsteps = angle_diff / stepper_gear_rad_per_step;
  const int steps = floor(fsteps);
  
#if DEBUG
  Serial.print("diff :");
  Serial.print(angle_diff, 6);
  Serial.print(" needed steps : ");
  Serial.print(steps);
  Serial.print(" with fsteps: ");
  Serial.println(fsteps);
#endif
  return steps;
}

static void set_stepper_rotation(rot_state_t *s, float angle){
  const unsigned int needed_steps = get_step_number(s, angle);
  stepper.move(needed_steps);

  s->stepper_gear_rot_rad += needed_steps * stepper_gear_rad_per_step;
}


static unsigned int loop_count = 0;

static const unsigned int btn1_pin = 4;
static const unsigned int btn2_pin = 5;
static const unsigned int btn3_pin = 6;

static const unsigned long serial_speed = 115200UL;

#define ENABLE_LED_BLINK (0)

#define USE_ACTIVE_WAIT (1)
static const int use_active_wait = USE_ACTIVE_WAIT;
static const long active_threshold = 10;

static struct {
  unsigned long period;
  unsigned long deadline;
  long          remain;
  unsigned int  expired;
} active_timer;

static unsigned long global_period = 500;

static const int fake_start = 1;

// BIT functions
#define CLR(x,y) (x&=(~(1<<y)))
#define SET(x,y) (x|=(1<<y))

//uint16_t rpm;
float rpm;
uint16_t period;
uint16_t userCommand=0;

static bool motor_enable;

/* // TIMER 1: STEP INTERRUPT */
/* ISR(TIMER1_COMPA_vect) */
/* { */
/*   if (motor_enable) */
/*     { */
/*       SET(PORTB, step_pin); */
/*       delayMicroseconds(2); */
/*       CLR(PORTB, step_pin); */
/*     } */
/* } */

static enum control_state_e {
  IDLE = 0,
  RUN  = 1,
} control_state;

#if ! USE_ACTIVE_WAIT
ISR(TIMER1_COMPA_vect) {
  // THIS AUTOMATA MUST NOT CHANGE STATE.
  // Let control automata take care of state change
#if DEBUG
  Serial.println("in ISR");
#endif

  switch(control_state) {
  case IDLE:
    // spurious timer IT, ignore
    break;

  case RUN:
    // emit STEP
    break;
  }
}
#endif /* USE_ACTIVE_WAIT */

static void step_motor(void) {
  //SET(PORTB, step_pin);
#if DEBUG == 1
  Serial.println("step in");
#endif
  
  stepper.rotate(360);

  /* digitalWrite(step_pin, HIGH); */
  /* delayMicroseconds(2); */
  /* digitalWrite(step_pin, LOW); */
#if DEBUG == 1
  Serial.println("step out");
#endif

}

static void blink_led(void) {

#if DEBUG == 2
  Serial.println("blink");
#endif

  digitalWrite(led_pin, HIGH);
  delay(10);    // Initial delay
  digitalWrite(led_pin, LOW);
}

void start_timer(int period) {
#if DEBUG
  Serial.println("start timer");
#endif

  if (use_active_wait) {
    active_timer.period = active_timer.remain = period;
    active_timer.deadline = millis() + period;
  } else {
    // compute frequency
    // configure timer
    // enable timer interrupt

    noInterrupts();           // disable all interrupts

    TCCR1A = 0;
    TCCR1B = 0;
    TCNT1  = 0;

  
    OCR1A = (16000000/256); // 62500 ~ 1Hz
    TCCR1B |= (1 << WGM12);   // CTC mode
    TCCR1B |= (1 << CS12);    // 256 prescaler 
    TIMSK1 |= (1 << OCIE1A);  // enable timer compare interrupt

    interrupts();             // enable all interrupts
  }

#if DEBUG == 2
  Serial.print("Start Timer: ");
  Serial.println(active_timer.remain);
#endif

}

void stop_timer(void) {
  if (use_active_wait){
    active_timer.deadline = active_timer.remain = 0;
  }

  //disable timer interrupt
  // disable timer
}

void handle_active_timer(void){
#if DEBUG == 2
  Serial.print("Timer: ");
  Serial.println(active_timer.remain);
#endif
  if (active_timer.deadline){
    active_timer.remain = active_timer.deadline - millis();
  }

  if (active_timer.remain <= active_threshold) {
    active_timer.remain = active_timer.period;
    active_timer.deadline = millis() + active_timer.period;
    active_timer.expired++;
    loop_count++;
#if DEBUG
    Serial.println("Timer expired");
    Serial.println(active_timer.expired);
    Serial.println(active_timer.remain);
    Serial.println(loop_count);
#endif
  }
}

static void emit_motor_step(void) {
  SET(PORTB, step_pin);
  delayMicroseconds(2);
  CLR(PORTB, step_pin);
}

void control_automata(void) {
#if DEBUG == 2
  Serial.println("Automata step...");
#endif

  switch(control_state){
  case IDLE:
    if (fake_start || digitalRead(btn1_pin)==LOW) {   // START/STOP Button pressed
      if (!fake_start) while (digitalRead(btn1_pin)==HIGH); // START/STOP released
      control_state = RUN;
      start_timer(global_period);
    }
    break;

  case RUN:
    if (digitalRead(btn1_pin)==LOW) {   // START/STOP Button pressed
      while (digitalRead(btn1_pin)==HIGH); // START/STOP released
      stop_timer();
      control_state = IDLE;
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
  }

#if DEBUG == 2
  Serial.println("End of Automata step...");
#endif

}


/* void setRpm() */
/* { */
/*   float temp; */
/*   if (rpm == 0) */
/*     { */
/*       ICR1 = ZERO_SPEED; */
/*       digitalWrite(enable_pin, HIGH);  // Disable motor */
/*     } */
/*   else */
/*     { */
/*       digitalWrite(enable_pin, LOW);  // Enable motor */
/*       /\*   if (rpm<8) */
/* 	   rpm = 8;*\/ */
/*       if (rpm>MAX_RPM) */
/* 	rpm = MAX_RPM; */
/*       temp = (rpm/60.0)*STEPS_PER_REV; // Number of steps per seconds needed */
/*       temp = 2000000 / temp;          //  2000000 = (16000000/8) timer1 16Mhz with 1/8 preescaler */
/*       if (period<600000) */
/* 	period=60000; */
/*       period = temp; */
/*       while (TCNT1 < 30);   // Wait until a pulse to motor has finished */
/*       //cli(); */
/*       ICR1 = period; //+ userCommand; */
/*       if (TCNT1 > ICR1)     // Handle when we need to reset the timer */
/* 	TCNT1=0; */
/*       //sei(); */
/*     } */
/* } */

void setup() {
  // debug output
  Serial.begin(serial_speed);
#if DEBUG
  Serial.println("Serial setup");
#endif

  stepper.enable();

  // Set target motor RPM to 1RPM
  stepper.setRPM(200);
  // Set full speed mode (microstepping also works for smoother hand movement
  stepper.setMicrostep(1);

  control_state = IDLE;

  // Setup PIN as GPIO output
  pinMode(led_pin, OUTPUT);    // LED pin


  /* pinMode(step_pin, OUTPUT);    // STEP pin */
  /* pinMode(dir_pin, OUTPUT);    // DIR pin */

  //  pinMode(enable_pin, OUTPUT);   // ENABLE pin

  /* digitalWrite(dir_pin, HIGH);     // Motor direction */
  /* digitalWrite(step_pin, HIGH); */
  /* while(1); */

  // Button input with pullups enable
  pinMode(btn1_pin, INPUT_PULLUP);
  pinMode(btn2_pin, INPUT_PULLUP);
  pinMode(btn3_pin, INPUT_PULLUP);

  // Initial setup for motor driver
  //  digitalWrite(enable_pin, HIGH);  // Disable motor
  /* digitalWrite(dir_pin, HIGH);     // Motor direction */

  digitalWrite(led_pin, HIGH);
  delay(200);    // Initial delay
  digitalWrite(led_pin, LOW);

  motor_enable = false;
  
  /* // PWM SETUP */
  /* // Fast PWM mode => TOP:ICR1 */
  /* TCCR1A =(1<<WGM11);            */
  /* //  TCCR1B = (1<<WGM13)|(1<<WGM12)|(1<<CS10);   //No Prescaler, Fast PWM */
  /* TCCR1B = (1<<WGM13)|(1<<WGM12)|(1<<CS11);   // Prescaler 1:8, Fast PWM */
  /* ICR1 = ZERO_SPEED; */
  /* TIMSK1 = (1<<OCIE1A);  // Enable Timer interrupt */
  
  /* rpm = 0; */
  
  /* while (digitalRead(4)==HIGH);    // Wait until START button is pressed */
  /* motor_enable = true; */
  /* delay(250); */
  /* while (digitalRead(4)==LOW); */
}

void loop(void) {
  if (use_active_wait)
    handle_active_timer();

  control_automata();

  /* if (digitalRead(btn1_pin)==LOW)   // START/STOP Button pressed? */
  /*   { */
  /*     rpm = 0; */
  /*     userCommand=0; */
  /*     setRpm(); */

  /*     motor_enable = !motor_enable; */

  /*     /\* if (motor_enable) *\/ */
  /*     /\*   motor_enable = false; *\/ */
  /*     /\* else *\/ */
  /*     /\*   motor_enable = true; *\/ */

  /*     while (digitalRead(btn1_pin)==LOW);   // Wait until botton release */
  /*   } */
    
  /* if (digitalRead(btn3_pin)==LOW)   //  Button 3 pressed? */
  /*   { */
  /*     Serial.println("Coming back"); */
	
  /*     digitalWrite(btn3_pin, HIGH);    // Motor direction */

  /*     rpm=50;  */
  /*     setRpm(); */
	
  /*     if (motor_enable == 1) */
  /* 	motor_enable = 0; */
  /*     else */
  /* 	motor_enable = 1; */
         
  /*     while (digitalRead(btn3_pin)==LOW);   // Wait until botton release */
  /*   } */
    
    
  /* if (motor_enable) */
  /*   { */
  /*     rpm++; */
  /*     digitalWrite(led_pin, HIGH); */
  /*   } */
  /* else */
  /*   { */
  /*     rpm = 0; */
  /*     digitalWrite(led_pin, LOW); */
  /*   } */
  /* Serial.print("RPM:"); */
  /* Serial.print(rpm); */
  /* Serial.print(" "); */
  /* Serial.println(period+userCommand); */
  /* setRpm(); */
  /* Serial.print("100xRPS large gear:"); */
  /* Serial.print(RPS/0.2549); */
  /* Serial.print(" "); */
  /* Serial.print("STEP:"); */
  /* Serial.print(STEP); */
  /* Serial.print(" "); */
  /* delay(10); */
  
  /* if (digitalRead(btn2_pin)==LOW)   // Decrease button */
  /*   { */
  /*     digitalWrite(led_pin, LOW); */
  /*     userCommand--; */
  /*     while (digitalRead(btn2_pin)==LOW);  // Wait until released */
  /*   } */
  /* if (digitalRead(btn3_pin)==LOW)   // Increase button */
  /*   { */
  /*     digitalWrite(led_pin, LOW); */
  /*     userCommand++; */
  /*     while (digitalRead(btn3_pin)==LOW);  // Wait until released */
  /*   } */
}
