rad = 31;
dx = rad/2;
hole_sz=6.5;
shaft_sz=15;

full_h = 4;

module screw_hole(x,y) {
    translate([x,y,0]){
        linear_extrude(height = full_h+5, center = true, convexity = 10, twist = 0, slices = 20, scale = 1.0) {
            circle(d=hole_sz, $fn=50);
        }
    }
}


module ring(inner, outer, height) {
    difference() {
        cylinder(h=height, r=outer, center=true, $fn=50);
        cylinder(h=height+1, r=inner, center=true, $fn=50);
    }
}

union() {
    difference() {
        hull() {
//          cube([42.3,42.3,full_h], center=true);
        translate([17,17,0]) cylinder(r=6,h=full_h,center=true);
        translate([-17,17,0]) cylinder(r=6,h=full_h,center=true);
        translate([-17,-17,0]) cylinder(r=6,h=full_h,center=true);
        translate([17,-17,0]) cylinder(r=6,h=full_h,center=true);            
        }  
        translate([0,0,-1]){
            screw_hole(dx,dx);
            screw_hole(dx, -dx);
            screw_hole(-dx,dx);
            screw_hole(-dx,-dx);
            
            linear_extrude(height = full_h+4, center = true, convexity = 10, twist = 0, slices = 20, scale = 1.0) {
                circle(d=shaft_sz, $fn=50);
            };
        }
    }
    
    translate([0,0,full_h/2]) {
        ring(15/2,20/2,2);
    }
}
 