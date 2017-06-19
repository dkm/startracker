rad = 31;
dx = rad/2;
hole_sz=3.2;
shaft_sz=7;

full_h = 3;

difference() {
linear_extrude(height = full_h, center = false, convexity = 10, twist = 0, slices = 20, scale = 1.0) {square([42.3,42.3],true);}

translate([0,0,-1]){
translate([dx,dx,0]){
    linear_extrude(height = full_h+2, center = false, convexity = 10, twist = 0, slices = 20, scale = 1.0) {circle(d=hole_sz, $fn=20);}
}
translate([dx,-dx,0]){
    linear_extrude(height = full_h+2, center = false, convexity = 10, twist = 0, slices = 20, scale = 1.0) {circle(d=hole_sz, $fn=20);}
}
translate([-dx,dx,0]){
    linear_extrude(height = full_h+2, center = false, convexity = 10, twist = 0, slices = 20, scale = 1.0) {circle(d=hole_sz, $fn=20);}
}
translate([-dx,-dx,0]){
    linear_extrude(height = full_h+2, center = false, convexity = 10, twist = 0, slices = 20, scale = 1.0) {circle(d=hole_sz, $fn=20);}
}
 linear_extrude(height = full_h+2, center = false, convexity = 10, twist = 0, slices = 20, scale = 1.0) {circle(d=shaft_sz, $fn=20);};

}
 translate([0,0,full_h-2]){
 linear_extrude(height = full_h, center = false, convexity = 10, twist = 0, slices = 20, scale = 1.0) {circle(d=25, $fn=20);};
}

 }
     
 