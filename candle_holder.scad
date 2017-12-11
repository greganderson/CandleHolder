// Simple candle holder
// rewrite from greganderson/CandleHolder
// Parameterized everything
// Rounded all the edges

$fn = 80;
e=0.05;

// base dimensions
base_d = 70; // outer diameter of the base
base_h = 5;  // thicknes of the base bottom
rim_h = 12;   // total height of the rim above the base
rim_t = 5;   // thickness of the rim =, must be <= rim_h

// handle dimensions
handle_id = 18;
handle_t = 5;
handle_od = handle_id+2*handle_t;

// Candle holder dimensions
holder_d1 = 20;
holder_d2 = 24;
holder_t = 3;
holder_h = 30;

// Base
cylinder(h=base_h, d=base_d);
translate([0, 0, base_h]) {
    difference() {
        cylinder(h=rim_h-rim_t,d=base_d);
        cylinder(h=rim_h-rim_t+e,d=base_d-2*rim_t);
    }
    translate([0,0,rim_h-rim_t])
    rotate_extrude()
    translate([base_d/2-rim_t/2,0,0])
    circle(d=rim_t);
}

// Handle
translate([base_d/2-e,handle_t/2,0])
rotate([90,0]) {
    difference() {
        cube([handle_od/2,min(handle_od/2,base_h+rim_h-rim_t),handle_t]);
        translate([handle_id/2+handle_t,handle_id/2+handle_t,-e])
        cylinder(d=handle_id+handle_t,h=handle_t+2*e);
    }
    translate([handle_id/2+handle_t,handle_id/2+handle_t,0])
    rotate_extrude()
    translate([(handle_id)/2+handle_t/2,handle_t/2,0])
    circle(d=handle_t);
}

// Candle Holder
translate([0,0,base_h-e]) {
    difference() {
        cylinder(d1=holder_d1+2*holder_t, d2=holder_d2+2*holder_t, h=holder_h);
        cylinder(d1=holder_d1, d2=holder_d2, h=holder_h);
    }
    translate([0,0,holder_h])
    rotate_extrude()
    translate([holder_d2/2+holder_t/2,0,0])
    circle(d=holder_t);
}
