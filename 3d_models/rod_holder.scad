// Higher definition curves
$fs = 0.01;

module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	module build_point(type = "sphere", rotate = [0, 0, 0]) {
		if (type == "sphere") {
			sphere(r = radius);
		} else if (type == "cylinder") {
			rotate(a = rotate)
			cylinder(h = diameter, r = radius, center = true);
		}
	}

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							build_point("sphere");
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							build_point("cylinder", rotate);
						}
					}
				}
			}
		}
	}
}


module chamfered_screw_hole(screw_diameter, screw_length, head_diameter, head_length, overhead_length = 0)
{
    cylinder(h = screw_length,d = screw_diameter);
    translate([0, 0, screw_length]) cylinder(h = head_length,d2 = head_diameter, d1 = screw_diameter);
    translate([0, 0, screw_length + head_length]) cylinder(h = overhead_length,d = head_diameter);
}

module chamfer(l, w, h) {
    difference() {
        cube([l, w, h]);
        translate([-0.1, 0, h]) scale([l + 0.2, w, h]) rotate([0, 90, 0]) cylinder(r = 1, h = 1);
    }
}

THREADED_ROD_DIAMETER = 7.85;
ROD_OFFSET_FROM_BASE = 4;
MOUNT_WIDTH = 40;
MOUNT_THICKNESS = 6;
MOUNT_HEIGHT = 40;

ROD_MOUNT_WIDTH = THREADED_ROD_DIAMETER + 2 * 3;

SCREW_SIDE_WIDTH = 16;

SCREW_PART_SIZE = ROD_MOUNT_WIDTH + 2 * SCREW_SIDE_WIDTH;

SCREW_HEAD_SIZE = 2;
SCREW_HEAD_DIAMETER = 9;
SCREW_DIAMETER = 4;
SCREW_SIZE = 10;

ROUNDING = 1.5;
SIDE_CHAMFER_WIDTH = SCREW_SIDE_WIDTH -ROUNDING ;

$fn = 20;
difference() {

union(){
/* 3rd side */
difference() {
union () {
translate([ROD_MOUNT_WIDTH/2, ROD_MOUNT_WIDTH/2 + SIDE_CHAMFER_WIDTH, -MOUNT_HEIGHT/2 + MOUNT_THICKNESS]) rotate([0, 0, 180]) chamfer(ROD_MOUNT_WIDTH, SIDE_CHAMFER_WIDTH, MOUNT_HEIGHT - MOUNT_THICKNESS - ROUNDING, $fn=200);
    translate([0, (SCREW_SIDE_WIDTH + ROD_MOUNT_WIDTH) / 2 - ROD_MOUNT_WIDTH / 2, -(MOUNT_HEIGHT / 2 - MOUNT_THICKNESS / 2)]) roundedcube([ROD_MOUNT_WIDTH, SCREW_SIDE_WIDTH + ROD_MOUNT_WIDTH, MOUNT_THICKNESS], true, ROUNDING, "z");
}

translate([0, SCREW_PART_SIZE / 2 - SCREW_HEAD_DIAMETER + 2,  -(SCREW_SIZE +SCREW_HEAD_SIZE) - (MOUNT_HEIGHT / 2) + MOUNT_THICKNESS]) chamfered_screw_hole(SCREW_DIAMETER, SCREW_SIZE, SCREW_HEAD_DIAMETER, SCREW_HEAD_SIZE, 20, $fn = 100);
}


/* 3rd side */
difference() {
union () {
translate([-ROD_MOUNT_WIDTH/2, -ROD_MOUNT_WIDTH/2 - SIDE_CHAMFER_WIDTH, -MOUNT_HEIGHT/2 + MOUNT_THICKNESS]) rotate([0, 0, 0]) chamfer(ROD_MOUNT_WIDTH, SIDE_CHAMFER_WIDTH, MOUNT_HEIGHT - MOUNT_THICKNESS - ROUNDING, $fn=200);
    translate([0, -(SCREW_SIDE_WIDTH + ROD_MOUNT_WIDTH) / 2 + ROD_MOUNT_WIDTH / 2, -(MOUNT_HEIGHT / 2 - MOUNT_THICKNESS / 2)]) roundedcube([ROD_MOUNT_WIDTH, SCREW_SIDE_WIDTH + ROD_MOUNT_WIDTH, MOUNT_THICKNESS], true, ROUNDING, "z");
}

translate([0, -SCREW_PART_SIZE / 2 + SCREW_HEAD_DIAMETER - 2,  -(SCREW_SIZE +SCREW_HEAD_SIZE) - (MOUNT_HEIGHT / 2) + MOUNT_THICKNESS]) chamfered_screw_hole(SCREW_DIAMETER, SCREW_SIZE, SCREW_HEAD_DIAMETER, SCREW_HEAD_SIZE, 20, $fn = 100);
}

/* Main tube */
 roundedcube([ROD_MOUNT_WIDTH, ROD_MOUNT_WIDTH, MOUNT_HEIGHT], true, ROUNDING, "y");
   

/* double side screws */
difference() {
    union () {
    translate([0, 0, -(MOUNT_HEIGHT / 2 - MOUNT_THICKNESS / 2)]) roundedcube([SCREW_PART_SIZE, ROD_MOUNT_WIDTH, MOUNT_THICKNESS], true, ROUNDING, "z");
/* Chamfers */
translate([ROD_MOUNT_WIDTH/2 + SIDE_CHAMFER_WIDTH, -ROD_MOUNT_WIDTH/2, -MOUNT_HEIGHT/2 + MOUNT_THICKNESS]) rotate([0, 0, 90]) chamfer(ROD_MOUNT_WIDTH, SIDE_CHAMFER_WIDTH, MOUNT_HEIGHT - MOUNT_THICKNESS - ROUNDING, $fn=200);

translate([- ROD_MOUNT_WIDTH/2 - SIDE_CHAMFER_WIDTH, ROD_MOUNT_WIDTH/2, -MOUNT_HEIGHT/2 + MOUNT_THICKNESS]) rotate([0, 0, -90]) chamfer(ROD_MOUNT_WIDTH, SIDE_CHAMFER_WIDTH, MOUNT_HEIGHT - MOUNT_THICKNESS - ROUNDING, $fn=200);


    }
translate([SCREW_PART_SIZE / 2 - SCREW_HEAD_DIAMETER + 2, 0,  -(SCREW_SIZE +SCREW_HEAD_SIZE) - (MOUNT_HEIGHT / 2) + MOUNT_THICKNESS]) chamfered_screw_hole(SCREW_DIAMETER, SCREW_SIZE, SCREW_HEAD_DIAMETER, SCREW_HEAD_SIZE, 20, $fn = 100);
translate([-(SCREW_PART_SIZE / 2 - SCREW_HEAD_DIAMETER) - 2, 0,  -(SCREW_SIZE +SCREW_HEAD_SIZE) - (MOUNT_HEIGHT / 2) + MOUNT_THICKNESS]) chamfered_screw_hole(SCREW_DIAMETER, SCREW_SIZE, SCREW_HEAD_DIAMETER, SCREW_HEAD_SIZE, 20, $fn = 100);
}
}
    cylinder(d = THREADED_ROD_DIAMETER, h = 2*MOUNT_HEIGHT , center = true);
}