$fn = 60;

vaz_hossz = 160;            
vaz_szelesseg_veg = 120;    
vaz_szelesseg_kozep = 80;
burkolat_magassag = 35;     
fal_vastagsag = 2;

module alap_kontur_2d() {
    polygon(points=[
        [30,  80], [60,  50], [60,  25], [40,  15], 
        [40, -15], [60, -25], [60, -50], [30, -80], 
        [-30, -80], [-60, -50], [-60, -25], [-40, -15], 
        [-40,  15], [-60,  25], [-60,  50], [-30,  80]
    ]);
}

module tomor_test() {
    
    linear_extrude(height = burkolat_magassag, scale = 0.85) {
        alap_kontur_2d();
    }
}

module ureges_burkolat_hej() {
    difference() {
        tomor_test();
        
        difference() {
            translate([0, 0, -1])
            linear_extrude(height = burkolat_magassag - fal_vastagsag + 1, scale = 0.85) {
                offset(r = -fal_vastagsag) { 
                    alap_kontur_2d(); 
                }
            }

            translate([46, 37.5, 8]) cube([40, 26, 22], center=true);
            translate([-46, 37.5, 8]) cube([40, 26, 22], center=true);
            translate([46, -37.5, 8]) cube([40, 26, 22], center=true);
            translate([-46, -37.5, 8]) cube([40, 26, 22], center=true);
        }
    }
}
module pattintos_fulek() {
    
    translate([40, 0, 0])
        rotate([90, 0, 0])
        linear_extrude(height=12, center=true) {
            
            polygon([[0, 0.6], [0.6, 1.5], [0.6, 3.4], [0, 3.4]]);
        }
        
    translate([-40, 0, 0])
        rotate([90, 0, 0])
        linear_extrude(height=12, center=true) {
            polygon([[0, 0.6], [-0.6, 1.5], [-0.6, 3.4], [0, 3.4]]);
        }
}

union() {
    difference() {
        ureges_burkolat_hej();
        
        // Kerekek helyének kivágása
        translate([46, 37.5, 8]) cube([35, 22, 18], center=true);
        translate([-46, 37.5, 8]) cube([35, 22, 18], center=true);
        translate([46, -37.5, 8]) cube([35, 22, 18], center=true);
        translate([-46, -37.5, 8]) cube([35, 22, 18], center=true);
            
        // Zászlótartó lyuk
        translate([0, -60, burkolat_magassag - 5]) 
            cylinder(d=4.2, h=10, center=true);
            
        // Kamera kábelének kivezetése
        translate([0, 50, burkolat_magassag - 5]) 
            cube([25, 4, 10], center=true);
        
        // Kamera rögzítőfuratok
            translate([12, 45, burkolat_magassag - 5]) cylinder(d=2.6, h=12, center=true);
            translate([-12, 45, burkolat_magassag - 5]) cylinder(d=2.6, h=12, center=true);
            
        // Infra LED furat
        translate([20, 50, burkolat_magassag - 5]) 
            cylinder(d=5.2, h=10, center=true);
    }
    
    pattintos_fulek();
}