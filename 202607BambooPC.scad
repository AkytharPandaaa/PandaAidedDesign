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

module board(thickness = 18) {
  color("#ba8c63") rotate(a = 90, v = [1,0,0])  cube(size = [700, 400, thickness], center = false);  // mounting board
}

module components(atx = false) {

  // radiators
  translate(v = [300, 72, 400]) rotate([180, -25, 0]) mirror([1, 0, 0]) radiator(fan_od = 140, fans = 2);
  translate(v = [400, 72, 400]) rotate([180, 25, 0]) radiator(fan_od = 140, fans = 2);
  translate(v = [350 + 60, 0, 300]) rotate([0, 90, 90]) radiator(fan_od = 120, fans = 2);

  translate(v = [180, -20, 20]) rotate(a = 90, v = [1,0,0])  mainboard(atx);

  translate(v = [70, -100, 20]) pump_agb();

  translate(v = [50, -20, 10]) rotate([90, -90, 0]) io();

  for (i=[0:1]) {translate(v = [150, 7, 20 + 115 * i]) rotate([90, 0, 0]) ssd();}

  translate(v = [520, -20, 20]) rotate([90, 0, 0]) psu();

  translate(v = [350, -20, 365]) rotate([90, 0, 0]) flow_indicator();
}

module tubes() {
  union() color("#ffc000") {
     // tubes
    translate(v = [105, 30, 265]) rotate([90, 0, 0])  cylinder(h = 100, d = 14, center = false);
    translate(v = [155, 35, 210]) rotate([90, 0, 0])  cylinder(h = 105, d = 14, center = false);

    // horizontal front
    translate(v = [120, -70, 150]) rotate([0, 90, 0])  cylinder(h = 185, d = 14, center = false);
    translate(v = [255, -70, 210]) rotate([0, 90, 0])  cylinder(h = 50, d = 14, center = false);
    translate(v = [155, -70, 210]) rotate([0, 90, 0])  cylinder(h = 90, d = 14, center = false);

    // back
    translate(v = [155, 35, 210]) rotate([0, 35, 0])  cylinder(h = 275, d = 14, center = false);
    translate(v = [105, 35, 265]) rotate([0, 60, 0])  cylinder(h = 240, d = 14, center = false);
    translate(v = [385, 35, 385]) rotate([0, 10, 0])  cylinder(h = 75, d = 14, center = false);
    translate(v = [310, 35, 435]) rotate([0, -25, 0])  cylinder(h = 30, d = 14, center = false);
  }
}

// ===================================================================================

translate(v = [100, -100, 0]) rotate(a = 90, v = [1, 0, 0]) steckerleiste(plugs = 6);

translate(v = [0, 0, 100]) board(thickness = 18);
translate(v = [0, 0, 100]) components(atx = true);

tubes();

