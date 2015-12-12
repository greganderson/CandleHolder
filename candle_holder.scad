difference() {
	cylinder(10, 37, 37);
	translate([0, 0, 5]){cylinder(20, 30, 30);};
}

translate([-6, 47, 12]) {
	rotate([0, 90, 0])cylinder(12, 12, 12);
}

translate([-6, 30, 0]) {
	cube([12, 29, 11]);
}
