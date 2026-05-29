// created by AkytharPandaaa
// encoding: utf-8

/* tolerance:
  0.1 tight fit
  0.15 fits
  0.2 loose fit */

$fn = $preview ? 25 : 125;

module countersunk_washer(diameter, height=2.5) {
  difference() {
    cylinder(h = height, d=diameter * 2.25, center = true);
    cylinder(h = height + .2, d=diameter * 1.25, center = true);
    translate(v = [0,0,.3]) cylinder(h = height, d1=diameter * 1.25, d2=diameter * 2, center = true);
  }
}

countersunk_washer(diameter = 3.5);
