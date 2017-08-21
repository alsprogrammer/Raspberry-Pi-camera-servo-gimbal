beam_thikness = 6;
beam_width = 28;
beam_hole_d = 7;
beam_holes_dist = 15.5;

camera_console_out = 80;
stand_height = camera_console_out + 2 * beam_thikness;

stand_length = 34;
stand_width = 10;
stand_hole1_y_pos = 5;
stand_hole2_y_pos = 29;
stand_holes_d = 3;

module camera_arm_stand() {
    difference() {
        union() {
            cube([stand_height, beam_width, beam_thikness]);
            translate([- beam_thikness, 0, 0])
                cube([beam_thikness, beam_width, beam_width / 2 + beam_thikness]);
            translate([- beam_thikness, beam_width / 2, beam_width / 2 + beam_thikness])
                rotate([0, 90, 0])
                    cylinder(d=beam_width, h=beam_thikness);        
            translate([stand_height, 0, 0])
                cube([beam_thikness, stand_length, stand_width]);
        }

        translate([- beam_thikness, beam_width / 2, beam_width / 2 + beam_thikness])
            rotate([0, 90, 0])
                cylinder(d=beam_hole_d, h=beam_thikness, $fn=50);
        translate([stand_height, stand_hole1_y_pos, stand_width / 2])
            rotate([0, 90, 0])
                cylinder(d=stand_holes_d, h=beam_thikness, $fn=30);
        translate([stand_height, stand_hole2_y_pos, stand_width / 2])
            rotate([0, 90, 0])
                cylinder(d=stand_holes_d, h=beam_thikness, $fn=30);
    }
}

camera_arm_stand();
