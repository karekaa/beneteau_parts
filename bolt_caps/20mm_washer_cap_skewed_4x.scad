// Program:  23_5_mm_washer_cap_skewed.scad
//
// Function: OpenSCAD program to define a plastic washer cap for
//           3D-print. The placement of the nut is skewed off
//           center for the washer.
//
// Author:   Kjell Arne Rekaa (kjell.arne.rekaa@gmail.com)
// 
// Date:     2024-05-23
// ======================================================================

// Speed up rendering - low resolution only for preview: 
$fn = $preview ? 32 : 90; 

count      = 4;      // Number of caps to 3D-print
hole_diam  = 10;     // Nut size hole
wash_size  = 23.5;   // Washer diameter in millimeter
distance   = 1.50;   // Distance factor between caps
wash_hight = 2.0;    // Hight for the wall around washer
cyl_thick  = 1.02;   // Cylinder wall thickness: 1.01 > 1.03
size  = wash_size + 1.5;
washer_thick = 0.4;  // Thickness of the whasher cap
nut_friction = 1.2;  // slack/friction for the nut hole

// **********************************************************************

// hexagon carving to fit on a nut or bolt head
module washer(size, height=wash_hight){
    translate([0,0,washer_thick]) cylinder(h=height, d=size);
}

// Produce "count" number of equal caps:
for (i = [1:1:count]) {
  translate([i*distance*wash_size,0,0]) {   
    difference() {
        difference(){
            cylinder(h=wash_hight, d=size*cyl_thick);
            washer(size, wash_hight+5);
        }
      translate([0.7+i/3,0,0]) // Skew the center a little more for each
      cylinder(h=wash_hight+3, d=hole_diam*nut_friction, $fn=6);
    }
  }
}