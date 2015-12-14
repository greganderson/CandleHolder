// Base
difference() {
	cylinder(10, 37, 37);
	translate([0, 0, 5]){cylinder(20, 30, 30);};
}

// Handle
difference() {
	union() {
		translate([-4, 47, 12]) {
			rotate([0, 90, 0])cylinder(8, 12, 12);
		}

		translate([-4, 30, 0]) {
			cube([8, 29, 11]);
		}
	}
	translate([-7, 47, 12]) {
		rotate([0, 90, 0])cylinder(14, 9, 9);
	}
}

// Holder
difference() {
	translate([0, 0, 5])cylinder(30, 15, 15);
	translate([0, 0, 5])cylinder(30, 12, 12);
}
