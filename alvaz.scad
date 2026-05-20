$fn = 60;
 
vaz_hossz = 160;            
vaz_szelesseg_veg = 120;    
vaz_szelesseg_kozep = 80;   
vaz_vastagsag = 3;          

perem_magassag = 6;
perem_vastagsag = 2;
 
rfm_x = 40;   rfm_y = 25;   
mx_x = 26;    mx_y = 22;    
stm_x = 55;   stm_y = 65;   
akku_x = 45;  akku_y = 25;  
 
n20_szelesseg = 12.2; 
n20_magassag = 10.2;  
n20_hossz = 26;               
 
module folyamatos_ful() {
    cube([1.5, 6, 3], center=true); 
    translate([0.5, 0, 1.5]) cube([1, 6, 1], center=true); 
}
 
module alap_kontur_2d() {
    polygon(points=[
        [30,  80], [60,  50], [60,  25], [40,  15], 
        [40, -15], [60, -25], [60, -50], [30, -80], 
        [-30, -80], [-60, -50], [-60, -25], [-40, -15], 
        [-40,  15], [-60,  25], [-60,  50], [-30,  80]
    ]);
}

module robot_alapvaz() {
    union() {
        linear_extrude(height = vaz_vastagsag, center = false) {
            alap_kontur_2d();
        }
        
        linear_extrude(height = perem_magassag, center = false) {
            difference() {
                minkowski() {
                    alap_kontur_2d();
                    circle(r = perem_vastagsag/2);
                }
                alap_kontur_2d();
            }
        }
    }
}
 
module n20_pattintos_tarto() {
    difference() {
        translate([0, 0, (n20_magassag+2)/2])
            cube([n20_szelesseg + 5, n20_hossz + 4, n20_magassag + 2], center=true);
        
        translate([0, 0, n20_magassag/2 + 2])
            cube([n20_szelesseg, n20_hossz + 0.2, n20_magassag + 1], center=true);
        
        translate([0, n20_hossz/2, n20_magassag/2 + 2])
            cube([6, 10, n20_magassag + 5], center=true);
            
        translate([0, -n20_hossz/2 - 1, (n20_magassag + 5)/2])
            cube([6, 5, n20_magassag + 5], center=true);
    }
    
    translate([-n20_szelesseg/2 - 1.5, -n20_hossz/2 + 2, n20_magassag + 1])
        folyamatos_ful();
        
    mirror([1,0,0])
    translate([-n20_szelesseg/2 - 1.5, -n20_hossz/2 + 2, n20_magassag + 1])
        folyamatos_ful();
}
 
module tavtarto_bak() {
    difference() {
        cylinder(d=5.5, h=5);
        translate([0,0,-0.1]) cylinder(d=2.4, h=5.2);
    }
}

difference() {
    union() {
        robot_alapvaz();

        // Első motorok 
        translate([46, 37.5, vaz_vastagsag]) rotate([0,0,-90]) n20_pattintos_tarto();
        translate([-46, 37.5, vaz_vastagsag]) rotate([0,0,90]) n20_pattintos_tarto();

        // Hátsó motorok
        translate([46, -37.5, vaz_vastagsag]) rotate([0,0,-90]) n20_pattintos_tarto();
        translate([-46, -37.5, vaz_vastagsag]) rotate([0,0,90]) n20_pattintos_tarto();
        
        // Távtartó bakok
        y_off = -32;
        
        translate([ 15.24, 50.8 + y_off, vaz_vastagsag]) tavtarto_bak();
        translate([ 17.78,  0.0 + y_off, vaz_vastagsag]) tavtarto_bak();
        translate([-33.02, 15.24 + y_off, vaz_vastagsag]) tavtarto_bak();
        
    }

    // Elektronikák
    z_sullyesztes = vaz_vastagsag - 1.2;
    
    // 1. RFM95W helye
    translate([0, 65, z_sullyesztes]) cube([rfm_x, rfm_y, 2.5], center=true);

    // 2. MX1616-M motorvezérlő helye
    translate([0, 38, z_sullyesztes]) cube([mx_x, mx_y, 2.5], center=true);
    
    // 3. Akkumulátor helye
    translate([0, -65, z_sullyesztes]) cube([akku_x, akku_y, 2.5], center=true);
    
    translate([ 39, 0, perem_magassag - 1]) cube([3, 14, 3], center=true);
    translate([-39, 0, perem_magassag - 1]) cube([3, 14, 3], center=true);
}

color("red", 0.8) {
    
    // 1. RFM95W modul kiemelése
    translate([0, 65, 1.8 + 0.5]) cube([rfm_x, rfm_y, 1], center=true);
}

color("green", 0.8) {
    
    // 2. MX1616-M motorvezérlő kiemelése
    translate([0, 38, 1.8 + 0.5]) cube([mx_x, mx_y, 1], center=true);
}
    
color("blue", 0.8) {  
    
    // 3. Akkumulátor fészkének kiemelése
    translate([0, -65, 1.8 + 0.5]) cube([akku_x, akku_y, 1], center=true);
}