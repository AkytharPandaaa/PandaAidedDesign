// created by AkytharPandaaa

use <202607BambooPC.scad>

$fn = $preview? 25 : 125;

module decoration() {
  translate(v = [1070, 700, 0]) bamboo_pc();

  // ASUS 34" (heise: 809x366x107mm)
  translate(v = [300, 615+47, 250]) color(c = "#222222", alpha = 1.0) cube(size = [809, 107, 366], center = false);

  // BENQ 24" (heise: 553x329x51mm)
  translate(v = [42, 415+47, 105]) color(c = "#444444", alpha = 1.0) 
    rotate([0,0,35])  cube(size = [329, 51, 553], center = false);

  // LG 27" (heise: 613.5x363.5x45.4mm)
  translate(v = [400, 800-24-45-7, 620]) color(c = "#777777", alpha = 1.0) cube(size = [614, 46, 364], center = false);

  // White Board
  translate(v = [24, -150, 250]) color(c = "#dddddd", alpha = 1.0) cube(size = [25, 600, 400], center = false);

  // Fans
  translate(v = [24, 50, 24]) color(c = "#111111", alpha = 1.0) cube(size = [25, 280, 140], center = false);

  // Steckerleiste
  translate(v = [1220, 625, 0]) rotate(a = 90, v = [1, 0, 0]) steckerleiste(plugs = 6);
}

// Tischplatte
translate(v = [0, 0, -22]) color(c = "#ddaa00", alpha = 1.0)  cube(size = [1800, 800, 22], center = false);

// Rahmen
translate(v = [0, 0, 0]) cube(size = [44, 756, 24], center = false);
translate(v = [0, 756, 0]) cube(size = [1800, 44, 24], center = false);

// senkrechte
color(c = "#dd7700", alpha = 1.0) {
  translate(v = [0, 0, 24]) cube(size = [24, 44, 650-24], center = false);

  translate(v = [0, 800-44-75, 24]) cube(size = [24, 44, 150], center = false);
  translate(v = [75, 800-24, 24]) cube(size = [44, 24, 150], center = false);
  translate(v = [200, 800-24, 24]) cube(size = [44, 24, 500], center = false);
  translate(v = [550, 800-24, 24]) cube(size = [44, 24, 200], center = false);
  translate(v = [800, 800-24, 24]) cube(size = [44, 24, 200], center = false);
  translate(v = [1050, 800-24, 24]) cube(size = [44, 24, 200], center = false);

  translate(v = [1150-22, 800-24, 24]) cube(size = [44, 24, 400], center = false);
  translate(v = [1700-22, 800-24, 24]) cube(size = [44, 24, 400], center = false);
  translate(v = [1150-22, 800-100-44, 0]) cube(size = [44, 100, 24], center = false);
  translate(v = [1700-22, 800-100-44, 0]) cube(size = [44, 100, 24], center = false);
  translate(v = [1150-22, 800-120, 0]) rotate([45,0,0])  cube(size = [44, 160, 24], center = false);
  translate(v = [1700-22, 800-120, 0]) rotate([45,0,0])  cube(size = [44, 160, 24], center = false);
}

// waagerechte
color(c = "blue", alpha = 1.0) {
  translate(v = [0, 44, 24+550]) cube(size = [24, 500-44, 44], center = false);
  translate(v = [0, 44, 24+125]) cube(size = [24, 500-44, 44], center = false);

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
  translate(v = [24, 375-24, 24]) cube(size = [12, 425, 150], center = false);
  translate(v = [36, 800-24-12, 24]) cube(size = [125, 12, 150], center = false);
  translate(v = [36+125, 800-36, 24]) cube(size = [125, 12, 600], center = false);
  translate(v = [36+250, 800-36, 24]) cube(size = [342, 12, 250], center = false);
  translate(v = [650+22, 800-36, 24+60]) cube(size = [56, 12, 175], center = false);
  translate(v = [750+22, 800-36, 24]) cube(size = [342, 12, 250], center = false);
}


decoration();
