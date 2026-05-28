// created by AkytharPandaaa
// encoding: utf-8

use <Logo/PandaSilhouette.scad>

module stand(angle1 = 60, angle2 = 45, plate_thickness = 3, height = 50, thickness = 5) {
  module plate_hook(angle, thickness, material_thickness){}
  width1 = height / tan(angle1);
  width2 = height / tan(angle2);
  thickness_struct = 2.5;
  width_struct1 = (thickness_struct + plate_thickness) / tan(angle1);
  width_struct2 = (thickness_struct + plate_thickness) / tan(angle2);

  full_width = thickness_struct * 2 + plate_thickness * 2 + width1 + width2;

  //  linear_extrude(height=thickness) {
  //    polygon(
  //      points=[
  //        [0, 0],
  //        [full_width, 0],
  //        [full_width - width_struct2, thickness_struct + plate_thickness],
  //        [full_width - width_struct2 - plate_thickness, thickness_struct + plate_thickness],
  //        [full_width - width_struct2 - plate_thickness, plate_thickness], // hä?
  //        [thickness_struct + plate_thickness + width1, height],
  //      ]
  //    );
  //  }
  plate_hook(angle=angle1, thickness=thickness, material_thickness=material_thickness);
}

stand(angle1=60, angle2=45, plate_thickness=3, height=50, thickness=5);
