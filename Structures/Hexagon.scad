// created by IndiePandaaaaa | Lukas

function hexagon_get_inner_diameter(single_outer_diameter = 20) = tan(60) * (single_outer_diameter / 2);

function hexagon_inbetween_distance_x(single_outer_diameter = 20) = single_outer_diameter -
  hexagon_get_inner_diameter(single_outer_diameter);

function hexagon_get_y_inner_element_additional_height(single_outer_diameter = 20) = single_outer_diameter / 2 +
    hexagon_inbetween_distance_x(single_outer_diameter) * cos(30) + (single_outer_diameter / 2) * cos(60);

function hexagon_get_y_outer_element_height(single_outer_diameter = 20) = single_outer_diameter;

function hexagon_get_y_next_structure(single_outer_diameter = 20) = (single_outer_diameter / 2 * 3) +
    hexagon_inbetween_distance_x(single_outer_diameter) * cos(30) * 2;

function hexagon_get_y_element_height(single_outer_diameter = 20) =
  hexagon_get_y_outer_element_height(single_outer_diameter) +
  hexagon_get_y_inner_element_additional_height(single_outer_diameter);

function hexagon_get_x_element_count(width, single_outer_diameter = 20) = floor(width / single_outer_diameter);

function hexagon_get_y_element_count(depth, single_outer_diameter = 20) = floor(((depth -
  (hexagon_get_y_element_height(single_outer_diameter) - hexagon_get_y_next_structure(single_outer_diameter))) /
  hexagon_get_y_next_structure(single_outer_diameter)) * 2);

function hexagon_get_used_width(width, single_outer_diameter = 20) = single_outer_diameter *
  hexagon_get_x_element_count(width, single_outer_diameter) - hexagon_inbetween_distance_x(single_outer_diameter);

function hexagon_get_used_depth(depth, single_outer_diameter = 20) = round(hexagon_get_y_element_count(depth,
single_outer_diameter) / 2) * hexagon_get_y_outer_element_height(single_outer_diameter) +
    floor(hexagon_get_y_element_count(depth, single_outer_diameter) / 2) * (hexagon_get_y_next_structure(
  single_outer_diameter) - single_outer_diameter) +
      (hexagon_get_y_element_count(depth, single_outer_diameter) + 1) % 2 * (hexagon_get_y_element_height(
  single_outer_diameter) - hexagon_get_y_next_structure(single_outer_diameter));

module hexagon_pattern(width, depth, thickness, single_outer_diameter = 20, vertices = 6) {
  inner_diameter = hexagon_get_inner_diameter(single_outer_diameter);

  count_x = hexagon_get_x_element_count(width, single_outer_diameter);
  count_y = hexagon_get_y_element_count(depth, single_outer_diameter);

  angle = 360 / vertices * 1.5;

  for (y = [0:count_y - 1]) {
    for (x = [0:count_x - 1]) {

      if (y % 2 == 0) {
        translate([inner_diameter / 2 + single_outer_diameter * x, (single_outer_diameter / 2) + inner_diameter
          * y, -0.01]) {
          linear_extrude(height = thickness + 0.02) {
            rotate([0, 0, angle]) circle(d = single_outer_diameter, $fn = vertices);
          }
        }
      } else if (x < count_x - 1) {
        translate([inner_diameter / 2 + single_outer_diameter * x + single_outer_diameter / 2,
            (single_outer_diameter / 2) + inner_diameter * y, -0.01]) {
          linear_extrude(height = thickness + 0.02) {
            rotate([0, 0, angle]) circle(d = single_outer_diameter, $fn = vertices);
          }
        }
      }

    }
  }
}


module __hex_pattern(width, depth, thickness, hex_inner_diameter = 10, border_thickness = 1) {
  function __hex_outer_diameter(inner_diameter) = ((inner_diameter / 2) / tan(60)) * 4;
  function __hex_count_width(width, inner_diameter, border_thickness) = floor((width - border_thickness) / (inner_diameter + border_thickness));
  function __hex_count_depth(depth, inner_diameter, border_thickness) = floor((depth - border_thickness) / (inner_diameter * .75 + border_thickness));

  hex_outer_diameter = __hex_outer_diameter(hex_inner_diameter);
  count_x = __hex_count_width(width, hex_inner_diameter, border_thickness);
  count_y = __hex_count_depth(depth, hex_inner_diameter, border_thickness);

  for (y = [0:count_y - 1]) {
    for (x = [0:count_x - 1]) {
      translate([
          //(hex_id - grid_thickness * hex_id/4) * x, 
          //(hex_od - grid_thickness * hex_od/4) * y + ((hex_id/2 - grid_thickness/2)* (x%2)),
      (hex_inner_diameter + border_thickness) * x + (hex_inner_diameter / 2 + border_thickness / 2) * (y%2),
      (hex_outer_diameter/3*2 + border_thickness*2) * y,
      0
      ]) {
          if (y%2 == 1 && count_x-1 == x) {}
          else
            translate(v = [hex_outer_diameter/2, hex_outer_diameter/2, 0])
              rotate(a = 90, v = [0,0,1]) 
                cylinder(h = thickness, d=hex_outer_diameter, center = false, $fn = 6);
      }
    }
  }
}

width = 100;
depth = 100;
difference() {
  //cube([width, depth, 3]);
  //translate([(width - hexagon_get_used_width(width)) / 2, (depth - hexagon_get_used_depth(depth)) / 2, 0])
    __hex_pattern(width, depth, 3);
}
