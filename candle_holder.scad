$fn = 180;
e=0.05;

// base dimensions
base_d1 = 70; // outer diameter of the base, lower
base_d2 = 77; //outer diameter of the base, upper
base_h = 6;  // thicknes of the base bottom
rim_h = 12;   // total height of the rim above the base
rim_t = 2;   // thickness of the rim =, must be <= rim_h
base_r = 2; // rounding on the bottom

// handle dimensions
handle_id = 18;
handle_t = 6;
handle_od = handle_id+2*handle_t;

// Candle holder dimensions
holder_d1 = 22;
holder_d2 = 24.5;
holder_t = 3;
holder_h = 30;

intersection() {
//    cube([100,100,100]);
    complete();
}

module complete() {
    // The base and the handle share a common diff
    difference () {
        union() {
            base(0);
            handle(0);
        }
        union() {
            base(1);
            handle(1);
        }
    }
    base(2);
    handle(2);
    
    // Candle Holder
    translate([0,0,base_h-e]) {
        difference() {
            cylinder(d1=holder_d1+2*holder_t, d2=holder_d2+2*holder_t, h=holder_h);
            cylinder(d1=holder_d1, d2=holder_d2, h=holder_h+e);
        }
        translate([0,0,holder_h])
        rotate_extrude()
        translate([holder_d2/2+holder_t/2,0,0])
        circle(d=holder_t);
    }
}

module base(phase = 0)
{
    if ( phase==0 ) {
        // The very bottom is a straight cylinder, smaller that the base of the main cup
        // by the radius of the curvature
        cylinder(d=base_d1-2*base_r,h=base_r);
        translate([0,0,base_r]) {
            // the cone that forms the sides of the cup
            cylinder(h=base_h+rim_h-base_r, d1=base_d1,d2=base_d2);
            // rounding on the top of the cup cone
            translate([0,0,base_h+rim_h-base_r])
            rotate_extrude()
            translate([base_d2/2-rim_t/2,0,0])
            circle(d=rim_t);
        }
    // subtract
    } else if ( phase==1 ) {
        // The inside of the cup
        translate([0, 0, base_h])
            cylinder(h=rim_h+e,d2=base_d2-2*rim_t,
            d1=base_d1+(base_h/(base_h+rim_h))*(base_d2-base_d1)-2*rim_t);
    } else if ( phase==2 ) {
        // rounding on the bottom.  Not quite right because the think above it slopes outwards
        rotate_extrude()
        translate([base_d1/2-base_r,base_r,0])
        circle(r=base_r);
   }
}


// Handle
// the positioning is inexact.
module handle(phase=0)
{
    rotate([90,0]) {
        if ( phase == 0 ) {
            translate([0,handle_t/2,0])
            cube([base_d2/2+handle_od/2,
              min(handle_od/2,rim_h),
              handle_t]);
        } else if ( phase == 1 ) {
            translate([base_d2/2+handle_id/2+handle_t/2,handle_id/2+handle_t,-e]) {
                cylinder(d=handle_id+handle_t,h=handle_t+2*e);
            }
        } else if ( phase==2 ) {
            translate([base_d2/2+handle_id/2+handle_t/2,handle_id/2+handle_t,0])
            rotate_extrude()
            translate([(handle_id)/2+handle_t/2,handle_t/2,0])
            circle(d=handle_t);
             // curve on the bottom of the handle
            translate([base_d1/2-e-base_r,handle_t/2,handle_t/2])
            rotate([0,90,0])
            cylinder(d=handle_t,
            h=base_r+(base_d2-base_d1)/2+handle_id/2+handle_t/2);
       }
    }
}

