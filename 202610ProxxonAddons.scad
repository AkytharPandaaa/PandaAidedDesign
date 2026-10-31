// created by AkytharPandaaa
// encoding: utf-8

$fn = $preview? 25:125;

module mb200_rightangle() {
  difference() {
    translate(v = [0, 21.5, 0]) rotate(a = 90, v = [1, 0, 0]) linear_extrude(height = 21.5, center = false, convexity = 10, twist = 0, slices = 20, scale = 1.0) {
      difference() {
        union() {
          square(size = [114, 9], center = false);
          translate(v = [88.2+(17.6-6.5)/2, 0, 0]) polygon(points = [
            [0,0],
            [6.5,0],
            [6.5-(6.5-5)/2, -2],
            [(6.5-5)/2, -2]
          ]);
        }
      translate(v = [88.2, 9-4.3, 0]) square(size = [17.6, 4.3], center = false);
      }
    }
    translate(v = [88.2+(17.6)/2, 21.5/2, -2.5]) cylinder(h = 15, d = 5.5, center = false);
    translate(v = [88.2+(17.6)/2, 21.5/2, 9-4.3]) cylinder(h = 9-4.3, d = 22.5, center = false);
  }
}

mb200_rightangle();
