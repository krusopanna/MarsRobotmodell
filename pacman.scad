$fn = 60;

module pocok(pocok_magassag=8) {
    union() {
        cylinder(d=3.8, h=pocok_magassag);
        for(szog=[0, 90, 180, 270]) {
            rotate([0, 0, szog]) translate([1.85, -0.3, 0]) cube([0.4, 0.6, pocok_magassag]);
        }
    }
}

module pacman_jelveny(meret = 80, magassag = 4) {
    sugar = meret/2;
    union() {
        linear_extrude(height = magassag) {
            difference() {
                polygon([
                    [0,0],
                    for (szog = [45 : 1 : 315]) [ sugar*cos(szog), sugar*sin(szog) ]
                ]);
                translate([0, sugar*0.45]) circle(r = sugar*0.08);
            }
        }
        translate([-sugar*0.5, 0, 0]) {
            translate([0, 0, -2]) cylinder(d=12, h=2); 
            translate([0, 0, -10]) pocok(8);
        }
    }
}

pacman_jelveny();