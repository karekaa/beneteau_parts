// Program:    hex_nut_cap.scad
//
// Function: Program to define a plastic cap for
//           M6, M10 and M13 bolt nuts for 3D print.
//
// Author:   Kjell Arne Rekaa (kjell.arne.rekaa@gmail.com)
// 
// Date:     2024-05-13
// ======================================================================

// Speed up rendering - low resolution only for preview: 
$fn = $preview ? 32 : 90; 

nut_size   = 10;            // Bolt size in millimeter

count      = 10;             // Number of caps
distance   = 1.29;          // Distance factor between caps
cup_factor = 1.50;          // Factor for reducing the cup dome
thickness  = 0.90;          // Dome thickness factor. Less is thinner.
dome_hight = 10.5;          // High: 6.5;  Low: 10.5
nut_hight  = nut_size/2.59; // Hight for the nut/bolt head
friction   = 1.125;         // Added room for right friction

nut_s = nut_size * friction; // Will give right friction
cup_r = nut_size/cup_factor; // cup/dome radius


// hexagon carving to fit on a nut or bolt head
module m_nut(size, height=nut_hight){
    cylinder(h=height, d=size/cos(180/6),center=true, $fn=6);
}


for (i = [1:1:count]) {
    translate([i*distance*nut_s,0,0]) { 
  
    // minkowski-rounding of the edges:
    minkowski() {
        difference(){
            cylinder(h=nut_hight, d=nut_size*1.3, 
            center=true);
            m_nut(nut_s, nut_hight);
        }
       // minkowski rounding factor:
       sphere (nut_size/20);
    }
    
    // Make the spheric half dome cover:
    translate([0,0,nut_size/dome_hight]) { 
        difference () {
            sphere(cup_r);
            sphere(cup_r*thickness);
            
            //Remove bottom half of the «marble»:
            translate([0,0,-cup_r]) {
               cube(cup_r*2, center=true);
            }
        }
    }
}
}