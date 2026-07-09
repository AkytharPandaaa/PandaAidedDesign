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
  dustfilter_thickness = 5;
  height = 14;
  
  difference() {
    union() {
      // planes
      translate(v = [0, 0, 0]) cube(size = [thickness, depth * .75, height], center = false);
      translate(v = [0, depth * .75 - thickness, 0]) cube(size = [depth, thickness, height], center = false);
      translate(v = [0, 0, 0]) cube(size = [depth, depth * .75, thickness], center = false);

      // fin support
      translate(v = [0, depth * .75, 0]) cube(size = [depth - 11.5, fins_to_case_offset + .1, height], center = false);

      // TODO: integrate rails for the dust filter from lancool 207

      // rail dust filter
      translate(v = [0, depth * .75 - thickness * 2 - dustfilter_thickness, 0]) cube(size = [depth - 11.5, thickness, height], center = false);
    }

    // angle
    translate(v = [0, 0, -.1]) linear_extrude(height = height + .2) {
      polygon(points = [
        [-.1, -.1],
        [depth + .1, 0],
        [depth + .1, depth * .75 + .1],
      ]);
    }

    // rail
    translate(v = [-.1, depth * .75 - thickness - dustfilter_thickness, thickness]) 
      cube(size = [thickness + .2, dustfilter_thickness, height], center = false);

    // radiator screw
    translate(v = [depth - 7.3, depth * .75 + .1, 4.4]) rotate(a = 90, v = [1, 0, 0])  union() {
      cylinder(h = .4 + .1, d = 7, center = false);
      cylinder(h = 2.5 + .1, d = 4.2 + .15, center = false);
      translate(v = [0, 0, 2.5]) cylinder(h = 5, d = 5.6 + .1, center = false);
    }

    // wood screws
    translate(v = [thickness, height/2, height/2]) rotate(a = 90, v = [0, 1, 0]) screw(diameter = 3.5, length = 12, cutout_sample = true);
    translate(v = [thickness, height/2 + depth*.75 - thickness*3 - height, height/2]) rotate(a = 90, v = [0, 1, 0]) screw(diameter = 3.5, length = 12, cutout_sample = true);
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

module printed_parts(rad_angle) {
  color("#555555") union() {
    translate(v = [65, 0, 292]) rotate([90 - rad_angle, 0, 90]) radiator_angle(depth = 63);
    //translate(v = [(700 - 244)/2, -18, 100 + 15]) rotate([0, -90, 90]) mainboard_support_grid(mainboard=[0, 1, 2, 4, 5, 6, 7, 9, 10], standoff_height=20); // commented due to performance issues

    translate(v = [125 - 15, -18, 338 + 25]) rotate([90, 90, 0])  pipe_passthrough();
    translate(v = [181 - 15, -18, 230 + 25]) rotate([90, 90, 0])  pipe_passthrough();

    translate(v = [125 - 30, -18 - 70, 130 - 3.5]) pump_bracket();

    translate(v = [534, -18, 100 + 16]) psu_brackets();

    for (i=[0:1]) translate(v = [450 - 14, 0, 100 + 90 + 115*i]) rotate([-90, 0, 0])  ssd_plate();
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
  translate(v = [0, 0, 100]) components(atx = true, rad_angle = rad_angle);

  tubes();
  
  printed_parts(rad_angle = rad_angle);
}

