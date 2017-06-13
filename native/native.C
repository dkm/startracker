#include <stdio.h>
#include <math.h>

static const double nr_teeth_small = 11.0;
static const double nr_teeth_big = 53.0;
static const double axis_hinge_dist_mm = 200;

#define PI M_PI

static const double earth_rot_speed_rad_sec = 2*PI / (1440*60*1000);
static const double bolt_thread_mm = 1.25;


/* static const unsigned int microstepping_div = 16; */
/* static const unsigned int nr_steps = 200 * microstepping_div; */

/* static const double stepper_gear_rad_per_step = (2*PI) / nr_steps; */


// this needs to be reset
/* static struct rot_state_t { */
/*   unsigned long elapsed_time_millis; */
/*   double stepper_gear_rot_rad = 0; */
/* } rot_state; */


static double get_expected_stepper_rot(unsigned long elapsed_time_millis) {
  const double r = tan(fmod(earth_rot_speed_rad_sec * (elapsed_time_millis), PI)) * axis_hinge_dist_mm * 2 * PI * nr_teeth_big / (bolt_thread_mm * nr_teeth_small);

  return r;
}


int main(int argc, char **argv) {
  unsigned long millis_step = 0;

  for (millis_step=0; millis_step < 1000; millis_step++) {
    printf("%d (%d sec) : %f\n", millis_step*1000, millis_step, get_expected_stepper_rot(millis_step * 1000));

  }
  return 0;
}
