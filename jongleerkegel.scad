

points = [[4,0],[8,11],[2,25]];

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

rotate_extrude() polygon(bottlepoly);    