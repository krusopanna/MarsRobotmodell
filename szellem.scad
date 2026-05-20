$fn = 80;

module pocok(pocok_magassag=8) {
    union() {
        cylinder(d=3.8, h=pocok_magassag);
        for(szog=[0, 90, 180, 270]) {
            rotate([0, 0, szog]) translate([1.85, -0.3, 0]) cube([0.4, 0.6, pocok_magassag]);
        }
    }
}

module szellem_jelveny(meret = 80, magassag = 4) {
    szelesseg = meret;
    teljes_magassag = meret * 1.05; 
    test_magassag = teljes_magassag * 0.75;
    fej_sugar  = szelesseg/2;

    module szellem_kontur() {
        union() {
            translate([0, test_magassag/2]) circle(r = fej_sugar);
            translate([-szelesseg/2, -test_magassag/2]) square([szelesseg, test_magassag]);
            hullam_sugar = (szelesseg / 3) / 2;
            for (i = [-1, 0, 1]) {
                translate([i * (szelesseg/3), -test_magassag/2]) circle(r = hullam_sugar);
            }
        }
    }

    union() {
        linear_extrude(magassag) {
            difference() {
                szellem_kontur();
                translate([-szelesseg*0.2, test_magassag*0.25]) circle(r = szelesseg*0.12);
                translate([ szelesseg*0.2, test_magassag*0.25]) circle(r = szelesseg*0.12);
            }
        }
        
        translate([0, -test_magassag/2 + 15, magassag]) {
            translate([0, 0, 0]) cylinder(d=12, h=2);
            translate([0, 0, 2]) pocok(8);
        }
    }
}

szellem_jelveny();