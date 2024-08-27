// ======================================================================
// Program:  cup_holder_Beneteau_Oceanis.scad
//
// Function: 3D model in OpenSCAD to define a cup holder to mount on
//           the instrument pole in the cockpit of a sailboat.
//
// Author:   Kjell Arne Rekaa (kjell.arne.rekaa@gmail.com)
// 
// Date:     2024-07-23
// ======================================================================
// Speed up rendering - low resolution only for preview: 
$fn = $preview ? 90 : 190; 

// Settings: ************************************************************
mink_dia =   3; // Minkowski diameter for rounding edges
f_thick  =   3; // The bottom fundation to glue or screw in place
f_size   = 100; // The fundation width and length (square)
f_angle  =  12; // Degree tilt, which need to be straighten up
cup_d    =  85; // max cup diameter
cup_h    =  50; // hight of the cup holder
handle_w =  15; // The cup handle width
handle_h =  24; // handle opening hight

minkowski() {
difference() {
    union() {
        // The floor inside the cup holder:
        difference([]) {
           rotate([f_angle,0,0]) translate([f_size/2, f_size/2, -20]) 
           cylinder (cup_h, d=cup_d+f_thick);
           translate([0,0,2]) cube([f_size,f_size,70]);
           translate([0,0,-70]) cube([f_size,f_size,70]);
        }
        
        // The tilted hollow cylinder for holding the cup:
        rotate([f_angle,0,0]) translate([f_size/2, f_size/2, -20]) 
        difference () {
          cylinder (cup_h, d=cup_d+f_thick);
          cylinder (cup_h+1, d=cup_d);
        }
        // Inner horizontal stand for the cup:
        rotate([f_angle,0,0]) translate([f_size/2, f_size/2, -(cup_h+4)])
          cylinder (cup_h, d=cup_d-20);
    }
    

    // Remove a slice for giving room for handle on cups:
    // rotate([f_angle, 0, 10]) translate([19.4, f_size/2+handle_w/2, f_thick]) 
    // cube ([handle_w, handle_w, cup_h]);
        // TODO: Bytt cube() over, med en åpning med avrundede kanter
        *difference() {
            cube([handle_w, handle_w, 30]);
            cylinder(31, d=3);
        }
        *translate([12.4, f_size/2+handle_w/2, 45]) sphere(6);
        *translate([17.4, f_size/2+handle_w/2+10, 49]) sphere(6);
        // TODO END.


        // Shape to differ, shape round corners on the cup handle opening:
        rotate([f_angle, 0,12]) translate([19.4, f_size/2+handle_w/2, 9]) 
        difference() {
            union() {
                // cube:
                //translate([-20,0,0]) 
                cube([handle_w, handle_w, handle_h]);
                // 90 degree square extrude on top:
                //translate([-24,0,32]) cube([10,6,6]);
                translate([-2, 0, handle_h]) cube([8,6,6]);
                //union() {
                //  rotate([90, 0, 0]) rotate_extrude(angle=90, convexity=10) square(6,6);
                //}
            }
        
            rotate([0,0,90]) 
            union() {
                // Vertical cylinder:
                translate([1,3,0])
                cylinder (handle_h-2, d=4);
                // 90 degree bend on top:
                translate([-3,3,handle_h-4]) union() {
                    rotate([90, 0, 0]) rotate_extrude(angle=90, convexity=10) 
                    translate([4, 0, 0]) circle(r=2); 
                }
            }
        }


    // Remove the leftover of the tilted cylinder below the fundament: 
    translate ([0,0,-60]) cube([f_size, f_size, 60]);
    
    // Make hole for rain water to get out:
    translate([cup_h,f_size,3]) rotate([90,0,0]) cylinder(20,3);
}
}
