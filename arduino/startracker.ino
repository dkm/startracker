// STARTRACKER MOTOR CONTROL: STEPPER MOTOR CONTROL FOR JJROBOTS POV DISPLAY
// This code is designed for JJROBOTS arDusplay Stepper Motor Control board
// Author: JJROBOTS.COM (Jose Julio & Juan Pedro)
// Licence: GNU GPL
// Stepper : NEMA17
// Driver : A4988 or DRV8825
// Microstepping : configured to 1/16
// Arduino board: Pro micro (leonardo equivalent)

// STEPPER DRIVER CONNECTED TO:
// ENABLE pin: D10   (PB6)
// DIR pin:  D9      (PB5) 
// STEP pin: D8      (PB4)
// Button1 : START/STOP  D4
// Button2 : DEC   D5
// Button3 : CHANGE ROTATION DIRECTION (go back to original position)  D6

//DO NO TAKE PHOTOS WITH AN EXPOSITION LONGER THAN 5 MINUTES. THE DRIFT WOULD BE NOTICEABLE.

//Theory behind this CODE
//-----------------------------------------
// 360º (rotation of the Earth every 1436min)
// *Using a M8 rod coming up 1.25mm every complete rotation

#define COMINGUPSPEED 1.25  //milimeters that the rod comes up every complete rotation (360º). In a M8 rod/bolt is usually 1.25 mm. In a M6, only 1.00mm


//other info needed:
//ratio between the large gear and the small one=0.2549

//MEASURE THIS VALUE AS GOOD AS YOU CAN AND SET THE LENGHT BELOW
#define LENGTH 228 //distance from the centre of the hinge to the centre of the hole for the rod in milimiters


// Calculus here:
#define STEP ((2*3.14159)/1436)*LENGTH //rotational velocity of the small gear

#define RPS (STEP/(60*0.2549))/COMINGUPSPEED //rotational velocity of the large gear


#define ZERO_SPEED 65535
#define STEPS_PER_REV 3200     // 200 steps motor with 1/16 microstepping
#define MAX_RPM (RPS*60.0)   

static const unsigned int led_pin = 7;
static const unsigned int step_pin = 8;
static const unsigned int dir_pin = 9;
static const unsigned int enable_pin = 10;

static const unsigned int btn1_pin = 4;
static const unsigned int btn2_pin = 11;
static const unsigned int btn3_pin = 6;

static const unsigned long serial_speed = 115200UL;

#define DEBUG (1)

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

void start_timer(int freq) {
  // compute frequency
  // configure timer
  // enable timer interrupt
#if DEBUG
  Serial.println("start timer");
#endif

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

void stop_timer(void) {
  //disable timer interrupt
  // disable timer
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
      start_timer();
    }
    break;
  case RUN:
    if (digitalRead(btn1_pin)==LOW) {   // START/STOP Button pressed
      while (digitalRead(btn1_pin)==HIGH); // START/STOP released
      stop_timer();
      control_state = IDLE;
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

  control_state = IDLE;

  // Setup PIN as GPIO output
  pinMode(led_pin, OUTPUT);    // LED pin
  pinMode(step_pin, OUTPUT);    // STEP pin
  pinMode(dir_pin, OUTPUT);    // DIR pin
  pinMode(enable_pin, OUTPUT);   // ENABLE pin
  
  // Button input with pullups enable
  pinMode(btn1_pin, INPUT_PULLUP);
  pinMode(btn2_pin, INPUT_PULLUP);
  pinMode(btn3_pin, INPUT_PULLUP);

  // Initial setup for motor driver
  digitalWrite(enable_pin, HIGH);  // Disable motor
  digitalWrite(dir_pin, HIGH);     // Motor direction

  // debug output
  Serial.begin(serial_speed);
#if DEBUG
  Serial.println("Serial setup");
#endif

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
