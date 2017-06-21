
laser_pen_diam = 9;

holder_spacing=60;

holder_len = 14;
holder_width = 5;
holder_height = laser_pen_diam + 4;

module pico_haut(){
translate(v=[holder_len/2,0,.5]){
                    rotate(a=90, v=[1,0,0]) {
                        cylinder(h=holder_width,
                                        d=2,center=true, $fn=20);
                    }
                }
}

module start_stop_cyl(){
        translate(v=[holder_len/2, 0, .5]){
            rotate(a=90, v=[1,0,0]) {
                cylinder(h=holder_width,
                                d=1.8,center=true, $fn=20);
            }
        }
        translate(v=[holder_len/4, 0, -holder_height/2+.5]){
            rotate(a=90, v=[1,0,0]) {
                cylinder(h=holder_width,
                                d=1.8,center=true, $fn=20);
            }
        }
}

module holder_base(){
    hull(){
        translate(v=[holder_len/2-1,  0, holder_height/2]){
            rotate(a=90, v=[1,0,0]) {
                cylinder(h=holder_width,
                                d=2,center=true, $fn=20);
            }
        }     
         translate(v=[-holder_len/2,  0, holder_height/2,]){
            rotate(a=90, v=[1,0,0]) {
                cylinder(h=holder_width,
                                d=2,center=true, $fn=20);
            }
        }
        translate(v=[-holder_len/2, 0, -holder_height/2]){
            rotate(a=90, v=[1,0,0]) {
                cylinder(h=holder_width,
                                d=2,center=true, $fn=20);
            }
        }
        start_stop_cyl();
    }
}
        



module holder(pos_y) {
    translate(v=[0,pos_y,0]){
        union(){
            difference() {
                holder_base();
                translate(v=[2,0,-1]){
                    rotate(a=90, v=[1,0,0] ){
                        cylinder(h = holder_width+1,
                                        d = laser_pen_diam, 
                                        center = true,
                                        $fn=30);
                    }
                }
                translate(v=[holder_len/2,0,-holder_height/4]) {
                    cube([holder_len/2,
                                holder_width+1,
                                holder_height/2],
                                center=true);
                }
            }
            start_stop_cyl();
        }
    }
}

union(){
    holder(0);
    holder(holder_spacing);
    
    translate(v=[-holder_len/2,holder_spacing/2,-3]){
        cube([5,holder_spacing+holder_width,20], center=true);
    }
}