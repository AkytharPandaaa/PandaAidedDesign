// created by IndiePandaaaa
// encoding: utf-8
use <Variables/Threading.scad>

CHAMFER = .5;
TOLERANCE = .2;
$fn = 75;

module mounting_base(inner_width, inner_height, inner_height_offset, base_depth, material_thickness = 3, round_cutout =
false) {
  full_width = material_thickness * 2 + inner_width + TOLERANCE;
  full_height = inner_height_offset + inner_height + TOLERANCE;

  height_offset = round_cutout ? inner_height_offset + (inner_width + TOLERANCE) / 2 : inner_height_offset;

  difference() {
    translate([-full_width / 2, base_depth, 0]) rotate([90, 0, 0]) linear_extrude(base_depth) {
      polygon([
          [0, 0],
          [full_width, 0],
          [full_width, full_height - CHAMFER],
          [full_width - CHAMFER, full_height],
          [full_width - material_thickness + CHAMFER, full_height],
          [full_width - material_thickness, full_height - CHAMFER],
          [full_width - material_thickness, height_offset],
          [material_thickness, height_offset],
          [material_thickness, full_height - CHAMFER],
          [material_thickness - CHAMFER, full_height],
          [CHAMFER, full_height],
          [0, full_height - CHAMFER],
        ]);
    }
    for (i = [0:1]) {
      translate([0, base_depth / 4 + base_depth / 2 * i, -.1]) cylinder(d = core_hole_M3(), h = height_offset * 1.5);
    }
    if (round_cutout) {
      translate([0, -.1, height_offset]) rotate([-90, 0, 0]) cylinder(d = inner_width + TOLERANCE, h = base_depth + .2);
    }
  }
}

module nut_plate() {
  nuts = [11.6, 11.6, 11.6, 11.6, 11.8, 11.8, 12.8, 13.7, 15.7, 15.8, 16.8];
  offset_dist = 17.5;

  difference() {
    rotate([90, 0, 90])
    linear_extrude(height = len(nuts)*offset_dist, center = false, convexity = 10, twist = 0, slices = 20, scale = 1.0) {
      polygon(points = [
        [0,0], [34,0],[27,7],[7,7]
      ]);
    }

    for (i=[0:len(nuts)-1]) {
      d = nuts[i];
      translate(v = [7.5 + offset_dist*i+.15, 17, 1]) cylinder(h = 10, r = (d+.15)/2, center = false);
    }
  }
}
//mounting_base(inner_width, inner_height, inner_height_offset, base_depth, round_cutout = false) 

