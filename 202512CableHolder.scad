// created by IndiePandaaaaa|Lukas

THICKNESS = 2;
TOLERANCE = .10;
$fn = 75;

module side_mount(cable_od, board_thickness, width = 7) {
  linear_extrude(height=width, center=false, convexity=10, twist=0, slices=20, scale=1.0) {
    difference() {
      union() { // base object with outer border
        translate(v=[0, -(board_thickness / 2 + THICKNESS + TOLERANCE / 2)])
          square([board_thickness + cable_od / 2 + THICKNESS, board_thickness + THICKNESS * 2 + TOLERANCE / 2]);
        circle(r=board_thickness / 2 + THICKNESS);
      }

      percent_grab_cable = 75;
      union() { // cutout object
        translate(v=[cable_od/2*(percent_grab_cable/100), -(board_thickness / 2)]) 
          square([board_thickness + cable_od / 2 + THICKNESS, board_thickness]);
        translate(v=[0, -(cable_od * .3)]) 
          square([board_thickness + cable_od / 2 + THICKNESS, cable_od * .6]);
        circle(r=cable_od / 2 + TOLERANCE / 2);
      }
    }
  }
}

//side_mount(cable_od=8.2, board_thickness=11.8);
side_mount(cable_od=3.9, board_thickness=17.5);
