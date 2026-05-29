// created by AkytharPandaaa
// encoding: utf-8

/* tolerance:
  0.1 tight fit
  0.15 fits
  0.2 loose fit */

$fn = $preview ? 25 : 125;

module mill_unlock(ARGS) {
  union() {
    // outer grip
    steps = 20;
    for (i=[0:steps]) {
      id = 19.7;
      crown_od = 4;
      rotate(a = 360/steps*i, v = [0,0,1])
        translate(v = [(id + crown_od)/2,0,0])
          cylinder(h = 8.7 +3.8, d = crown_od, center = false);
    }

    // top grip
    translate(v = [0,0,8.5 + 5/2 - 2]) difference() {
      cylinder(h = 5 + 2, d=25, center = true);
      translate(v = [0,0,-(5+2)/2 +1]) cylinder(h = 2 +.1, d1=17.6 + .1, d2=7 +.1, center = true);

      
      // allen key 5
      cylinder(h = 5 + 2 + .2, d=5.6 + .2, center = true, $fn = 6);

      size_handle = [5.6 + .15, 2.8 +.15];
      for (i=[0:1])
        rotate(a=90+180*i, v=[0,0,1])
          translate(v = [6.4/2,-size_handle[1]/2,-5])
            cube(size = [size_handle[0], size_handle[1], 10], center = false);
    }
  }
}

difference() {
  mill_unlock();
//  translate(v = [0,-20,-.1]) cube(size = 20, center = false);
}
