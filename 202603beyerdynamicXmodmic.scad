// created by AkytharPandaaa
// encoding: utf-8

/* tolerance:
  0.1 tight fit
  0.15 fits
  0.2 loose fit */

$fn = $preview ? 25 : 125;

module basic_shape(depth) {
  linear_extrude(depth) {
    polygon(
      [
        [0, 0],
        [15.4, 0],
        [15.4 + 3.5, 4],
        [11.1, 9.7],
        [2.5, 11.9],
        [0, 4.8],
      ]
    );
  }
}

module headphone_original_part() {
  difference() {
    union() {
      basic_shape(7.4);

      translate([7.8, 3.5, 0]) {
        cylinder(d=3.9, h=12.2);
        cylinder(d=5.4, h=9.3);
      }
    }

    translate([7.8, -.1, 3.7]) rotate([-90, 0, 0]) {
        cylinder(d=1.9, h=15);
        cylinder(d1=4.3, d2=2, h=2);
      }

    translate([-.1, 2.4, 1.2]) {
      cube([14.1, 2, 6.3 - 1.9]);
      cube([2.3, 2, 6.3]);
    }
  }
}

module modmic_headphone_magnet() {
  difference() {
    union() {
      cylinder(d1=13, d2=9.9, h=2);
      cylinder(d=9.9, h=4.8);
    }

    translate([0, 0, -.1]) {
      cylinder(d=8.6, h=1.4 + .1);
      cylinder(d=5.5, h=5);
      translate([0, 0, 1.49]) cylinder(d1=8.6, d2=5.5, h=2.1);
    }

    for (i = [0:1]) {
      translate([0, 0, 4.8]) rotate(a=90, v=[1, 0, 0]) rotate(a=90, v=[0, i, 0]) rotate(a=45, v=[0, 0, 1])
              cube(size=[4.3, 4.3, 15], center=true);
    }

    translate(v=[0, 0, 4.8 - 1.6 + 10]) rotate(a=45, v=[0, 0, 1]) cube(size=[7, 7, 20], center=true);
  }
}

difference() {
  translate(v=[0, 0, 17]) union() {
      headphone_original_part();
      translate(v=[7, 0, -10]) rotate(a=10, v=[0, -1, 0]) rotate(a=90, v=[1, 0, 0]) modmic_headphone_magnet();
      difference() {
        translate(v=[0, 0, -17]) basic_shape(depth=17.1);
        difference() {
          translate(v=[7, -.1, -10]) rotate(a=90, v=[-1, 0, 0]) cylinder(d=8.6, h=20);
          translate(v=[7, -.2, -10]) rotate(a=90, v=[-1, 0, 0]) cylinder(d=8.4, h=20.2);
        }
      }
    }

  translate(v=[-.1, 3.4, -.1]) cube(size=[20, .1, 35], center=false);
}

translate(v=[35, 0, 0]) modmic_headphone_magnet();
