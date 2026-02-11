// created by AkytharPandaaa
// encoding: utf-8

TOLERANCE = .12;
THICKNESS = 1.5;
$fn = $preview ? 25 : 125;

KEY_LENGTH = 64.8;
KEY_WIDTH = 25.3;
KEY_THICKNESS = 2;
KEY_RADIUS = 7.2;
KEY_HOLE = [6.2, 5.2, 5.2]; // diameter, X Pos, Y Pos

KEY_BIT_SIZE = [37, 11.3, 2.7];

module case_side_popout() {
  module key_shape(size_added = 0) {
    circle_loc = [
      [KEY_RADIUS, KEY_RADIUS],
      [KEY_LENGTH - KEY_RADIUS + size_added * 2, KEY_RADIUS],
      [KEY_LENGTH - KEY_RADIUS + size_added * 2, KEY_WIDTH - KEY_RADIUS + size_added * 2],
      [KEY_RADIUS, KEY_WIDTH - KEY_RADIUS + size_added * 2],
    ];

    translate([-size_added, -size_added]) union() {
        polygon(
          [
            [0, KEY_RADIUS],
            [KEY_RADIUS, 0],
            [KEY_LENGTH - KEY_RADIUS + size_added * 2, 0],
            [KEY_LENGTH + size_added * 2, KEY_RADIUS],
            [KEY_LENGTH + size_added * 2, KEY_WIDTH - KEY_RADIUS + size_added * 2],
            [KEY_LENGTH - KEY_RADIUS + size_added * 2, KEY_WIDTH + size_added * 2],
            [KEY_RADIUS, KEY_WIDTH + size_added * 2],
            [0, KEY_WIDTH - KEY_RADIUS + size_added * 2],
          ]
        );

        for (i = [0:len(circle_loc) - 1]) {
          translate(circle_loc[i]) circle(r=KEY_RADIUS);
        }
      }
  }

  union() {
    linear_extrude(THICKNESS + KEY_THICKNESS + TOLERANCE) {
      // key border
      difference() {
        key_shape(size_added=THICKNESS + TOLERANCE); // outer contour
        key_shape(size_added=0); // inner contour
      }
    }
    linear_extrude(THICKNESS) {
      finger_hole = [18, 15, 3];
      difference() {
        key_shape(size_added=TOLERANCE * 2); // outer contour
        translate([KEY_LENGTH / 2 - finger_hole[0] / 2, KEY_WIDTH / 2 - finger_hole[1] / 2]) minkowski() {
            // inner contour
            translate([finger_hole[2], finger_hole[2]]) square([finger_hole[0] - finger_hole[2] * 2 - TOLERANCE, finger_hole[1] - finger_hole[2] * 2 - TOLERANCE]);
            circle(r=KEY_RADIUS + TOLERANCE / 2);
          }
        translate([KEY_HOLE[1], KEY_HOLE[2]]) circle(d=KEY_HOLE[0]);
      }
    }
  }
}
//KEY_LENGTH = 64.8;
//KEY_WIDTH = 25.3;
//KEY_THICKNESS = 2;
//KEY_RADIUS = 7.2;
//KEY_HOLE = [6.2, 5.2, 5.2]; // diameter, X Pos, Y Pos

module case_top_slide() {
  // case to slide out the key to the top, like a pocket knive
  module simplyfied_key_shape(thickness = 2) {
    linear_extrude(height=thickness, center=true) {
      translate(v=[0, 0, 0]) square([10, 20]);
    }
  }

  simplyfied_key_shape(thickness=2);
}

module case_key_bit(key_bit_size, thickness = 2, tolerance = .1) {
  difference() {
    translate(v=[0, 0, 0]) minkowski() {
        cube(size=[key_bit_size.x + tolerance - thickness, key_bit_size.y + tolerance, key_bit_size.z + tolerance], center=true);
        sphere(r=thickness);
      }
    translate(v=[thickness / 2 + .1, 0, 0]) cube(size=[key_bit_size.x + tolerance + .1, key_bit_size.y + tolerance, key_bit_size.z + tolerance], center=true);
  }
}

//case_side_popout();
//case_top_slide();
case_key_bit(key_bit_size=KEY_BIT_SIZE, thickness=1.5);
