// created by AkytharPandaaa

use <202607BambooPC.scad>

$fn = $preview? 25 : 125;

module decoration() {
  translate(v = [1100, 700, 0]) bamboo_pc();

  // ASUS 34" (heise: 809x366x107mm)
  translate(v = [300, 615+47, 605-366+120]) color(c = "#222222", alpha = 1.0) cube(size = [809, 107, 366], center = false);

  // BENQ 24" (heise: 553x329x51mm)
  translate(v = [42, 415+47, 105]) color(c = "#444444", alpha = 1.0) 
    rotate([0,0,35])  cube(size = [329, 51, 553], center = false);

  // LG 27" (heise: 613.5x363.5x45.4mm)
  translate(v = [400, 800-24-45-7, 620]) color(c = "#777777", alpha = 1.0) cube(size = [614, 46, 364], center = false);

  // White Board
  translate(v = [24, -150, 250]) color(c = "#dddddd", alpha = 1.0) cube(size = [25, 600, 400], center = false);

  // Fans
  translate(v = [24, 22, 24]) color(c = "#111111", alpha = 1.0) cube(size = [25, 280, 140], center = false);

  // Steckerleiste
  translate(v = [1220, 625, 0]) rotate(a = 90, v = [1, 0, 0]) steckerleiste(plugs = 6);

  // Speakers
  translate(v = [325, 800-36-95, 55]) color(c = "#555555", alpha = 1.0)  cube(size = [82, 95, 180], center = false);
  translate(v = [1025, 800-36-95, 55]) color(c = "#555555", alpha = 1.0)  cube(size = [82, 95, 180], center = false);
}

module desk() {
  // Tischplatte
  translate(v = [0, 0, -22]) color(c = "#ddaa00", alpha = 1.0)  cube(size = [1800, 800, 22], center = false);

  // Rahmen
  translate(v = [0, 0, 0]) cube(size = [44, 756, 24], center = false);
  translate(v = [0, 756, 0]) cube(size = [1800, 44, 24], center = false);

  // senkrechte
  color(c = "#dd7700", alpha = 1.0) {
    translate(v = [0, 0, 24]) cube(size = [24, 44, 650-44-5-24], center = false);

    translate(v = [0, 800-44-75, 24]) cube(size = [24, 44, 140], center = false);
    translate(v = [0, 800-225, 24]) cube(size = [24, 44, 140], center = false);
    translate(v = [75, 800-24, 24]) cube(size = [44, 24, 140], center = false);
    translate(v = [200, 800-24, 24]) cube(size = [44, 24, 500], center = false);
  //  translate(v = [550, 800-24, 24]) cube(size = [44, 24, 200], center = false);
  //  translate(v = [800, 800-24, 24]) cube(size = [44, 24, 200], center = false);
    translate(v = [1045, 800-24, 24]) cube(size = [44, 24, 200], center = false);

    translate(v = [1175-22, 800-24, 24]) cube(size = [44, 24, 400], center = false);
    translate(v = [1175-22, 800-100-44, 0]) cube(size = [44, 100, 24], center = false);
    translate(v = [1175-22, 800-120, 0]) rotate([45,0,0])  cube(size = [44, 160, 24], center = false);
    translate(v = [1700-22, 800-24, 24]) cube(size = [44, 24, 400], center = false);
    translate(v = [1700-22, 800-100-44, 0]) cube(size = [44, 100, 24], center = false);
    translate(v = [1700-22, 800-120, 0]) rotate([45,0,0])  cube(size = [44, 160, 24], center = false);
  }

  // waagerechte
  color(c = "#0000cc", alpha = 1.0) {
    translate(v = [0, 44, 24+140-22]) cube(size = [24, 498-44, 44], center = false);
    translate(v = [0, 44, 250+5]) cube(size = [24, 498-44, 44], center = false);
    translate(v = [0, 0, 650-5-44]) cube(size = [24, 498, 44], center = false);

    translate(v = [414, 800-24, 24+400]) cube(size = [214, 24, 44], center = false);
    translate(v = [750+22, 800-24, 24+400]) cube(size = [1800-750-100, 24, 44], center = false);
  }

  // moni support
  color(c = "#cc0000", alpha = 1.0) {
    translate(v = [0, 520-22, 24]) cube(size = [24, 44, 650-24], center = false);
    translate(v = [370, 800-24, 24]) cube(size = [44, 24, 650-24], center = false);
    translate(v = [0, 520, 24+250]) rotate([0,0,-55]) cube(size = [24, 480, 44], center = false);
    translate(v = [0, 520, 24+450]) rotate([0,0,-55]) cube(size = [24, 480, 44], center = false);
    translate(v = [0, 520, 24+582]) rotate([0,0,-55]) cube(size = [24, 480, 44], center = false);
    translate(v = [80, 576, 24+44+250]) rotate([0,0,-55]) cube(size = [24, 44, 200-44], center = false);
    translate(v = [130, 611, 24+44+250]) rotate([0,0,-55]) cube(size = [24, 44, 200-44], center = false);

    translate(v = [650-22, 800-24, 24]) cube(size = [44, 24, 1000-24], center = false);
    translate(v = [750-22, 800-24, 24]) cube(size = [44, 24, 1000-24], center = false);

    translate(v = [650-22, 800-44-120, 0]) cube(size = [44, 120, 24], center = false);
    translate(v = [750-22, 800-44-120, 0]) cube(size = [44, 120, 24], center = false);
    translate(v = [650-22+44, 800-44-120, 0]) cube(size = [100-44, 44, 24], center = false);
    translate(v = [650-22, 800-140, 0]) rotate([60, 0, 0])  cube(size = [44, 275, 24], center = false);
    translate(v = [750-22, 800-140, 0]) rotate([60, 0, 0])  cube(size = [44, 275, 24], center = false);
    for (i=[0:3]) translate(v = [650-22+44, 800-24, 24+50+i*(1000/4)]) cube(size = [100-44, 24, 44], center = false);
  }

  // plates
  color(c = "#00aacc", alpha = 1.0) {
    translate(v = [24, 22, 24+140]) cube(size = [12, 500, 86], center = false);
    translate(v = [24, 22+280, 24]) cube(size = [12, 800-22-24-280, 140], center = false);
    translate(v = [36, 800-24-12, 24]) cube(size = [125, 12, 140], center = false);
    translate(v = [36+125, 800-36, 24]) cube(size = [125, 12, 600], center = false);

    difference() {
    translate(v = [36+250, 800-36, 24]) cube(size = [850, 12, 350], center = false); // [342, 12, 250]
    translate(v = [650+22, 800-36-1, 24-1]) cube(size = [56, 14, 52], center = false); // [342, 12, 250]
    }
    //translate(v = [650+22, 800-36, 24+60]) cube(size = [56, 12, 275], center = false);
    //translate(v = [750+22, 800-36, 24]) cube(size = [342, 12, 350], center = false);
  }
}

module angled_connector(angle, height, width, depth, thickness = 3, tolerance = .15) {
  difference() {
    union() {
      cube(size = [width+thickness*2+tolerance, depth+width+thickness*2+tolerance, height+thickness+tolerance], center = false);
      translate(v = [0, depth, 0]) 
        rotate(a = angle, v = [0, 0, 1]) 
          cube(size = [width+thickness*2+tolerance, depth, height+thickness+tolerance], center = false);
    }

    // off-cuts
    translate(v = [width+thickness*2+tolerance, width+cos(90-angle)*(width+thickness), -.1]) 
      rotate(a = angle, v = [0, 0, 1]) color(c = "red", alpha = 1.0) 
        cube(size = [width+thickness*2+tolerance, depth*2, height+thickness+tolerance+.2], center = false);

    // wooden
    translate(v = [thickness, -.1, -.1]) 
      cube(size = [width+tolerance, depth+tolerance, height+tolerance+thickness+.2], center = false);
    echo(tan(90-angle)*thickness)
    translate(v = [thickness-(cos(90-angle)*thickness), depth+sin(90-angle)*thickness+cos(90-angle)*thickness, thickness]) 
      rotate(a = angle, v = [0, 0, 1]) 
        cube(size = [width+tolerance, depth+tolerance+.1, height+tolerance+.1], center = false);
  }
}

angled_connector(angle = 35, height = 44, width = 24, depth = 30, thickness = 3);

//desk();
//decoration();
