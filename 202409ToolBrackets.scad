// created by IndiePandaaaa
// encoding: utf-8
use <Variables/Threading.scad>
use <Structures/Hexagon.scad>
use <Parts/Screw.scad>

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

module iron_tip_storage() {
  // circular inner diameter given, calculating diameter for the edges
  inner_diameter = hex_structure_inner_diameter_edges(8.5 + .2);

  thickness = .7;
  vertical_offset = hex_structure_vertical_offset(inner_diameter, thickness);

  difference() {
    union() {
      hex_structure(inner_diameter, thickness, horizontal_count = 5, vertical_count = 3, height = 15, screw_mounting_thickness = 4, bottom_floor = .6);

      for (i=[0:1]) {
        translate(v = [-5 + i*(hex_structure_width(inner_diameter, 5, thickness)+1), vertical_offset, 0]) mirror(v = [i, 0, 0])  difference() {
          cylinder(h = 4, r = 5, center = false);
          translate(v = [1, -10, -.1]) cube(size = 20, center = false);
        }
      }
    }
    translate(v=[-5, vertical_offset, 4]) screw(diameter=3.5, length=12, cutout_sample=true);
    translate(v=[-5 + (hex_structure_width(inner_diameter, 5, thickness)+1), vertical_offset, 4]) screw(diameter=3.5, length=12, cutout_sample=true);
  }
}

iron_tip_storage();
