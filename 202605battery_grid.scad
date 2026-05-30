// created by AkytharPandaaa
// encoding: utf-8

/* tolerance:
  0.1 tight fit
  0.15 fits
  0.2 loose fit */

$fn = $preview ? 25 : 125;

module hex_structure(width, depth, height, inner_diameter, grid_thickness = .7, mounting_thickness = 0) {
  hex_id = inner_diameter + .1;
  hex_od = 2 * ((hex_id/2) / cos(30));
  bat_od = hex_id;

  module hexagons(solid = false) {
    for (y=[0:depth-1]) {
      for (x=[0:width-1]) {
        translate(v = [
          (hex_id - grid_thickness * hex_id/4) * x, 
          (hex_od - grid_thickness * hex_od/4) * y + ((hex_id/2 - grid_thickness/2)* (x%2)),
          0
        ]) {
            translate(v = [0,0,height/2]) difference() {
              cylinder(h = height, d=hex_id + grid_thickness*2, center = true, $fn = 6);
              
              if (!solid)
                cylinder(h = height+.2, d=hex_id, center = true, $fn = 6);
            }
        }
      }
    }
  }

  translate(v = [hex_od/2, hex_id/2, 0]) {
    union() {
      hexagons();

      difference() {
        translate(v = [-hex_id/2 - grid_thickness, 0, 0]) 
          cube(size = [(hex_od + hex_id/2) * floor(width/2) + (hex_od) * (width%2) - grid_thickness/inner_diameter, hex_id*(depth-1) - grid_thickness, mounting_thickness], center = false);
          translate(v = [0,0,-.1]) hexagons(solid = true);
      }
    }
  }
}

module battery_grid(width, depth, a=2, height = 20, grid_thickness=.7, floor_thickness = 0) {
  diameter = [0,14.5, 10.5];

  hex_structure(width, depth, height, inner_diameter = diameter[a-1], grid_thickness = .7, mounting_thickness = floor_thickness);
}

//battery_grid(width = 4, depth = 6, a = 2);
//translate(v = [100,0,0]) grid(width = 6, depth = 4, a = 3);

hex_structure(width = 5, depth = 3, height = 25, inner_diameter = 9, grid_thickness = .7, mounting_thickness = 3);
