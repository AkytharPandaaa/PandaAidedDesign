// created by AkytharPandaaa
// encoding: utf-8

$fn = $preview? 25:125;

module mb200_rightangle() {
  difference() {
    translate(v = [0, 21.5, 0]) rotate(a = 90, v = [1, 0, 0]) linear_extrude(height = 21.5, center = false, convexity = 10, twist = 0, slices = 20, scale = 1.0) {
      difference() {
        union() {
          square(size = [114, 9], center = false);
          translate(v = [88.2+(17.6-7)/2, 0, 0]) polygon(points = [
            [0,0],
            [6.7,0],
            [6.7-(6.7-5)/2, -2],
            [6.7-(6.7-5)/2, -3.3],
            [(6.7-5)/2, -3.3],
            [(6.7-5)/2, -2],
          ]);
        }
      translate(v = [88.2, 9-4.3, 0]) square(size = [17.6+10, 4.3], center = false);
      }
    }
    translate(v = [88.2+(17.6)/2, 21.5/2, -10]) cylinder(h = 20, d = 5.5, center = false);
    translate(v = [88.2+(17.6)/2, 21.5/2, 9-4.3]) cylinder(h = 9-4.3, d = 22.5, center = false);

    // edge rounding
    loc = [
      [114-2, 21.5-2, 0],
      [0, 21.5-2, 0],
      [0, 0, 0],
      [114-2, 0, 0],
      [88.2-2, 21.5-2, 9-4.3+.1],
      [0, 0, 20],
      [0, 0, 20],
      [88.2-2, 0, 9-4.3+.1],
    ];
    for (i=[0:7]) {
      translate(v = loc[i]) translate(v = [1, 1, -.1]) 
        rotate(a = 90*i, v = [0, 0, 1]) difference() {
          translate(v = [-1, -1, 0]) cube(size = [2.1, 2.1, 9+.2], center = false);
          translate(v = [-1, -1, -.1]) cylinder(h = 9+.4, r = 2, center = false);
        }
    }

    // M3 mounting holes for accessories
    for (i=[0:1]) {
      translate(v = [(88.2-60-(22.5-17.6))/2 + 60*i, 21.5/2, -.1]) cylinder(h = 9+.2, d = 2.6, center = false);
    }
  }
}

mb200_rightangle();
