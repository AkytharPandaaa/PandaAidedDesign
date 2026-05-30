// created by AkytharPandaaa
// encoding: utf-8

/* tolerance:
  0.1 tight fit
  0.15 fits
  0.2 loose fit */

$fn = $preview ? 25 : 125;

module grid(width, depth, a=2, height = 20, grid_thickness=.7, floor_thickness = .5, border_thickness = 3) {
  diameter = [0,14.5, 10.5];

  hex_id = diameter[a-1] + .1;
  hex_od = 2*((hex_id/2) / cos(30));
  bat_od = hex_id;

  translate(v = [hex_od/2+grid_thickness, hex_od/2+grid_thickness, 0]) {
    for (y=[0:depth-1]) {
      for (x=[0:width-1]) {
        translate(v = [
          (hex_id - grid_thickness * 4.5) * x, 
          (hex_od - grid_thickness * 5) * y + ((hex_id/2 - grid_thickness)* (x%2)),
          0
        ]) {
            translate(v = [0,0,height/2]) difference() {
              cylinder(h = height, d=hex_id + grid_thickness*2, center = true, $fn = 6);
              cylinder(h = height+.2, d=hex_id, center = true, $fn = 6);
            }
        }
      }
    }
  }
}

grid(width = 5, depth = 3, a = 2);
//translate(v = [100,0,0]) grid(width = 6, depth = 4, a = 3);

