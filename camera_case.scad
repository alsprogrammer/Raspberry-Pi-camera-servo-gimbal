b = 17;
w = 17;
mink = 5;
mnk_h = 0.1;

dist_btw_screw_holes = 25;
servo_out = 31;
servo_hole_r = 11;

h=5;

mink_r_ = 2;
luft = 0.1;

screw_d = 2;

plate_width = 25;
plate_length = 24;
plate_elements_height = 4.2 - 1;
plate_whole_height = 7;

stand_width = 4;

lens_hole_d = 7;
lens_window_x = plate_length - 9.5;
lens_window_y = plate_width / 2;

screw_holes_d = screw_d - luft;
holes_d = screw_d + luft;

cable_width = 16;
cable_step = 3;

module camera_outer_case() {
    difference() {
        // outer outline
        minkowski() {
            cube([plate_length + 2 * luft, plate_width + 2 * luft, plate_whole_height]);
                
            difference () {
                sphere(r=mink_r_, $fn=45);
                translate ([-mink_r_, -mink_r_, 0])
                    cube([2 * mink_r_, 2 * mink_r_, 2 * mink_r_]);
            }
        }
        
        cube([plate_length + 2 * luft, plate_width + 2 * luft, plate_whole_height]);
    }
}

module screw_stand() {
    difference() {
        cube([stand_width, stand_width, plate_elements_height]);
        translate([stand_width / 2, stand_width / 2, 0])
            cylinder(d=screw_holes_d, plate_elements_height);
    }
}

module camera_case() {
    difference() {
        union() {
            camera_outer_case();
            screw_stand();
            translate([lens_window_x - stand_width / 2, 0, 0])
                screw_stand();
            translate([lens_window_x - stand_width / 2, plate_width - stand_width + luft, 0])
                screw_stand();
            translate([0, plate_width - stand_width + luft, 0])
                screw_stand();
            
            translate([0, plate_width / 2, mink - mink_r_])
                rotate([0, -90, 0])
                    holder();
        }
        translate([lens_window_x, lens_window_y, - mink_r_])
            cylinder(d=lens_hole_d + luft, h=mink_r_, $fn=50);
        translate([plate_length + luft, (plate_width - cable_width) / 2 - luft, plate_whole_height - cable_step])
            cube([mink_r_ + luft, cable_width + 2 * luft, cable_step]);
    }
}

module holder() {
    difference() {
        // outer outline
        minkowski() {
            linear_extrude(height=h, convexity=10, twist=0)
                polygon(points=[[0,plate_width / 2 - mink],[servo_out, dist_btw_screw_holes / 2],[servo_out, - dist_btw_screw_holes / 2], [0,-plate_width / 2 + mink]], paths=[[0,1,2,3]]);
            cylinder(r=mink, h=mnk_h);
        }
        
        translate([servo_out + mink / 2, 0, 0])
            cylinder(r=servo_hole_r, h=h+mnk_h, $fn=50);
        
        translate([servo_out, dist_btw_screw_holes / 2, 0])
            cylinder(d=screw_d, h=h+mnk_h);
        translate([servo_out, - dist_btw_screw_holes / 2, 0])
            cylinder(d=screw_d, h=h+mnk_h);
    }
}

camera_case();