// created by AkytharPandaaa

$fn = $preview? 25:125;

difference() {
  rotate_extrude(angle = 360, convexity = 2) {
    polygon(points = [
      [0,0], [35,0], [20,42.5],[0,42.5]
    ]);
  }

  ods = [10.5, 12, 13];
  for (i=[0:2]) {
    rotate(a = 120*i, v = [0,0,1]) 
      translate([12, 0, .7])
        cylinder(h = 42, d=ods[i], center = false);
  }

  rotate(a = 120, v = [0,0,1]) 
    translate(v = [2.5, -(7.5/2), .7])
      cube(size = [5, 7.5, 42], center = false);
}
