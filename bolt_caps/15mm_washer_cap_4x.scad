// Program:    15mm_washer_cap.scad
//
// Function: OpenSCAD program to define a plastic washer cap for
//           3D-print.
//
// Author:   Kjell Arne Rekaa (kjell.arne.rekaa@gmail.com)
// 
// Date:     2024-05-18
// ======================================================================

// Speed up rendering - low resolution only for preview: 
$fn = $preview ? 32 : 90; 

count      = 4;              // Number of caps
hole_diam  = 8;
wash_size  = 14.7;           // Washer size in millimeter
wash_size  = 10.0;           // Washer size in millimeter
distance   = 1.50;           // Distance factor between caps
wash_hight  = 2.9;           // Hight for the nut/bolt head
friction   = 1.170;          // Friction factor. Higher: less friction
cyl_thick  = 1.18;           // Cylinder thickness: 1.28 > 1.30
size = wash_size * friction; // Will give right friction


// hexagon carving to fit on a nut or bolt head
module washer(size, height=wash_hight){
    cylinder(h=height, d=size/cos(180/6),center=true, $fn=32);
}

// Produce "count" number of equal caps:
for (i = [1:1:count]) {
  translate([i*distance*wash_size,0,0]) {   
    difference() {
      union() {
        difference(){
            cylinder(h=wash_hight, d=size*cyl_thick);
            washer(size, wash_hight+5);
        }
        cylinder(h=wash_hight-2.5, d=size*cyl_thick);
      }
    cylinder(h=wash_hight+6, d=hole_diam*friction, $fn=6);
    }
  }
}