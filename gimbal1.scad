b = 17;
w = 17;
mink = 5;

dist_btw_screw_holes = 25;
servo_out = 40;

h=5;

module holder() {
    difference() {
        // outer outline
        minkowski() {
            linear_extrude(height=h, convexity=10, twist=0)
                polygon(points=[[0,0],[servo_out, dist_btw_screw_holes / 2],[servo_out, - dist_btw_screw_holes / 2]], paths=[[0,1,2]]);
            cylinder(r=mink, h=0.1);
        }
        
        translate([servo_out + mink / 2, 0, 0])
            cylinder(r=11, h=5.1, $fn=50);
        
        translate([servo_out, dist_btw_screw_holes / 2, 0])
            cylinder(d=2, h=5.1);
        translate([servo_out, - dist_btw_screw_holes / 2, 0])
            cylinder(d=2, h=5.1);
        
        translate([-5, -1.25, 0])
            cube([12, 2.5, 5.1]);
        translate([-5, 3, 0])
            cube([12, 5, 5.1]);
        
        translate([1, 3, 2.5])
            rotate([90, 0, 0])
                cylinder(d=2, h=10);
    }
}

holder();