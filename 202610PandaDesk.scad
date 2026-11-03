// created by AkytharPandaaa

use <Parts/Screw.scad>

use <202607BambooPC.scad>
use <202512InductionPadOverheadMount.scad>

$fn = $preview? 25 : 125;

module decoration() {
  //translate(v = [1100, 800-24-80, 0]) bamboo_pc();

  // ASUS 34" (heise: 809x366x107mm)
  translate(v = [300, 615+47, 605-366+120]) color(c = "#cc0077", alpha = 1.0) cube(size = [809, 107, 366], center = false);

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
//  translate(v = [325, 800-36-95, 55]) color(c = "#555555", alpha = 1.0)  cube(size = [82, 95, 180], center = false);
//  translate(v = [1025, 800-36-95, 55]) color(c = "#555555", alpha = 1.0)  cube(size = [82, 95, 180], center = false);
}

module desk() {
  // Tischplatte
  translate(v = [0, 0, -22]) color(c = "#ddaa00", alpha = 1.0)  cube(size = [1800, 800, 22], center = false);

  // Rahmen
  translate(v = [0, 0, 0]) cube(size = [44, 800, 24], center = false);
  translate(v = [44, 756, 0]) cube(size = [1756, 44, 24], center = false);

  // senkrechte
  color(c = "#dd7700", alpha = 1.0) {
    translate(v = [0, 0, 24]) cube(size = [24, 44, 650-44-5-24], center = false);

    translate(v = [0, 800-44-75, 24]) cube(size = [24, 44, 140], center = false);
    translate(v = [0, 800-225, 24]) cube(size = [24, 44, 140], center = false);
    translate(v = [75, 800-24, 24]) cube(size = [44, 24, 140], center = false);
    translate(v = [200, 800-24, 24]) cube(size = [44, 24, 500], center = false);
    translate(v = [1045, 800-24, 24]) cube(size = [44, 24, 300], center = false);

    translate(v = [1175-22, 800-24, 24]) cube(size = [44, 24, 400], center = false);
    translate(v = [1175-22, 800-120-44, 0]) cube(size = [44, 120, 24], center = false);
    translate(v = [1175-22, 800-145, 0]) rotate([45,0,0])  cube(size = [44, 200, 24], center = false);
    translate(v = [1700-22, 800-24, 24]) cube(size = [44, 24, 400], center = false);
    translate(v = [1700-22, 800-120-44, 0]) cube(size = [44, 120, 24], center = false);
    translate(v = [1700-22, 800-145, 0]) rotate([45,0,0])  cube(size = [44, 200, 24], center = false);
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

    translate(v = [650-22, 800-24, 24]) cube(size = [44, 24, 1100], center = false);
    translate(v = [750-22, 800-24, 24]) cube(size = [44, 24, 1100], center = false);

    translate(v = [650-22, 800-44-120, 0]) cube(size = [44, 120, 24], center = false);
    translate(v = [750-22, 800-44-120, 0]) cube(size = [44, 120, 24], center = false);
    translate(v = [650-22+44, 800-44-120, 0]) cube(size = [100-44, 44, 24], center = false);
    translate(v = [650-22, 800-140, 0]) rotate([60, 0, 0])  cube(size = [44, 275, 24], center = false);
    translate(v = [750-22, 800-140, 0]) rotate([60, 0, 0])  cube(size = [44, 275, 24], center = false);
    for (i=[0:3]) translate(v = [650-22+44, 800-24, 24+50+i*(1000/4)]) cube(size = [100-44, 24, 44], center = false);
  }

  // plates
  color(c = "#00aacc", alpha = 1.0) {
    translate(v = [24, 22, 24+140]) cube(size = [6.5, 500, 86], center = false);
    translate(v = [24, 22+280, 24]) cube(size = [6.5, 800-22-24-280, 140], center = false);
    translate(v = [36, 800-24-6.5, 24]) cube(size = [125, 6.5, 140], center = false);
    translate(v = [36+125, 800-24-6.5, 24]) cube(size = [125, 6.5, 600], center = false);

    difference() {
    translate(v = [36+250, 800-24-6.5, 24]) cube(size = [850, 6.5, 375], center = false); // [342, 6.5, 250]
    translate(v = [650+22, 800-24-6.5-1, 24-1]) cube(size = [56, 6.5+2, 52], center = false); // [342, 6.5, 250]
    }
  }
}

module angled_connector(angle, height, width, depth, thickness = 3, tolerance = .15) {
  difference() {
    union() {
      cube(size = [width+thickness*2+tolerance, depth+thickness+tolerance+cos(90-angle)*(width+tolerance+thickness*2), height+thickness+tolerance], center = false);
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
    translate(v = [thickness-(cos(90-angle)*thickness), depth+sin(90-angle)*thickness+cos(90-angle)*thickness, thickness]) 
      rotate(a = angle, v = [0, 0, 1]) 
        cube(size = [width+tolerance, depth+tolerance+.1, height+tolerance+.1], center = false);
  }
}

module pc_socket(angle) {
  module rounded_corner(radius, height, rotation=0) {
    translate(v = [radius/2, radius/2, -.1]) 
      rotate(a = 90*(rotation%4), v = [0, 0, 1]) 
        translate(v = [radius/2, radius/2, 0]) difference() {
          rotate(a = 180, v = [0, 0, 1]) cube(size = [radius+.1, radius+.1, height+.2], center = false);
          translate(v = [0, 0, -.1]) cylinder(h = height+.4, r = radius, center = false);
        }    
  }
  module base(size2d, thickness=4) {
    screw_edge_distance = 7;
    difference() {
      cube(size = [size2d[0], size2d[1], thickness], center = false);

      // screws
      translate(v = [size2d[0]/2, screw_edge_distance, thickness]) screw(diameter = 3.5, length = 12, cutout_sample = true);
      for (i=[0:1])
        translate(v = [screw_edge_distance+(size2d[0]-screw_edge_distance*2)*i, size2d[1]-screw_edge_distance, thickness])
          screw(diameter = 3.5, length = 12, cutout_sample = true);

      // rounded corners
      radius=screw_edge_distance;
      for (x=[0:1]) 
        for (y=[0:1])
          translate(v = [(size2d[0]-radius)*x, (size2d[1]-radius)*y, 0])
            rounded_corner(radius=radius, height=4, rotation= x==0&&y==1? 3:y+x);
    }    
  }
  module socket(board, lower, higher, width) { // params = thicknesses
    difference() {
      cube(size = [lower+higher+board+.15, width, 30], center = false);
      //translate([0, 0, 0]); cube(size = [board+.15, width+.2, 20], center=false);
    }
  }

  board_thickness = 19;
  lower_thickness = 5;
  higher_thickness = 3;
  width = 25;

//  rotate(a = angle, v = [1, 0, 0])
//    base(size2d = [width, (board_thickness+lower_thickness+higher_thickness)/cos(45)+2*(14)], thickness=3.5);
  socket(board = board_thickness, higher=higher_thickness, lower=lower_thickness, width=width);
}
module charging_pad() {
  module rounded_corner(radius, height, rotation=0) {
    translate(v = [radius/2, radius/2, -.1]) 
      rotate(a = 90*(rotation%4), v = [0, 0, 1]) 
        translate(v = [radius/2, radius/2, 0]) difference() {
          rotate(a = 180, v = [0, 0, 1]) cube(size = [radius+.1, radius+.1, height+.2], center = false);
          translate(v = [0, 0, -.1]) cylinder(h = height+.4, r = radius, center = false);
        }    
  }
  translate(v = [650 + (100-95.95)/2, 680, 85]) rotate(a = 60, v = [1,0,0]) union() {
    translate(v = [95.95/2, 15, 2.5]) rotate([0, -90, 90])  difference() {
      induction_pad_mount(depth = 30, angle = 20, cutout_sample = false);
      translate(v = [-50-2.5, -50, -30/2-1]) cube(size = [50, 100, 30+2], center = false);
    }
    translate(v = [-14 - (100-95.95)/2, 0, 0]) difference() {
      cube(size = [14*2+100, 14, 2.5], center = false);

      for (x=[0:1]) 
        for (y=[0:1]) {
          translate(v = [(14*2+100-7)*x, (14-7)*y, 0])
            rounded_corner(radius=7, height=2.5, rotation= x==0&&y==1? 3:y+x);
          translate(v = [7 + (14+100)*y, 7, 2.5]) screw(diameter = 3.5, length = 12, cutout_sample = true);
        }
    }
  }
}

//angled_connector(angle = 35, height = 44, width = 24, depth = 30, thickness = 3);
//pc_socket(angle = 45);
charging_pad();

desk();
decoration();
