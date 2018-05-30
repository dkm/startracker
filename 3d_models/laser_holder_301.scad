
// Arc Module for OpenSCAD by chickenchuck040 is licensed under the Creative Commons - Attribution license.
// https://www.thingiverse.com/thing:1092611/#files

module arc(radius, thick, angle){
        intersection(){
                union(){
                        rights = floor(angle/90);
                        remain = angle-rights*90;
                        if(angle > 90){
                                for(i = [0:rights-1]){
                                        rotate(i*90-(rights-1)*90/2){
                                                polygon([[0, 0], [radius+thick, (radius+thick)*tan(90/2)], [radius+thick, -(radius+thick)*tan(90/2)]]);
                                        }
                                }
                                rotate(-(rights)*90/2)
                                        polygon([[0, 0], [radius+thick, 0], [radius+thick, -(radius+thick)*tan(remain/2)]]);
                                rotate((rights)*90/2)
                                        polygon([[0, 0], [radius+thick, (radius+thick)*tan(remain/2)], [radius+thick, 0]]);
                        }else{
                                polygon([[0, 0], [radius+thick, (radius+thick)*tan(angle/2)], [radius+thick, -(radius+thick)*tan(angle/2)]]);
                        }
                }
                difference(){
                        circle(radius+thick);
                        circle(radius);
                }
        }
}


module holder(rad) {
    union() {
        rotate(-45) arc(rad, 3, 240);
        difference() {
            polygon(points=[[0,-(rad+3)],[(rad+3+5),-(rad+3)],[rad+3+5,rad+3+15],[rad+3,rad+3+15] ]);
            circle(rad);
        }
    }
}

linear_extrude(height=20)
holder(23/2);