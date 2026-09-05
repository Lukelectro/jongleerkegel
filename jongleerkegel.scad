// Printable juggle club, in development / work in progress. Goal: a fuly parametric open source open hardware juggle pin. The world nees that like the open source violin XKCD jokes about (https://xkcd.com/743/). ;) :P

// standard juggle clubs are 52 cm and weight about 200 grams - 240 grams. Slim clubs spin faster. Shorter clubs spin faster. Lighter clubs spin faster. Kids clubs are shorter and wider and lighter, and do not spin faster

// So for a club that fits a standard backpack, it can be shorter, wider, and about the same weight

// Print parts seperately. TPU for knob/top (bottom puck), TPU or nylon for handle, XT copolyester or PETG for bottle (or maybe ABS - not tested), PLA or anything rigid for middlebit. 

// Middle bit length and infill can be tuned a bit to tune weight a bit. (fine tuning if dowel weight varies)

// Tune weight distribution by handlelength / bottleheigth // middle bit lenght/weight, etc

// Add a wooden dowel/rod through all (18 mm is a standard diameter in NL, at Praxis. Other countries idk)

// Assembly: Pre-drill screwhole in the ends of the dowel, use drilljig to center. Put bottom puck (top) on bottle and dowel in bottle, fixate with screw. Slide middlebit over dowel and center in bottle, glue with hotglue to bottle. Remove exces glue on outside. Slide handle over dowel and fixate by screwing knob on.

// See "how it is made" for Henry's delphin (circus expert visits their factory).

// Tune size to taste and printer limits

// I Printed "fitsbackpack" size to test
// handle in various materials, so far 0.7 mm vase mode Novamid 1030 nylon feels best. PETG and XT copolyster are too hard
// bottle is 2mm XT copolyester or PETG, not vase mode but regular print.
// Fitsbackpack center of gravity is slightly below handle end, in bottle. It weights about 180 a 190 grams and is about 43 cm long.
// -- LJPV 2026


// bottle height
BOTHEIGHT   = 230;     
// handle height. Total height is sum of bottle, handle, knob and puck - the amount the bottle is sunk into the puck and the amount the knob is sunk into the handle
HANDLEHEIGHT = 250;
// handle diameter, at the bottle end
HANDLEDIA_BOT = 35;
// Bottle diameter, at the handle end -- if I want to fit batteries/electronics into it, this needs to be somewhat wide, yet the handle should still be small-ish. So the middlering converts
BOTDIA_HANDLE = 45;

// handle diameter, at the knob end, must be equal or smaller then at the bottle end
HANDLEDIA_KNOB = 20;

// width of bottle (widest bit is slightly narrower then this. TODOWONTFIX)
BOTTLE_WIDTH = 75;
// bottom width (puck is slightly wider) (min size 15mm, but that is already ridiculously small)
BOTWIDTH = 35;
// bottom puck height (Minimum 10, because screw is inset 6, maximum 20-ish)
BOTPUCKH = 12;
//Diameter of top ball/knob
KNOBDIA = 35;          

//Diameter of wooden dowel (trough the middle over full length: BOTHEIGHT+HANDLEHEIGHT+MIDRING);
DOWELDIA = 18; // actually 18mm wood rod is slightly under, but if the printer overextrudes it still wo'nt fit, so maybe adjust this a bit
// "length" (width, but it is in the length direction of the club) of middle ring.
MIDRING = 8;

// middle bit length, to also tune weight, but do always keep at least 30 mm or so, because it needs to connect to the botle and handle.
MBL = 25; 
// wall thickness for printing. (In vase mode set this in slicer and put that value here too. In holow mode, set it here) -- todo: seems to be off / double? Fine, as 2 mm is better anyway (for a bottle - handle rather 0.7).
WALLTHICKNESS = 1; 


// printing tolerance. Holes that a printed part has to fit in are made larger by this amount.
TOL = 0.2; 

//screw to mount bottom puck and knob to the wooden dowel that passes throght the middle, diameter of screw
SD = 3.5;  
//diameter of screwhead
SHD = 6;

// holow or solid bottle/handle pieces? (solid to print in vase mode or hollow to print directly)
HOLLOW = true; 

//why are boolean check boxes not supported by thingiverse? Rather: Make this into another variable then...

// bottom thickness when hollow
BOTTH = 3;

// print which one? 0 = all, 1 = bottle, 2 = handle, 3 = puck, 4 = middlebit, 5= knob
PWW = 0; 

SPLODED = 1; // what distance for exploded view? (Set to 0 for assembled view, 10 or up for exploded view)

// style of bottle: 0= 3 piece clasic, 1= only curve, 2 = curve on top, 3 = curve on botom, 4 = no curve / lowpoly, 5 = equal sections, 6=middlebulb, 7 = custom
BOTSTYLE = 0; // [0:6]
 // limit choice in customizer panel: for a custom bottle edit the .scad
/*hidden*/

// A custom bottle can be defined in ways that don't work, there is no sanity checking, please use your own.

// Custom bottle style: heigth of lower cylinder
CBS_LOWCYLHEIGHT = 20;  
// Custom bottle style: heigth of upper cylinder
CBS_HIGHCYLHEIGHT = 20;  
//Custom bottle style: Diameter of connection to lower part of bulb
CBS_DIA1 = 20; 
//Custom bottle style: Diameter of connection to upper part of bulb
CBS_DIA2 = 20; 


if($preview){

%translate([0,0,BOTPUCKH-3+SPLODED]) bottle();
translate([0,0,BOTPUCKH-3+BOTHEIGHT+0.5*MIDRING+2*SPLODED]) middlebit(); //weight calibration piece in the middle
%translate([0,0,BOTPUCKH-3+BOTHEIGHT+MIDRING+3*SPLODED]) handle();
translate([0,0,BOTPUCKH-3+BOTHEIGHT+MIDRING+HANDLEHEIGHT+0.33*KNOBDIA+4*SPLODED]) knob();
bottompuck();
}
else
{
    if(PWW==0){
translate([BOTTLE_WIDTH,0,0]) bottle();
translate([BOTTLE_WIDTH*2,0,MBL/2]) middlebit(); //weight calibration piece in the middle
translate([BOTTLE_WIDTH*3,0,0]) handle();
translate([BOTTLE_WIDTH*4,0,0]) knob(); // TODO:raise to flat
bottompuck();
    }
        if(PWW==1){
translate([0,0,0]) bottle();
    }
        if(PWW==2){
translate([0,0,0]) handle();
    }
        if(PWW==3){
bottompuck();
    }
        if(PWW==4){
translate([0,0,MBL/2]) middlebit(); //weight calibration piece in the middle
    }
        if(PWW==5){
translate([0,0,0]) knob();
    }
}

// botom puck (Print in TPU with NO infill or low infill and no gap fill)
module bottompuck(){ // from playjuggling bumpers, modified
    $fs=0.5;
     SHH=2; //screw head height. +3 for inset
 difference(){
        union(){
        cylinder(d1=BOTWIDTH*1.1+BOTPUCKH/6,d2=BOTWIDTH*1.1,h=BOTPUCKH);
            //thin extra slice, for printability (else loose extrusions on the side)
            cylinder(d=BOTWIDTH*1.1+BOTPUCKH/1.5,h=0.4);
                        
        // buitenrand bumpers    
        for(i=[0:18:360]){ 
            rotate([0,0,i]) rotate_extrude(angle=9.5)
                union(){
                translate([1.1*BOTWIDTH/2+BOTPUCKH/2-1,BOTPUCKH/2]) difference() { 
                    circle(BOTPUCKH/2); 
                    circle((BOTPUCKH/2)-1); 
                    } ;
                 };
            }
        }
            cylinder(d=SD,h=BOTPUCKH); // schroefgat
        rotate_extrude(){
        polygon([[0,0],[0,SHH+3],[SHD/2,SHH+3],[SHD,0],[0,0]]); // sunk screwhole
        polygon([[0,BOTPUCKH],[1+BOTWIDTH/2,BOTPUCKH],[0.5*TOL+BOTWIDTH/2,BOTPUCKH-3],[0,BOTPUCKH-3]]);//sunk bottle 
        }
            // holes for more flexibility:
        for(i=[0:36:360]){
            rotate([0,-10,(i+18)]) translate([BOTWIDTH/3.5,0,-5]) cylinder(d1=BOTWIDTH/6.5,d2=BOTWIDTH/8,h=BOTPUCKH+5);
            rotate([0,-10,i]) translate([BOTWIDTH/2.2,0,-5]) cylinder(d1=BOTWIDTH/5, d2=(BOTWIDTH/5)-4,h=BOTPUCKH+5);
             rotate([0,-10,i+18]) translate([BOTWIDTH/2,0,-10]) cylinder(d=BOTWIDTH/12,h=BOTPUCKH+5);
        }        
        
        }
}
    
    module knob(){
         SHH=6; //SHH=screw head height. *2 is inset. Leave at 5 or 6 or so.
        difference(){
        sphere(d=KNOBDIA);
        translate([0,0,-0.5*KNOBDIA-1]) cylinder(d=SD,h=KNOBDIA+2);
        translate([0,0,0.5*KNOBDIA-(2*SHH)]) cylinder(d1=SHD,d2=SHD+2,h=SHH*4);
        translate([0,0,-0.5*KNOBDIA]) cylinder(d1=HANDLEDIA_KNOB+1,d2=HANDLEDIA_KNOB+TOL/2,h=8);    
            }
        }
        
module middlebit(){
    // eigenlijk een cilinder, die de stok in het midden opvult tot de fles en het handvat, en in het midden wat dikker is zodat 'ie blijft zitten
    difference(){
        union(){
        //2x WT, there is a wall each side.
        translate([0,0,MIDRING/2]) cylinder(d1=HANDLEDIA_BOT-2*TOL - 2*WALLTHICKNESS, d2=(HANDLEDIA_BOT-2*TOL-2*WALLTHICKNESS)-(0.5*MBL*(HANDLEDIA_BOT-HANDLEDIA_KNOB)/HANDLEHEIGHT)-4*TOL , h=MBL/2-MIDRING/2);// something with slope and distance, and a bit of extra tolerance at the top
        translate([0,0,-MBL/2]) cylinder(d2=BOTDIA_HANDLE-TOL - 2*WALLTHICKNESS, d1=(BOTDIA_HANDLE-TOL-2*WALLTHICKNESS)*0.8, h=MBL/2-MIDRING/2);
        //Middle bit is 1 wallthickness thicker again on both sides. So it protrudes by one WT from the bottle and handle.
        translate([0,0,-MIDRING/2]) cylinder(d1=BOTDIA_HANDLE+2*WALLTHICKNESS,d2=HANDLEDIA_BOT+2*WALLTHICKNESS, h=MIDRING);
            }
        translate([0,0,-MBL/2-1]) cylinder(d=DOWELDIA+TOL,h=MBL+2);
        }
    }
         
 module bottle(){
     // This botle looks more like a juggle club bottle: 2 cones and a curved bit in the middle conecting them. Other option would be just the curved bit, but longer.

// do not change below, these are calculated from total height
// or maybe tune them a bit to tune center of gravity, but make sure the total is still OK
// Orr... change style with global parameter in customizer!

//conditional on bottle style:
//HC1 is height of lower cylinder
HC1 = BOTSTYLE==1? 0
    : BOTSTYLE==2? BOTHEIGHT/2
    : BOTSTYLE==3? 0
    : BOTSTYLE==4? BOTHEIGHT/2
    : BOTSTYLE==5? BOTHEIGHT/3
    : BOTSTYLE==6? BOTHEIGHT/3
    : BOTSTYLE==7? CBS_LOWCYLHEIGHT
    : BOTHEIGHT/3; // default / bottle style 0

// HC2 is height of upper cylinder     
HC2 = BOTSTYLE==1? 0
    : BOTSTYLE==2? 0
    : BOTSTYLE==3? BOTHEIGHT/2
    : BOTSTYLE==4? BOTHEIGHT/2
    : BOTSTYLE==5? BOTHEIGHT/3
    : BOTSTYLE==6? BOTHEIGHT/3
    : BOTSTYLE==7? CBS_HIGHCYLHEIGHT
    : BOTHEIGHT/2;
     
//DIA1 is diameter of bottom end of curvy bit
DIA1 = BOTSTYLE==1? BOTWIDTH
     : BOTSTYLE==2? BOTTLE_WIDTH-5
     : BOTSTYLE==3? BOTWIDTH    
     : BOTSTYLE==4? BOTTLE_WIDTH
     : BOTSTYLE==5? BOTTLE_WIDTH-5
     : BOTSTYLE==6? HANDLEDIA_BOT
     : BOTSTYLE==7? CBS_DIA1
     : BOTTLE_WIDTH-5;
     
//DIA2 is diameter of top end of curvy bit
DIA2 = BOTSTYLE==1? BOTDIA_HANDLE
     : BOTSTYLE==2? BOTDIA_HANDLE
     : BOTSTYLE==3? BOTTLE_WIDTH-5
     : BOTSTYLE==4? BOTTLE_WIDTH
     : BOTSTYLE==5? BOTTLE_WIDTH-5
     : BOTSTYLE==6? BOTWIDTH
     : BOTSTYLE==7? CBS_DIA2
     : BOTTLE_WIDTH-5;   

HBB=BOTHEIGHT-HC1-HC2;  // Height of curvy bit in the middle of the bottle is what remains after HC1 and HC2 have been substrated from total heigth of bottle, in all styles.

        

points = [[DIA1/2,0+HC1],[BOTTLE_WIDTH/2,HC1+HBB/2],[DIA2/2,HC1+HBB]];

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

bottlepoly = concat ([[0,0],[BOTWIDTH/2,0]],curvepoints,[[BOTDIA_HANDLE/2,BOTHEIGHT],[0,BOTHEIGHT]]);

difference(){
    
    // TODO: now bottlepoly containts the full 2d shape of the bottle, it can be made hollow as well, so there is no need to specify vase mode printing (while vase mode printing remains possible still)

if(HOLLOW){
    rotate_extrude(angle=360){
    difference(){ 
    polygon(bottlepoly);
    offset(-WALLTHICKNESS) polygon(bottlepoly);
    translate([-WALLTHICKNESS,BOTHEIGHT-WALLTHICKNESS*2]) square([BOTDIA_HANDLE/2,WALLTHICKNESS*3]);
    translate([-WALLTHICKNESS,WALLTHICKNESS]) square([WALLTHICKNESS*3,BOTHEIGHT]);
    }
    polygon([[BOTWIDTH/2+WALLTHICKNESS*0.8,6],[BOTWIDTH/2,0],[BOTWIDTH/2-7,0]]); // strengthen edge
    }
    cylinder(d=BOTWIDTH,h=BOTTH); // solid bottom
    }else
    {
    rotate_extrude() polygon(bottlepoly);    
    }
    translate([0,0,-0.1]) cylinder(d=SD,h=10); // screw hole for botom / puck. (in vase mode botom 2 or 3 mm or so should be solid, but maybe 5 mm or so, hence 10 mm for screwhole)
}
}

module handle(){
    if (HOLLOW){
    rotate_extrude() polygon([[0,0],[HANDLEDIA_BOT/2,0],[HANDLEDIA_KNOB/2,HANDLEHEIGHT],[HANDLEDIA_KNOB/2-WALLTHICKNESS,HANDLEHEIGHT],[HANDLEDIA_BOT/2-WALLTHICKNESS,0]]);

} else
cylinder(d1=HANDLEDIA_BOT,d2=HANDLEDIA_KNOB,h=HANDLEHEIGHT);
}
//test fit:
     *%cylinder(d=BOTTLE_WIDTH,h=1234);
    
// output
RODLENGTH = BOTHEIGHT+HANDLEHEIGHT+MIDRING-BOTTH; // lengte van stok
TOTALLENGTH = BOTHEIGHT+HANDLEHEIGHT+MIDRING+BOTPUCKH-3+KNOBDIA-8  ;    // totale lengte (-3 sunk bottle, -8 sunk handle)
echo (str("Length of wooden dowel = ", RODLENGTH));
echo (str("Total lenght or juggle club = ", TOTALLENGTH));