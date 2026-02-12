// dit is een kladversie van een jongleerkegel - nog niet printbaar.

// Note/idea: 
// print all parts seperately, bottle and neck in vase mode. (In something sturdy but with some give. PETG perhaps? TPU for the handle?)
// Bottle needs a solid botom, neck perhaps a solid bit at the top.
// Add a bumper to the bottom and the knob. (printed in TPU or other soft material)
// Use a calibration piece in the middle between bottle and neck, weight calibration. Printed in PETG? Does not need to be soft, needs some weight.
// Add a wooden dowel/rod through all (18 mm is een standaard diameter bij praxis, maar ik weet niet welke diameter er in het origineel zit. Op het oog zou het kunnen)

// Idee: de puck op de onderkant kan ook op mijn huidige kegels, al veranderd dan het gewicht en het zwaartepunt. Zwaartepunt is corrigeerbaar door ook de handle te wrappen en/of knop te verzwaren. Dan wordt wel de hele kegel zwaarder... Of ik zou de puck heel licht moeten maken (Weinig infill, 2 outer shells ipv 3)

// See "how it is made" for Henry's delphin (circus expert visits their factory).

//  How does the calibration middle piece work? Infill for more or less weight? addable weight? -- How about a longer piece for more weight, if more infill does not cut it?
// Also: how to assemble? Middle bit to wooden dowel (glue?) and bottle/handle (it is locked in since both ends are fixed to the dowel by a screw through the knob and bottom puck. So a bit of (colored?) tape over it should be enough)

// Hah. Make it into a fuly parametric open source open hardware juggle pin :P like the open source violin XKCD jokes about. With a Height and a BOTTLEWIDTH etc.

// TODO:
// * maybe pre-calculate weight distribution somehow? Saves on printing, but difficult. (And weight distr. can be changed with knob, puck, and middle bit, withouth re-printing the large bits)
// * tune size to printer limits (250 height is too much for my home printer, could maybe use the UM2+ extended at the makerspace (Zmax 305)?)
// * iets om los de onderdelen als stls te exporteren, ipv alles ineens
// * misschien settings voor preview en render verschillend, preview de exploded view en render de (gekozen) printbare onderdelen.
// *TODO: Fles en handvat toch ook hol maken (Offset), want dan hoeft het niet per se in vase mode.abs
// *TODO: kleiner schaalmodel printen, dan kan het met foto op printables als work in progress én krijg ik er een beetje gevoel voor. Schaalmodel kan een stukje draadeind of kleiner houtje als dowel middendoor? Of zelfs een lange schroef?


BOTHEIGHT   = 250;      // bottle height
HANDLEHEIGHT = 250;     // handle height. Total height is sum of bottle, handle, knob and puck - the amount the bottle is sunk into the puck and the amount the knob is sunk into the handle
HANDLEDIA_BOT = 30;    // handle diameter, at the bottle end
HANDLEDIA_KNOB = 20;   // handle diameter, at the knob end
BOTTLE_WIDTH = 75;     // width of bottle (widest bit is slightly narrower then this. TODOWONTFIX)
BOTWIDTH = 35;         // bottom width (puck is slightly wider) (min size 15mm, but that is already ridiculously small)
BOTPUCKH = 15;         // bottom puck height
KNOBDIA = 31;          // diameter knob

DOWELDIA = 18;          // diameter of wooden dowel
MIDRING = 5;            // length of middle ring.
MBL = 40; // middle bit length, to also tune weight, but do always keep at least 30 mm or so, because it needs to connect to the botle and handle.
//saw wooden dowel to length BOTHEIGHT+HANDLEHEIGHT+MIDRING
WALLTHICKNESS = 1; // wall thickness for printing. (still needed of middle bit when priting solid)
TOL = 0.2; // printing tolerance. Holes that a printed part has to fit in are made larger by this amout.

//screw to mount bottom puck and knob to the wooden dowel that passes throght the middle
  SD = 3;  // screw dia
  SHD = 6; // screw head dia
  SHH = 5; // screw head height. It is inset to 2x this height (so, if it is a flat head screw maybe overstate this, so it is inset enough. Or TODO change this var to mean inset...)

HOLLOW = true; // holow or solid bottle/handle pieces? (solid to print in vase mode or hollow to print directly)
BOTTH = 3; // bottom thickness when hollow

PWW = 0; // print which one? 0 = all, 1 = bottle, 2 = handle, 3 = puck, 4 = middlebit, 5= knob

if($preview){
translate([0,0,BOTPUCKH*2]) bottle();
translate([0,0,BOTPUCKH*2+BOTHEIGHT+MBL]) middlebit(); //weight calibration piece in the middle
translate([0,0,BOTPUCKH*2+BOTHEIGHT+MBL+MBL]) handle();
translate([0,0,BOTPUCKH*2+BOTHEIGHT+MBL+MBL+HANDLEHEIGHT+KNOBDIA*0.75]) knob();
bottompuck();
}
else
{
    if(PWW==0){
translate([BOTTLE_WIDTH,0,0]) bottle();
translate([BOTTLE_WIDTH*2,0,0]) middlebit(); //weight calibration piece in the middle
translate([BOTTLE_WIDTH*3,0,0]) handle();
translate([BOTTLE_WIDTH*4,0,0]) knob();
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
translate([0,0,0]) middlebit(); //weight calibration piece in the middle
    }
        if(PWW==5){
translate([0,0,0]) knob();
    }
}

// botom puck:
module bottompuck(){
rotate_extrude()
difference(){
    union(){
        translate([SD/2,0,0]) // 1.5 because 3mm screw
        square([(BOTWIDTH-SD)/2, BOTPUCKH]); // 1.5 because 3mm screw
        translate([BOTWIDTH/2,BOTPUCKH/2]) circle(BOTPUCKH/2);
        }
        polygon([[0,0],[0,SHH*2],[SHD/2,SHH*2],[SHD,0],[0,0]]); // sunk screwhole
        polygon([[0,BOTPUCKH],[1+BOTWIDTH/2,BOTPUCKH],[0.5*TOL+BOTWIDTH/2,BOTPUCKH-3],[0,BOTPUCKH-3]]); // #square([BOTWIDTH-SD/2,3]); // sunk hole for bottom of bottle
    }
}
    
    module knob(){
        difference(){
        sphere(d=KNOBDIA);
        translate([0,0,-0.5*KNOBDIA-1]) cylinder(d=SD,h=KNOBDIA+2);
        translate([0,0,0.5*KNOBDIA-(2*SHH)]) cylinder(d1=SHD,d2=SHD+2,h=SHH*4);
        translate([0,0,-0.5*KNOBDIA]) cylinder(d1=HANDLEDIA_KNOB+1,d2=HANDLEDIA_KNOB+TOL/2,h=5);    
            }
        }
        
module middlebit(){
    // eigenlijk een cilinder, die de stok in het midden opvult tot de fles en het handvat, en in het midden wat dikker is zodat 'ie blijft zitten
    difference(){
        union(){
        //2x WT, there is a wall each side.
        translate([0,0,-MBL/2]) cylinder(d=HANDLEDIA_BOT-TOL - 2*WALLTHICKNESS, h=MBL);
        //Middle bit is 1 wallthickness thicker again on both sides. So it protrudes by one WT from the bottle and handle.
        translate([0,0,-MIDRING/2]) cylinder(d=HANDLEDIA_BOT+2*WALLTHICKNESS, h=MIDRING);
            }
        translate([0,0,-MBL/2-1]) cylinder(d=DOWELDIA+TOL,h=MBL+2);
        }
    }
         
 module bottle(){
     // This botle looks more like a juggle club bottle: 2 cones and a curved bit in the middle conecting them. Other option would be just the curved bit, but longer.

DIA1 = BOTTLE_WIDTH-5;      // diameter at beginning of curvy bit
DIA2 = BOTTLE_WIDTH-5;      // diameter at top of bulby bit

// do not change below, these are calculated from total height
     // or mayeb tune them a bit to tune center of gravity, but make sure the total is still OK
HC1=BOTHEIGHT/3;   // Height of lower cylinder 
HC2=BOTHEIGHT/2;   // Height of upper cylinder
HBB=BOTHEIGHT-HC1-HC2;  // remaining height is height of curvy bulby bit


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

bottlepoly = concat ([[0,0],[BOTWIDTH/2,0]],curvepoints,[[HANDLEDIA_BOT/2,BOTHEIGHT],[0,BOTHEIGHT]]);

difference(){
    
    // TODO: now bottlepoly containts the full 2d shape of the bottle, it can be made hollow as well, so there is no need to specify vase mode printing (while vase mode printing remains possible still)

if(HOLLOW){
    rotate_extrude()
    difference(){ 
    polygon(bottlepoly);
    offset(-WALLTHICKNESS) polygon(bottlepoly);
    translate([-WALLTHICKNESS,BOTHEIGHT-WALLTHICKNESS*2]) square([HANDLEDIA_BOT/2,WALLTHICKNESS*3]);
    translate([-WALLTHICKNESS,WALLTHICKNESS]) square([WALLTHICKNESS*3,BOTHEIGHT]);
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
    rotate_extrude() #polygon([[0,0],[HANDLEDIA_BOT/2,0],[HANDLEDIA_KNOB/2,HANDLEHEIGHT],[HANDLEDIA_KNOB/2-WALLTHICKNESS,HANDLEHEIGHT],[HANDLEDIA_BOT/2-WALLTHICKNESS,0]]);

} else
cylinder(d1=HANDLEDIA_BOT,d2=HANDLEDIA_KNOB,h=HANDLEHEIGHT);
}
//test fit:
     *%cylinder(d=BOTTLE_WIDTH,h=1234);
    