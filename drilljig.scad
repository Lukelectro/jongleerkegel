// jig om precies in het midden van een 18mm rond hout een gaatje te boren van 2.5 mm
// jig to dril a 2.5mm hole in the middle of a 18 mm round wood staff/stick

difference(){
    union(){
    cylinder (d=20,h=5);
    translate([0,0,4.8]) cylinder(d=8,h=25);
    }
    translate([0,0,-1]) cylinder(d=3.5,h=35,$fn=16);
    translate([0,0,-1]) cylinder(d=18.1,h=3);
    }