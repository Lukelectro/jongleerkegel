// dit is een kladversie van een jongleerkegel
// Note/idea: print all parts seperately, bottle and neck in vase mode.
// Add a bumper to the bottom and the knob. (TPU or other soft material)
// Use a calibration piece in the middle between bottle and neck, weight calibration.
// Add a wooden dowel/rod through all (18 mm is een standaard diameter bij praxis, maar ik weet niet welke diameter er in het origineel zit. Op het oog zou het kunnen)

// See "how it is made" for Henry's delphin (circus expert visits their factory).

// TODO: how will the calibration middle piece work? Infill for more or less weight? addable weight? What shape should it have: It should fit around the wouden dowel, but into both handle and bottle, and maybe extend in the middle

// TODO: maybe a 3-part bottle, like the variant.scad? 2 cones and a bulby bit in the middle.

// Hah. Make it into a fuly parametric open source open hardware juggle pin :P like the open source violin XKCD jokes about. With a Height and a BOTTLEWIDTH etc.

BOTHEIGHT   = 250;      // bottle height
HANDLEHEIGHT = 250;     // handle height. Total height is sum of bottle, handle, knob and puck - the amount the bottle is sunk into the puck and the amount the knob is sunk into the handle
HANDLEDIA_BOT = 40;    // handle diameter, at the bottle end
HANDLEDIA_KNOB = 20;   // handle diameter, at the knob end
CurveHeight = 110;     // not exact: how hight is the wide point on the bottle
CurveWidthFactor = 80; // not an exact measurement, width of bottle
BOTWIDTH = 80;         // bottom width (puck is slightly wider)
BOTPUCKH = 25;         // bottom puck height
KNOBDIA = 45;          // diameter knob

WALLTHICKNESS = 1; // wall thickness for printing. Is needed to calculated fit of middle bit.

//screw to mount bottom puck and knob to the wooden dowel that passes throght the middle
  SD = 3;  // screw dia
  SHD = 6; // screw head dia
  SHH = 5; // screw head height. It is inset to 3x height



points = [[BOTWIDTH/2,0],[CurveWidthFactor,CurveHeight],[HANDLEDIA_BOT/2,BOTHEIGHT]];

curvepoints = [for (i=[0:0.05:1]) bezier(points,i) ];

// Quadratic Bezier curve rastering
// Aart 09-2018 Aartsite.nl
    function bezier (P,t) =
        let(
                x1 = P[0][0] + (( P[1][0] - P[0][0]) *t),
                y1 = P[0][1] + (( P[1][1] - P[0][1]) *t),
                x2 = P[1][0] + (( P[2][0] - P[1][0]) *t),
                y2 = P[1][1] + (( P[2][1] - P[1][1]) *t),
                x=x1+((x2-x1)*t),
                y=y1+((y2-y1)*t)
                ) ([x,y]);

bottlepoly = concat ([[0,0]],curvepoints,[[0,points[2][1]]] ); // TODO: iets om uit de "points" list de begin en eindpunten te halen, maar dan tegen 0 aan. Dus zegmaar points[2][1] oid
echo (bottlepoly);

echo(points[2][1]); // zo dus

translate([0,0,30]) rotate_extrude() polygon(bottlepoly);

translate([0,0,310]) middlebit(); //weight calibration piece in the middle

translate([0,0,340]) cylinder(d1=HANDLEDIA_BOT,d2=HANDLEDIA_KNOB,h=HANDLEHEIGHT);

translate([0,0,620]) knob();

// botom puck wil also be a rotate_extrude
rotate_extrude()
difference(){
    union(){
        translate([SD/2,0,0]) // 1.5 because 3mm screw
        square([(BOTWIDTH-SD)/2, BOTPUCKH]); // 1.5 because 3mm screw
        translate([BOTWIDTH/2,BOTPUCKH/2]) circle(BOTPUCKH/2);
        }
        polygon([[0,0],[0,SHH*3],[SHD/2,SHH*3],[SHD,0],[0,0]]); // sunk screwhole
        polygon([[0,BOTPUCKH],[1+BOTWIDTH/2,BOTPUCKH],[BOTWIDTH/2,BOTPUCKH-3],[0,BOTPUCKH-3]]); // #square([BOTWIDTH-SD/2,3]); // sunk hole for bottom of bottle
    }
    
    module knob(){
        difference(){
        sphere(d=KNOBDIA);
        translate([0,0,-0.5*KNOBDIA-1]) cylinder(d=SD,h=KNOBDIA+2);
        translate([0,0,0.5*KNOBDIA-(3*SHH)]) cylinder(d1=SHD,d2=SHD+2,h=SHH*4);
        translate([0,0,-0.5*KNOBDIA]) cylinder(d1=HANDLEDIA_KNOB+1,d2=HANDLEDIA_KNOB,h=5);    
            }
        }
        
module middlebit(){
    // eigenlijk een cilinderd, die de stok in het midden opvult tot de fles en het handvat, en in het midden wat dikker is.
    difference(){
        union(){
        cylinder(d=HANDLEDIA_BOT - WALLTHICKNESS, h=20);
        translate([0,0,-20]) cylinder(d=HANDLEDIA_BOT - WALLTHICKNESS, h=20);
        translate([0,0,-5]) cylinder(d=HANDLEDIA_BOT+1, h=10);
            }
        cylinder(d=18,h=123);
        }
    }
            