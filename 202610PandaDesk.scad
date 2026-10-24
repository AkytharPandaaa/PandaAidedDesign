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
}

// Tischplatte
translate(v = [0, 0, -22]) color(c = "#ddaa00", alpha = 1.0)  cube(size = [1800, 800, 22], center = false);

// Rahmen
translate(v = [0, 0, 0]) cube(size = [44, 756, 24], center = false);
translate(v = [0, 756, 0]) cube(size = [1800, 44, 24], center = false);
translate(v = [1756, 0, 0]) cube(size = [44, 756, 24], center = false);

// senkrechte
color(c = "#dd7700", alpha = 1.0) {
  translate(v = [0, 100-22, 24]) cube(size = [24, 44, 650-24], center = false);
  translate(v = [0, 700-22, 24]) cube(size = [24, 44, 650-24], center = false);

  translate(v = [100-22, 800-24, 24]) cube(size = [44, 24, 650-24], center = false);

  translate(v = [1300-22, 800-24, 24]) cube(size = [44, 24, 525-24], center = false);
  translate(v = [1700-22, 800-24, 24]) cube(size = [44, 24, 525-24], center = false);

  translate(v = [1800-24, 100-22, 24]) cube(size = [24, 44, 525-24], center = false);
  translate(v = [1800-24, 500-22, 24]) cube(size = [24, 44, 525-24], center = false);
}

// waagerechte
color(c = "blue", alpha = 1.0) {
  translate(v = [1800-24, 100-22+44, 24+400]) cube(size = [24, 700-22, 44], center = false);

  translate(v = [1000, 800-24, 24+400]) cube(size = [800, 24, 44], center = false);
}

// moni support
color(c = "#cc0000", alpha = 1.0) {
  translate(v = [0, 520-22, 24]) cube(size = [24, 44, 650-24], center = false);
  translate(v = [360-22, 800-24, 24]) cube(size = [44, 24, 650-24], center = false);

  translate(v = [650-22, 800-24, 24]) cube(size = [44, 24, 1000-24], center = false);
  translate(v = [750-22, 800-24, 24]) cube(size = [44, 24, 1000-24], center = false);
}

decoration();
