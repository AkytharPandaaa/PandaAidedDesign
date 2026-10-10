// created by IndiePandaaaaa | Lukas

use <Parts/Screw.scad>

THICKNESS = 3.5;
TOLERANCE = 0.1;
CHAMFER = 1.5;
SCREW_OD = 3.5;
$fn = $preview ? 25 : 125;

BOARD_THICKNESS = 20.8;
MOUNT_HEIGHT = 20;

module top_mount() {
  rotate([90, 0, 90]) difference() {
      linear_extrude(SCREW_OD * 4) {
        polygon(
          [
            [0, CHAMFER],
            [CHAMFER, 0],
            [THICKNESS, 0],
            [THICKNESS, BOARD_THICKNESS],
            [THICKNESS + BOARD_THICKNESS + TOLERANCE, BOARD_THICKNESS],
            [THICKNESS + BOARD_THICKNESS + TOLERANCE, 0],
            [THICKNESS * 2 + BOARD_THICKNESS + TOLERANCE - CHAMFER, 0],
            [THICKNESS * 2 + BOARD_THICKNESS + TOLERANCE, CHAMFER],
            [THICKNESS * 2 + BOARD_THICKNESS + TOLERANCE, BOARD_THICKNESS + THICKNESS],
            [THICKNESS * 2 + BOARD_THICKNESS + TOLERANCE, BOARD_THICKNESS + THICKNESS + MOUNT_HEIGHT],
            [THICKNESS + BOARD_THICKNESS + TOLERANCE, BOARD_THICKNESS + THICKNESS + MOUNT_HEIGHT],
            [THICKNESS + BOARD_THICKNESS + TOLERANCE, BOARD_THICKNESS + THICKNESS],
            [CHAMFER, BOARD_THICKNESS + THICKNESS],
            [0, BOARD_THICKNESS + THICKNESS - CHAMFER],
          ]
        );
      }
      translate(
        [
          THICKNESS * 2 + BOARD_THICKNESS + TOLERANCE,
          BOARD_THICKNESS + MOUNT_HEIGHT + THICKNESS - SCREW_OD * 2,
          SCREW_OD * 2,
        ]
      ) rotate([0, 90, 0]) screw(SCREW_OD, 12, true);
    }
}

module vertical_mount(width = 28.5, height = 58.5, board_thickness = 20.8) {
  rotate([90, 0, 90]) linear_extrude(width) {
      polygon(
        [
          [0, 0],
          [THICKNESS, 0],
          [THICKNESS, height],
          [THICKNESS + board_thickness + TOLERANCE, height],
          [THICKNESS + board_thickness + TOLERANCE, height - MOUNT_HEIGHT],
          [THICKNESS * 2 + board_thickness + TOLERANCE - CHAMFER, height - MOUNT_HEIGHT],
          [THICKNESS * 2 + board_thickness + TOLERANCE, height - MOUNT_HEIGHT + CHAMFER],
          [THICKNESS * 2 + board_thickness + TOLERANCE, height + THICKNESS - CHAMFER],
          [THICKNESS * 2 + board_thickness + TOLERANCE - CHAMFER, height + THICKNESS],
          [0, height + THICKNESS],
        ]
      );
    }
}

module rodret_mount() {
  // IKEA RODRET smart home switch
  width = 28.5;
  height = 58.5;
  difference() {
    vertical_mount(width=width, height=height);
    for (i = [0:1]) {
      translate(v=[width / 2, -.1, 15 + i * 32.5]) rotate(a=90, v=[-1, 0, 0]) cylinder(h=5, r=2.7 / 2, center=false);
    }
  }
}

module bottle_holder(diameter = 20) {
  size = diameter + THICKNESS * 2 + TOLERANCE;
  union() {
    vertical_mount(width=size, height=diameter * 1.5);
    translate([0, -size / 2 + THICKNESS, 0]) union() {
        cube([size, size / 2, THICKNESS]);
        translate(v=[size / 2, 0, 0]) cylinder(h=THICKNESS, r=size / 2, center=false);
      }
    translate(v=[0, -size / 2 + THICKNESS, diameter]) difference() {
        union() {
          cube([size, size / 2, THICKNESS]);
          translate(v=[size / 2, 0, 0]) cylinder(h=THICKNESS, r=size / 2, center=false);
        }
        translate(v=[size / 2, 0, -diameter / 2])
          cylinder(h=diameter, r=(diameter + TOLERANCE) / 2, center=false);
      }
  }
}

module fan_holder(board_height, fan_diameter=140, standoff_depth = 25) {
  additional_height = 20;
  union() {
    vertical_mount(width = 25, height = additional_height + (board_height- fan_diameter)/2);

    // standoff
    difference() {
      translate(v=[0,-standoff_depth,0]) cube([THICKNESS, standoff_depth, additional_height]);

      // holes
      for (i=[0:2]) {
        hole_diameter = 3;
        translate(v=[-.1,-standoff_depth + hole_diameter, 5 + 5*i]) 
          rotate(a = 90, v=[0,1,0])
            cylinder(h=THICKNESS+.2, d=hole_diameter, center=false);
      }
    }
  }
}

module shower_backet() {
  handle_od = [23.7, 20.8, 30];
  tube_od = 16;
  depth = 40;
  width = 50;
  

    difference() {
      union() {
        rotate(a = 90, v = [0,0,1]) translate(v = [0,.1,0])  vertical_mount(width = depth, height = 75, board_thickness = 10);
        cube(size = [width, depth, handle_od[2]], center = false);
      }
      translate(v = [width - 15, (depth- tube_od)/2,-.1]) cube(size = [20, tube_od, handle_od[2]+.2], center = false);

      for (i=[0:1]) {
        rotate([0,10 + 10 *i,0]) 
        translate(v = [15 + handle_od[0]*0.5 * i, depth/2, 0]) 
        union() {
          translate(v = [0,0,-handle_od[2]+.1]) cylinder(h = handle_od[2], d=handle_od[1], center = false);
          cylinder(h = handle_od[2], d2=handle_od[0], d1=handle_od[1], center = false);
          translate(v = [0,0,handle_od[2]-.1]) cylinder(h = handle_od[2], d=handle_od[0], center = false);
        }

        for (j=[0:1]) {
          translate(v = [-THICKNESS,5 + (depth-10)*i,5 + (handle_od[2] - 10) *j]) 
            rotate(a = 90, v = [0,-1,0]) 
              rotate(a = 90, v = [0,0,-1]) 
              rotate(a = 180, v = [0,0,1*i]) 
              screw_with_nut_metric(12, diameter=3, square_channel = true, tolerance = .1);
              //screw(3, 20, true);
        }
      }
  }

}

module timmerflotte_mount(board_thickness = 20.8) {
  difference() {
    vertical_mount(width = 25, height = 60, board_thickness = board_thickness);

    translate(v = [12.5,-2.5,50]) rotate(a = 90, v = [1,0,0]) 
    screw(diameter = 2.7, length = 8, cutout_sample = false);
  }
}

// translate([ 10, 0, 0 ]) top_mount();
// translate([ 40, 0, 0 ]) vertical_mount(width=28.5, height=58.5);
// bottle_holder(25);
// rodret_mount();
// for (i=[0:1]) {mirror([i,0,0]) translate(v=[5*i,0,0]) fan_holder(board_height=155);}
// shower_backet();

timmerflotte_mount(board_thickness = 20.8);
translate(v = [30, 0,0]) timmerflotte_mount(board_thickness = 4.2);
