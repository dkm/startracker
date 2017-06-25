// https://www.thingiverse.com/thing:1729344/#files
// Dolica Tripod Quick Release Base by tdeagan is licensed under the Creative Commons - Attribution license. 

// Remix by Marc Poulhiès.

dim_x = 40.35;
dim_y = 39.3;
dim_y2 = 32.375;
dim_z = 3;
dim_z2 = 9;

hex_nut_diam = 1.8*3; // M3
screw_diam = 3.3; // M3

//translate([0,0,dim_z2-dim_z/2]){
//    color("green"){cube([dim_x+10,dim_y2,dim_z2-dim_z],true);}
//}

module screw_hole(x,y) {
            translate([x,y,-2]){
            #cylinder(h=30,d=screw_diam, center=true, $fn=20);
            #cylinder(h=3, d=hex_nut_diam, center=true, $fn=6);
        }
}

translate([0,0,dim_z2/2]){
    difference(){
        translate([0,0,dim_z2/2-dim_z]){
            cube([dim_x,dim_y,dim_z2],true);
        }
        
        translate([-(dim_x+4)/2,(dim_y/2),0]){
        rotate([30,0,0]){
            #cube([dim_x+4,10,10]);
        }}
        
        mirror([0,1,0]){
        translate([-(dim_x+4)/2,(dim_y/2),0]){
        rotate([30,0,0]){
            #cube([dim_x+4,10,10]);
        }}}
        
        screw_hole(12,12);
        screw_hole(12,-12);
        screw_hole(-12,-12);
        screw_hole(-12,12);

    }
}


