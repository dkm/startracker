// 0 = all, 1=only the bracket
export_set = 0;

laser_pen_diam = 15;

holder_spacing=60;

holder_len = 18;
holder_width = 5;
holder_height = laser_pen_diam + 4;

holder_back_len =  holder_spacing + holder_width + 10;

module pad(l,h,z) {
    linear_extrude(height = z, center = false, convexity = 10, twist = 0) {
        polygon(points = [ [0,0], [0,l], [h,0]]);
    }
}

module screw_hole(y,z) {
    translate(v=[-9,y,z])
        rotate(a=90, v=[0,1,0]){
            cylinder(h=2.5, d=1.8*3.2, $fn=6);
        }
    translate(v=[-20,y,z]){
        rotate(a=90, v=[0,1,0]){
            cylinder(h=30, d=3.2,$fn=10);
        }            
    }
}

//module pico_haut(){
//translate(v=[holder_len/2,0,5]){
//                    rotate(a=90, v=[1,0,0]) {
//                        cylinder(h=holder_width,
//                                        d=2,center=true, $fn=20);
//                    }
//                }
//}

module start_stop_cyl(){
        translate(v=[holder_len/2-.5, 0, 4]){
            rotate(a=90, v=[1,0,0]) {
                cylinder(h=holder_width,
                                d=1.8,center=true, $fn=20);
            }
        }
        translate(v=[0, 0, -holder_height/2+.5]){
            rotate(a=90, v=[1,0,0]) {
                cylinder(h=holder_width,
                                d=1.8,center=true, $fn=20);
            }
        }
}

module holder_base(){
    union(){
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
        translate(v=[-7,0,4])
            pad(6,5,5);
        
          translate(v=[-7,0,-7])
            pad(6,5,5);
        
             rotate(a=180, v=[1,0,0])
                  translate(v=[-7,0,-8])
            pad(6,5,5);          
        
        rotate(a=180, v=[1,0,0])
                  translate(v=[-7,0,4])
            pad(6,5,5);          
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
                translate(v=[holder_len/3,0,-holder_height/4]) {
                    #cube([holder_len/2+3,
                                 holder_width+1,
                                 holder_height/2+7],
                                 center=true);
                }
            }
            start_stop_cyl();
            
        }
    }
}

difference(){
    union(){
        holder(0);
        if (export_set == 0) {
            holder(holder_spacing);
            translate(v=[-holder_len/2,holder_spacing/2,0]){
                cube([5,holder_back_len,21], center=true);
            }
        }
    //    
    //    translate(v=[-holder_len/2,holder_spacing/2,-3]){
    //        cube([5,holder_spacing+holder_width,20], center=true);
    //    }
    }
    screw_hole(10,5);
    screw_hole(10,-5);
    screw_hole(50,5);
    screw_hole(50,-5);
}

