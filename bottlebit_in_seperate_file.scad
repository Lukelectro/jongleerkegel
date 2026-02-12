// Body of a juggle club: 2 cones (blue and red) and a curve in the middle (green). Could also be a bottle.

HEIGTH = 260;   // total height of bottle (100-350 ish, default 260)
DIA0 = 50;      // diameter at bottom
DIA1 = 70;      // diameter at beginning of curvy bit
BULBYBIT=75/2;  // (target) radius of bulby bit (not exact)
DIA2 = 70;      // diameter at top of bulby but
DIA3 = 25;      // diameter at top of bottle / start of handle

// do not change below, these are calculated from total height
HC1=HEIGTH/3;   
HC2=HEIGTH/2;
HBB=HEIGTH-HC1-HC2;


points = [[DIA1/2,0],[BULBYBIT,HBB/2],[DIA2/2,HBB]];

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


color("red") cylinder(d1=DIA0,d2=DIA1,h=HC1);

color("green")  translate([0,0,HC1]) rotate_extrude() polygon(bottlepoly);    

color("blue") translate([0,0,HC1+HBB]) cylinder(d1=DIA2,d2=DIA3,h=HC2);