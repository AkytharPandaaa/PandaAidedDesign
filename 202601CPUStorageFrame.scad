// created by AkytharPandaaa
// encoding: utf-8

/* tolerance:
  0.1 tight fit
  0.15 fits
  0.2 loose fit */

$fn = $preview ? 25 : 125;

// HS = heat spreader

DEBUG_MODE = false;

FRAME_WIDTH_SQUARE = 45;
ESD_FOAM_THICKNESS = 1.5;

CPU_INTEL_3000 = [37.8, 37.8, 4.5];

cpu = CPU_INTEL_3000;

module cpu_dummy(cpu_size, tolerance = .15) {
  translate(v=[0, 0, cpu_size.z / 2 + tolerance / 2]) cube(size=[cpu_size.x + tolerance, cpu_size.y + tolerance, cpu_size.z + tolerance], center=true);
}

module frame(cpu_size, esd_foam_thickness, tolerance = .15) {
  module split_frame(thickness = .1) {
    color(c="orange", alpha=1.0) union() {
        difference() {
          cube(size=[FRAME_WIDTH_SQUARE + 2, FRAME_WIDTH_SQUARE + 2, thickness], center=true);
          cube(size=[FRAME_WIDTH_SQUARE - 4, FRAME_WIDTH_SQUARE - 4, thickness + .2], center=true);
        }
        translate(v=[0, 0, -thickness / 2 + (esd_foam_thickness + cpu_size[2] / 2) / 2]) difference() {
            cube(size=[FRAME_WIDTH_SQUARE - 4 + thickness * 2, FRAME_WIDTH_SQUARE - 4 + thickness * 2, esd_foam_thickness + cpu_size[2] / 2], center=true);
            cube(size=[FRAME_WIDTH_SQUARE - 4, FRAME_WIDTH_SQUARE - 4, (esd_foam_thickness + cpu_size[2] / 2) + .2], center=true);
          }
        translate(v=[0, 0, esd_foam_thickness + cpu_size[2] / 2 - thickness])
          cube(size=[FRAME_WIDTH_SQUARE - 4 + thickness * 2, FRAME_WIDTH_SQUARE - 4 + thickness * 2, thickness], center=true);
      }
  }

  module split_stack(thickness = .1) {
    color(c="orange", alpha=1.0) union() {
        translate(v=[0, 0, -.5 / 2]) difference() {
            cube(size=[FRAME_WIDTH_SQUARE - 10, FRAME_WIDTH_SQUARE - 10, .5], center=true);
            cube(size=[FRAME_WIDTH_SQUARE - 10 - thickness * 2, FRAME_WIDTH_SQUARE - 10 - thickness * 2, .5 + .2], center=true);
          }
        translate(v=[0, 0, -.5]) difference() {
            cube(size=[FRAME_WIDTH_SQUARE - 10, FRAME_WIDTH_SQUARE - 10, thickness], center=true);
            cube(size=[FRAME_WIDTH_SQUARE - 20, FRAME_WIDTH_SQUARE - 20, thickness + .2], center=true);
          }
        translate(v=[0, 0, -.5 - 1.5]) difference() {
            cube(size=[FRAME_WIDTH_SQUARE - 20 + thickness * 2, FRAME_WIDTH_SQUARE - 20 + thickness * 2, 3], center=true);
            cube(size=[FRAME_WIDTH_SQUARE - 20, FRAME_WIDTH_SQUARE - 20, 3 + .2], center=true);
          }
      }
  }

  foam_height = esd_foam_thickness + (esd_foam_thickness == 0 ? 0 : tolerance);
  frame_top_thickness = 1.5;
  frame_bottom_thickness = 1.5;
  frame_height = cpu_size[2] + foam_height + (frame_top_thickness + frame_bottom_thickness);

  difference() {
    // BASE
    translate(v=[0, 0, frame_height / 2 - frame_bottom_thickness]) union() {
        cube([FRAME_WIDTH_SQUARE, FRAME_WIDTH_SQUARE, frame_height], center=true);
        //FIX: translate z, needs manual correction if ESD_FOAM_THICKNESS changes
        translate(v=[0, 0, -5.5]) cube([FRAME_WIDTH_SQUARE - 20, FRAME_WIDTH_SQUARE - 20, 2], center=true);
      }

    // CUTOUT VIEW
    translate(v=[0, 0, frame_height / 2 + .1]) cube(size=[FRAME_WIDTH_SQUARE - 20, FRAME_WIDTH_SQUARE - 20, frame_height + .2], center=true);

    // CUTOUT bottom
    translate(v=[0, 0, -frame_height / 2]) cube(size=[FRAME_WIDTH_SQUARE - 22, FRAME_WIDTH_SQUARE - 22, frame_height + .2], center=true);

    // CUTOUT FOAM
    translate(v=[0, 0, foam_height / 2]) cube(size=[cpu_size[0] + tolerance, cpu_size[1] + tolerance, foam_height], center=true);

    // CUT SPLIT POINT
    translate(v=[0, 0, 0]) split_frame(thickness=.1);

    // CUT SPLIT STACK
    translate(v=[0, 0, 0]) split_stack(thickness=.1);
  }
}

difference() {
  frame(cpu_size=cpu, esd_foam_thickness=ESD_FOAM_THICKNESS, tolerance=.15);

  if (DEBUG_MODE) {
    difference() {
      translate(v=[0, 0, ESD_FOAM_THICKNESS]) color(c="aqua", alpha=1.0) cpu_dummy(cpu_size=cpu, tolerance=.15);
      translate(v=[0, 0, ESD_FOAM_THICKNESS]) color(c="aqua", alpha=1.0) cpu_dummy(cpu_size=cpu, tolerance=.05);
    }
  } else {
    translate(v=[0, 0, ESD_FOAM_THICKNESS]) cpu_dummy(cpu_size=cpu, tolerance=.15);
  }

  if (DEBUG_MODE)
    translate(v=[0, 0, -5]) cube(30);
}

// pcb cutting guide for the foam
if (ESD_FOAM_THICKNESS != 0) {
  translate(v=[0, 50, 0]) cube(size=[cpu.x, cpu.y, 2], center=true);
}
