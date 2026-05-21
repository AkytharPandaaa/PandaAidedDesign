// created by AkytharPandaaa
// encoding: utf-8

/* tolerance:
  0.1 tight fit
  0.15 fits
  0.2 loose fit */

$fn = $preview ? 25 : 125;

module grid(width, depth, a=2, grid_thickness=.7, solid=false) {
  diameter = [0,14.3, 10.4];
  height = 25;
  bat_diameter = diameter[a-1] + .1;

  difference() {
    grid_sizing = bat_diameter + grid_thickness;
    cube(size = [grid_sizing * width + grid_thickness, grid_sizing * depth + grid_thickness, height], center = false);

    if (!solid) {
      translate(v = [grid_thickness, grid_thickness, 0]) {
        for (x=[0:width-1]) {
          for (y=[0:depth-1]) {
            translate(v = [(bat_diameter+grid_thickness)*x,(bat_diameter+grid_thickness)*y,-.1]) 
              cube([bat_diameter, bat_diameter, height+.2]);
          }
        }
      }
    }
  }
}

grid(width = 4, depth = 3, a = 2);
