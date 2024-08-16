// ======================================================================
// Program:    cup_holder_Beneteau_Oceanis.scad
//
// Function: OpenSCAD program to define a cup holder to mount on
//           the instrument pole in the cockpit of the sailboat.
//
// Author:   Kjell Arne Rekaa (kjell.arne.rekaa@gmail.com)
// 
// Date:     2024-07-23
// ======================================================================
// Speed up rendering - low resolution only for preview: 
$fn = $preview ? 90 : 190; 

// Variabler: *******************************************************
mink_dia =   3; // Minkowski diameter for rounding edges
f_thick  =   2; // The bottom fundation to glue or screw in place
f_size   = 100; // The fundation width and length (square)
f_angle  =  12; // Degree tilt, which need to be straighten up
cup_d    =  80; // max cup diameter
cup_h    =  50; // hight of the cup holder
handle_w =  25; // The cup handle width

difference() {
    union() {
        // The thin fundament to glue at the top of fundament for the steering wheel:
        difference([]) {
           rotate([f_angle,0,0]) translate([f_size/2, f_size/2, -20]) 
           cylinder (cup_h, d=cup_d+f_thick);
           translate([0,0,2]) cube([f_size,f_size,70]);
           translate([0,0,-70]) cube([f_size,f_size,70]);
        }
        
        // The tilted hollow cylinder for holding the cup:
        rotate([f_angle,0,0]) translate([f_size/2, f_size/2, -20]) difference () {
          cylinder (cup_h, d=cup_d+f_thick);
          cylinder (cup_h+1, d=cup_d);
        }
        // Inner horizontal stand for the cup:
        rotate([f_angle,0,0]) translate([f_size/2, f_size/2, -(cup_h+4)])
          cylinder (cup_h, d=cup_d-20);
    }

    // Remove a slice for an handle on cups:
    rotate([f_angle,0,10]) translate([10, f_size/2+handle_w/2, f_thick]) 
    cube ([handle_w, handle_w, cup_h]); 

    // Remove the leftover of the tilted cylinder below the fundament: 
    translate ([0,0,-60]) cube([f_size, f_size, 60]);
    
    // Make hole for rain water to get out:
    translate([50,100,3]) rotate([90,0,0]) cylinder(20,3);
}