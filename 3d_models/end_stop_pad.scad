module pad_base(l,d,h1,h2, grip) {
    base_offset = 0-grip * 2;
    shoulder_sz=7;
    
    rotate([90,0,0]) {
        difference() {
            union() {
                translate([0,-2*grip,d/2-shoulder_sz/2]) cube(size=[l,grip*3,shoulder_sz], center=false);
                linear_extrude(height = d, center = true, convexity = 10, twist = 0) {
	            polygon(points=[[0,base_offset], [0,h1], [l,h2],[l,base_offset]]);
	        }
            }
	    translate([-1,-grip,-(d/2+2)]) #cube([l+2,grip,d+2], false);
        }
    }
}
pad_base(50,30,21.8,12,1.9);
