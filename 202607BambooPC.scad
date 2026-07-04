// created by AkytharPandaaa

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

module radiator(fan_od = 140, fans = 2) {
  if (fan_od == 120) {
    difference() {
      color("#ffffff") cube(size = [280, fan_od, 30], center = false);

      color("#aa7700") for (i=[0:1]) {translate(v = [14, 24 + (i * 73),6]) cylinder(h = 25, d = 18, center = false); } // fill ports
      color("#555555") translate(v = [30, 12, 30 - 7]) cube(size = [232, 96, 8], center = false);
    }
  } else if (fan_od == 140) { // FIX: SAMPLE! INCORRECT MEASUREMENTS POSSIBLE
    difference() {
      color("#ffffff") cube(size = [320, fan_od, 30], center = false);

      color("#aa7700") for (i=[0:1]) {translate(v = [14, 24 + (fan_od - 24*2) * i,6]) cylinder(h = 25, d = 18, center = false); } // fill ports
      color("#555555") translate(v = [30, 12, 30 - 7]) cube(size = [320 - 48, fan_od - 12*2, 8], center = false);
    }
  }
}

module mainboard(atx = false) {
  if (atx) {
    color("#dddddd") cube(size = [304, 244, 40], center = false);
  } else {
    color("#dddddd") cube(size = [244, 244, 40], center = false);
  }
}

module pump_agb() {
  color("#000000") cube(size = [70, 71, 131], center = false);
}

module ssd() {
  color("#dddddd") cube(size = [100, 70, 7], center = false);
}

module psu() {
  color("#111111") cube(size = [150, 160, 86], center = false);
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

translate(v = [100, -50, 0]) rotate(a = 90, v = [1, 0, 0]) steckerleiste(plugs = 6);

translate(v = [0, 0, 100]) union() {
  color("#ddbb00") rotate(a = 90, v = [1,0,0])  cube(size = [700, 400, 18], center = false);  // mounting board

  // radiators
  translate(v = [340, 60, 400 + 1]) rotate([180, 0, 0]) mirror([1, 0, 0]) radiator(fan_od = 140, fans = 2);
  translate(v = [360, 60, 400 + 1]) rotate([180, 0, 0]) radiator(fan_od = 140, fans = 2);
  translate(v = [400, -20, 220]) rotate([90, 0, 0]) radiator(fan_od = 120, fans = 2);

  translate(v = [165, -20, 20]) rotate(a = 90, v = [1,0,0])  mainboard(atx = true);

  translate(v = [60, -100, 20]) pump_agb();

  translate(v = [50, -20, 10]) rotate([90, -90, 0]) io();

  translate(v = [20, 0, 260]) {
    for (i=[0:1]) {translate(v = [0, -20, -80 * i]) rotate([90, 0, 0]) ssd();}
  }

  translate(v = [530, -20, 20]) rotate([90, 0, 0]) psu();

//  translate(v = [500, -20, 340]) rotate([90, 30, 0]) flow_indicator();
}

