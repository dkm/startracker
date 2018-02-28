endstop_l = 27.9;
endstop_l2 = 16.4;
endstop_w = 10;
endstop_h = 15.6;

module endstop() {
       union () {
           cube([endstop_w, endstop_h, endstop_l2], false);
           cube([endstop_w, endstop_h+30, endstop_l2+20], false);
       }
}

module pad_base(l,d,h1,h2, grip) {
    base_offset = 0-grip * 2;
    shoulder_sz=7;
    
        difference() {
            union() {
                // translate([0,-2*grip,d-shoulder_sz/2]) cube(size=[l,grip*3,shoulder_sz], center=false);
                linear_extrude(height = d+shoulder_sz, center = false, convexity = 10, twist = 0) {
	            polygon(points=[[0,base_offset], [0,h1], [l,h2],[l,base_offset]]);
	        }
            }
	    translate([-1,-grip,-2]) #cube([l+2,grip,d+2], false);
	    translate([23,0,d-endstop_l2]) #endstop();
        }
}
pad_base(50,30,21.8,12,2.1);
