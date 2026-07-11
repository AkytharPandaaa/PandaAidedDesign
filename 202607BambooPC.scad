// created by AkytharPandaaa

use <Parts/Screw.scad>

use <202303uBracket.scad>
use <202306lBracket.scad>
use <202507MainboardTestBench.scad>

$fn = $preview ? 25 : 125;

module steckerleiste(plugs = 6) {
  difference() {
    color("#555555") cube(size = [102 + plugs * 53, 60, 50], center = false);
    for (i=[0:plugs - 1]) {
      color("#111111") 
        translate(v = [90 + i * 54, 30, 21]) 
          cylinder(h = 30, r = 20, center = false);
    }
  }
}

module fan(od, thickness = 25) {
  difference() {
    color("#555555") cube(size = [od-2, od, thickness], center = false);
    color("#222222") translate(v = [(od - 5)/2 + 1.5, (od - 5)/2, .1]) cylinder(h = thickness + .2, d = od-5, center = false);
  }
}

module radiator(fan_od = 140, fans = 2) {
  if (fan_od == 120) {
    difference() { // radiator
      color("#ffffff") cube(size = [280, fan_od, 30], center = false);

      color("#aa7700") for (i=[0:1]) {translate(v = [14, 24 + (i * 73),6]) cylinder(h = 25, d = 18, center = false); } // fill ports
      color("#555555") translate(v = [30, 12, 30 - 7]) cube(size = [232, 96, 8], center = false);
    }
  } else if (fan_od == 140) {
    difference() { // radiator
      color("#ffffff") cube(size = [320, fan_od, 40], center = false);

      color("#aa7700") for (i=[0:1]) {translate(v = [14, 24 + (fan_od - 24*2) * i,6]) cylinder(h = 35, d = 18, center = false); } // fill ports
      color("#555555") translate(v = [30, 12, 40 - 7]) cube(size = [320 - 48, fan_od - 12*2, 8], center = false);
    }
  }

  for (i=[0:fans-1]) translate(v = [30 + fan_od*i, 0, fan_od == 140 ? -25 : 30]) fan(od = fan_od, thickness = 25);
}

module mainboard(atx = false) {
  if (atx) {
    color("#dddddd") cube(size = [304, 244, 40], center = false);
  } else {
    color("#dddddd") cube(size = [244, 244, 40], center = false);
  }
}

module pump_agb() {
  color("#444444") cube(size = [70, 71, 131], center = false);
}

module ssd() {
  color("#dddddd") cube(size = [100, 70, 7], center = false);
}

module psu() {
  color("#333333") cube(size = [150, 160, 86], center = false);
}

module flow_indicator() {
  color("#ffffff") cylinder(h = 24, d = 57, center = false, $fn = 6);
}

module disk() {
  color("#222222") cube(size = [146, 170, 42], center = false);
  color("#777777") translate(v = [(146 - 130)/2, -150, 18]) cube(size = [130, 155, 18], center = false);
}

module io() {
  color("#fa8800") cube(size = [160, 40, 20], center = false);
}

// ===================================================================================

module radiator_angle(depth, thickness = 3) {
  fins_to_case_offset = 4.2;
  dustfilter_thickness = 7 + .15;
  height = 14;

  difference() {
    union() {
      cube(size = [depth + 4 + 2.5, depth * 0.7, height], center = false);

      // fin support
      translate(v = [0, depth * .7, 3]) cube(size = [depth - 11.5, fins_to_case_offset + .1, height - 3], center = false);
    }

    // radiator screw channel
    translate(v = [depth - 7, depth*.7 - .5 - .1, 10]) rotate([-90, 0, 0]) cylinder(h = .5 + .2, d = 6.8 + .15, center = false);
    translate(v = [depth - 7, depth*.7 - .5 - 2 - .1, 10]) rotate([-90, 0, 0]) cylinder(h = 2 + .2, d = 4.1 + .15, center = false);
    translate(v = [depth - 7, depth*.7 - 2.5 - 2 - .1, 10]) rotate([-90, 0, 0]) cylinder(h = 2 + .2, d = 5.6 + .15, center = false);
    translate(v = [depth - 7, -.1, 10]) rotate([-90, 0, 0]) cylinder(h = depth*.7 + .2 - 4.5, d = 7 + .15, center = false);

    // dust filter
    translate(v = [-.1, depth*.7 - dustfilter_thickness - 4.5, 2]) cube(size = [depth + 4 + .2, dustfilter_thickness, height - 2 + .1], center = false);

    // angle
    translate(v = [0, 0, -.1]) linear_extrude(height = height + .2) {
      polygon(points = [
        [-.1, -.1],
        [depth + 6.5 + .1, 0],
        [depth + 6.5 + .1, depth * .7 + .1 - thickness*2 - dustfilter_thickness],
      ]);
    }

    // volume cutout
    translate(v = [thickness, 0, thickness]) 
      cube(size = [depth + 6.5 + .1, depth*.7 - 6.5 - thickness*2 - 2, height], center = false);

    // wood screws
    for (i=[0:1]) 
      translate(v = [thickness, height/2 + (depth*.7 - thickness*4.5 - height)*i, (height + thickness)/2]) 
        rotate(a = 90, v = [0, 1, 0]) 
          screw(diameter = 3.5, length = 12, cutout_sample = true);
  }
}

module pipe_passthrough() {
  width = 50;
  height = 30;

  corners = 4;
  
  difference() {

    translate(v = [corners, corners, 0]) minkowski() {
      cube(size = [width - corners * 2, height - corners * 2, 3], center = false);
      cylinder(h = 0.01, d = corners * 2, center = false);
    }

    translate(v = [width/2, height/2, -14 - 1.5 + 3]) union() {
      cylinder(h = 14 + .2, d = 21, center = false);
      translate(v = [0, 0, 14 + .1]) cylinder(h = 2.6 + .1, d = width/2 + .1 + .15, center = false);
    }  

    translate(v = [5, 5, 3]) screw(diameter = 3.5, length = 12, cutout_sample = true);
    translate(v = [width - 5, height - 5, 3]) screw(diameter = 3.5, length = 12, cutout_sample = true);
  }
}

module pump_bracket() {
  pump_size = 50 + 10;
  plate_thickness = 3.5;

  corners = 4;

  difference() {
    union() {
      translate(v = [corners, corners, 0]) minkowski() {
        cube(size = [pump_size - corners * 2, pump_size - corners * 2, plate_thickness], center = false);
        cylinder(h = 0.01, d = corners * 2, center = false);
      }
      translate(v = [0, pump_size - corners, 0]) cube(size = [pump_size, 12 + corners, plate_thickness], center = false);

      translate(v = [0, pump_size + 12 - plate_thickness, -corners]) cube(size = [pump_size, plate_thickness, corners + plate_thickness], center = false);
      translate(v = [corners, pump_size + 12 - plate_thickness, -corners/2]) rotate(a = 90, v = [-1, 0, 0])  minkowski() {
        cube(size = [pump_size - corners*2, 14 + plate_thickness - corners*2, plate_thickness], center = false);
        cylinder(h = 0.01, d = corners * 2, center = false);
      }

      support_w = pump_size - 25;
      translate(v = [(pump_size - support_w)/2 + support_w, pump_size + 12, -14]) rotate([90, 0, -90])  linear_extrude(height = support_w) {
        polygon(points = [
          [0, 0], [pump_size + .1, 14 + .1], [0, 14 + .1]
        ]);
      }
    }

    for (i=[0:1]) for (j=[0:1]) translate(v = [5 + 50 * i, 5 + 50 * j, -.1]) {
      cylinder(d = 4 + 1, h = plate_thickness + .2);
      cylinder(d = 7 + 1, h = plate_thickness - 1 * 2 + .1);
    } 
    
    for (i=[0:1]) translate(v = [7 + (pump_size - 14) * i, pump_size + 12 - plate_thickness, -7]) rotate([90, 0, 0]) screw(diameter = 3.5, length = 12, cutout_sample = true);
  }
}

module psu_brackets() {
  translate(v = [(150 - 42.5)/2, -14, 0]) rotate([0, 90, 0])  LBracket(screws=3, width=42.5);

  translate(v = [-15, 0, 20]) rotate([180, 0, 0]) uBracket(screwSocketWidth=14, thicknessBracket=3, deviceWidth=150, deviceHeight=86, chamfer=1);
  translate(v = [-15, 0, 150]) rotate([180, 0, 0]) uBracket(screwSocketWidth=14, thicknessBracket=3, deviceWidth=150, deviceHeight=86, chamfer=1);
}

module ssd_plate() {
  height = 69.8;
  corners = 5;

  difference() {
    translate(v = [corners, corners, 0]) minkowski() {
      cube(size = [100 + 14 - corners*2, 69.8 - corners*2, 2.5], center = false);
      cylinder(h = 0.001, r = corners, center = false);
    }

    for (i=[0:1]) translate(v = [7, 7 + (69.8 - 14)*i, 2.5]) screw(diameter = 3.5, length = 12, cutout_sample = true);
  }
}

module slot_support(slots, height_offset = 0) {
  io_height = 100;

  slot_width = 0.8 * 25.4;
  slot_screwing_depth = 12;

  distance_io_mobo = 9; // distance between io and mainboard pcb
  mainboard_standoff_height = 6; // measured standoff height for mainboard
  slot_height = io_height + distance_io_mobo + mainboard_standoff_height;

  material_thickness = 3;
  support_depth = 12;

  module main_body(slots) {
    difference() {
      cube(size = [slot_width * slots + material_thickness*2, slot_height, slot_screwing_depth], center = false); // base cube

      translate(v = [material_thickness*2, slot_height - io_height - material_thickness, -.1]) // slot io cutout
        cube(size = [slot_width * slots - material_thickness*2, io_height, 2 + .2], center = false);
      
      translate(v = [material_thickness, material_thickness*1.5, 2]) // volume cutout
        cube(size = [slot_width * slots, slot_height - material_thickness*2.5, slot_screwing_depth], center = false);

      for (i=[0:slots-1]) // slot screws
        translate(v = [material_thickness + 4 + slot_width * i, slot_height - material_thickness - .1, 5]) 
          rotate(a = 90, v = [-1, 0, 0]) cylinder(h = material_thickness + .2, d = 2.7, center = false);
    }
  }

  difference() {
    if (height_offset <= 0) {
        main_body(slots = slots);
    } else {
      difference() {
        union() {
          translate(v = [0, height_offset - mainboard_standoff_height, 0]) main_body(slots = slots);
          cube(size = [slot_width * slots + material_thickness*2, height_offset - mainboard_standoff_height + .1, slot_screwing_depth], center = false); // height_offset
        }

        translate(v = [material_thickness, material_thickness*1.5, 2]) // volume cutout
          cube(size = [slot_width * slots, height_offset, slot_screwing_depth], center = false);
      }
    }

    for (i=[0:2]) 
      translate(v = [material_thickness + 7 + (slot_width * slots - 14)/2 * i, material_thickness*1.5, 7]) 
        rotate(a = 90, v = [-1, 0, 0]) 
          screw(diameter = 3.5, length = 35, cutout_sample = true);
  }
}

module radiator_mounting_240() {
  width = 120 + 14*2;
  difference() {
    cube(size = [240, width, 2.5], center = false);

    for (i=[0:1]) {
      translate(v = [5 + (120 - 5 - .1)*i, (width - 95)/2, -.1]) cube(size = [115, 95, 3], center = false);
      translate(v = [12.5 + 120*i, (width - 110)/2, -.1]) cube(size = [95, 110, 3], center = false);

      // screws: radiator
      for (j=[0:1]) {
        translate(v = [7.5 + 105*i, (width - 105)/2 + 105*j, 2.5]) 
          screw_metric_countersunk(standard=3, length=3, unthreaded_length=0, borehole_length=5, tolerance=.15);
        translate(v = [120 + 7.5 + 105*i, (width - 105)/2 + 105*j, 2.5]) 
          screw_metric_countersunk(standard=3, length=3, unthreaded_length=0, borehole_length=5, tolerance=.15);
    
        translate(v = [7 + (240 - 14)*i, 7 + (width - 14)*j, 0]) mirror(v = [0, 0, 1])   screw(diameter = 3.5, length = 12, cutout_sample = true);
      }
    }
  }
}

module radiator_filter_slot() {
  radi_thickness = 40.5;
  filter_overhang = 2.7;

  slot_width = 15.7 + .15;

  linear_extrude(height = 2) {
    polygon(points = [
      [0, 0],
      [9, 0],
      [9, 3.5],
      [8, 3.5],
      [8, 2],
      [2, 2],
      [2, 2 + radi_thickness],
      [9, 2 + radi_thickness],
      [9, 2 + radi_thickness - 1.5],
      [8, 2 + radi_thickness - 1.5],
      [8, 2 + radi_thickness - 1.5],
    ]);
  }
}

module printed_parts(rad_angle) {
  color("#bbbbbb") union() {

    mainboard_standoffs = 20;
    if (!$preview)  // preview performance fix
      translate(v = [(700 - 244)/2, -18, 100 + 15]) rotate([0, -90, 90])
        mainboard_support_grid(mainboard=[0, 1, 2, 4, 5, 6, 7, 9, 10], standoff_height=mainboard_standoffs);

    translate(v = [50, 0, 292]) rotate([90 - rad_angle, 0, 90]) radiator_angle(depth = 62);
    translate(v = [650, 0, 292]) mirror(v = [1, 0, 0])  rotate([90 - rad_angle, 0, 90]) radiator_angle(depth = 62);

    translate(v = [125 - 15, -18, 338 + 25]) rotate([90, 90, 0])  pipe_passthrough();
    translate(v = [181 - 15, -18, 230 + 25]) rotate([90, 90, 0])  pipe_passthrough();

    translate(v = [125 - 30, -18 - 70, 130 - 3.5]) pump_bracket();

    translate(v = [534, -18, 100 + 16]) psu_brackets();

    for (i=[0:1]) translate(v = [450 - 14, 0, 100 + 90 + 115*i]) rotate([-90, 0, 0])  ssd_plate();

    translate(v = [(700 - 120 - 14*2)/2, 2, 100 + (400 - 240)/2 - 20 + 240]) rotate([90, 90, 0]) radiator_mounting_240();

    translate(v = [700 - 316, -18, 100 + 12]) rotate([0, 180, 180])  slot_support(slots = 4, height_offset = mainboard_standoffs);

//    radiator_filter_slot();
  }
}

// ===================================================================================

module board(rad_angle, thickness = 18) {
  color("#ba8c63") difference() {
    rotate(a = 90, v = [1,0,0])  cube(size = [700, 400, thickness], center = false);  // mounting board

    translate(v = [0, -20, 260]) rotate([0, -rad_angle, 0])  cube(size = [500, 50, 500], center = false);
    translate(v = [400, -20, 400]) rotate([0, rad_angle, 0])  cube(size = [500, 50, 500], center = false);
  }
}

module components(atx = false, rad_angle = 25) {

  // radiators
  translate(v = [300, 72, 400]) rotate([180, -rad_angle, 0]) mirror([1, 0, 0]) radiator(fan_od = 140, fans = 2);
  translate(v = [400, 72, 400]) rotate([180, rad_angle, 0]) radiator(fan_od = 140, fans = 2);
  translate(v = [350 + 60, 0, 280 + 50]) rotate([0, 90, 90]) radiator(fan_od = 120, fans = 2);

  translate(v = [(atx ? (700 - 304)/2 : (700 - 244) / 2), -18 - 20, 15]) rotate(a = 90, v = [1,0,0])  mainboard(atx);

  translate(v = [125 - 35, -100, 30]) pump_agb();

  translate(v = [50, -18, 15]) rotate([90, -90, 0]) io();

  for (i=[0:1]) {translate(v = [450, 7 + 2.5, 20 + 115 * i]) rotate([90, 0, 0]) ssd();}

  translate(v = [534, -18, 16]) rotate([90, 0, 0]) psu();

  translate(v = [350, -18, 365]) rotate([90, 0, 0]) flow_indicator();
}

module tubes() {
  union() color("#ffc000") {
     // tubes
    translate(v = [125, 30, 100 + 238]) rotate([90, 0, 0])  cylinder(h = 100, d = 14, center = false);
    translate(v = [181, 45, 100 + 130]) rotate([90, 0, 0])  cylinder(h = 135, d = 14, center = false);

    // horizontal front
    translate(v = [120, -90, 100 + 80]) rotate([0, 90, 0])  cylinder(h = 185, d = 14, center = false);
    translate(v = [255, -90, 100 + 130]) rotate([0, 90, 0])  cylinder(h = 50, d = 14, center = false);
    translate(v = [181, -90, 100 + 130]) rotate([0, 90, 0])  cylinder(h = 64, d = 14, center = false);

    // back
    translate(v = [155, 45, 100 + 130]) rotate([0, 37, 0])  cylinder(h = 260, d = 14, center = false);
    translate(v = [105, 35, 100 + 238]) rotate([0, 69, 0])  cylinder(h = 225, d = 14, center = false);
    translate(v = [385, 35, 100 + 310]) rotate([0, 10, 0])  cylinder(h = 50, d = 14, center = false);
    translate(v = [310, 45, 100 + 335]) rotate([0, -25, 0])  cylinder(h = 30, d = 14, center = false);
  }
}

// ===================================================================================

translate(v = [-350 * 0, 0, 0]) {
  rad_angle = 25;

  //translate(v = [100, -100, 0]) rotate(a = 90, v = [1, 0, 0]) steckerleiste(plugs = 6);

  translate(v = [0, 0, 100]) board(thickness = 18, rad_angle = rad_angle);
  translate(v = [0, 0, 100]) components(atx = false, rad_angle = rad_angle);

  tubes();
  
  printed_parts(rad_angle = rad_angle);
}

