// created by AkytharPandaaa
// encoding: utf-8

/* tolerance:
  0.1 tight fit
  0.15 fits
  0.2 loose fit */

$fn = $preview ? 25 : 125;

module grid(width, depth, a=2, height = 20, grid_thickness=.7, floor_thickness = .5, border_thickness = 3) {
  diameter = [0,14.5, 10.5];
  bat_od = diameter[a-1] + .1;
  hex_od = bat_od / cos(30);
  bat_offset = (bat_od) / 2;

  translate(v = [hex_od/2+grid_thickness, hex_od/2+grid_thickness, 0]) {
    for (y=[0:depth-1]) {
      for (x=[0:width-1]) {
        translate(v = [
          x * (hex_od + grid_thickness*2 + hex_od/2) + ((bat_od - grid_thickness * 2) * (y%2)),
          (bat_od/2) * y + grid_thickness,
          0
        ]) {
            translate(v = [0,0,height/2]) difference() {
              cylinder(h = height+.2, r = hex_od/2+grid_thickness, center = true, $fn = 6);
              cylinder(h = height+.4, r = hex_od/2, center = true, $fn = 6);
            }
        }
      }
    }
  }
}

grid(width = 6, depth = 4, a = 2);
//translate(v = [100,0,0]) grid(width = 6, depth = 4, a = 3);
