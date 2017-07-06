#include <stdio.h>
#include <math.h>

#include "../arduino/teeth_config.h"

static const float nr_teeth_small = CONFIG_TEETH_SMALL; // 13.0
static const float nr_teeth_big = CONFIG_TEETH_BIG; // 51.0
static const float axis_hinge_dist_mm = 200;

#define PI M_PI

// Use immediate value. Using symbolic values leads to incorrect value.
static const float earth_rot_speed_rad_msec = 7.272205e-8; //2*PI / (1440*60);

static const float bolt_thread_mm = 1.25;


/* static const unsigned int microstepping_div = 16; */
/* static const unsigned int nr_steps = 200 * microstepping_div; */

/* static const double stepper_gear_rad_per_step = (2*PI) / nr_steps; */


// this needs to be reset
/* static struct rot_state_t { */
/*   unsigned long elapsed_time_millis; */
/*   double stepper_gear_rot_rad = 0; */
/* } rot_state; */

static double get_expected_stepper_rot(unsigned long elapsed_time_millis) {
  const float r = tan(earth_rot_speed_rad_msec * elapsed_time_millis)
    * axis_hinge_dist_mm
    * 2 * PI
    * nr_teeth_big
    / (bolt_thread_mm * nr_teeth_small);

  // const float r = tan(earth_rot_speed_rad_sec * (elapsed_time_millis)) * axis_hinge_dist_mm * 2 * PI * nr_teeth_big / (bolt_thread_mm * nr_teeth_small);

  return r;
}


int main(int argc, char **argv) {
  unsigned long sec_step = 0;

  for (sec_step=0; sec_step < 1000; sec_step++) {
    const float exp = get_expected_stepper_rot(sec_step * 1000);
    printf("%d (%d sec) : %f (%f rounds)\n", sec_step*1000, sec_step, exp, exp/(2*PI));

  }
  return 0;
}
