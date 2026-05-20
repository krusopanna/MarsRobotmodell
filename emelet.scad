$fn = 60;

talca_vastagsag = 2;    

raspi_dx = 49.0;
raspi_dy = 58.0;

module talca_alap_2d() {
    hull() {
       
        translate([ raspi_dx/2,  raspi_dy/2]) circle(r=5);
        translate([-raspi_dx/2,  raspi_dy/2]) circle(r=5);
        translate([ raspi_dx/2, -raspi_dy/2]) circle(r=5);
        translate([-raspi_dx/2, -raspi_dy/2]) circle(r=5);
        
        translate([ 17.78, -32.00]) circle(r=5);
        translate([-33.02, -16.76]) circle(r=5);
    }
}

module raspi_bak() {
    difference() {
        cylinder(d=6, h=4);
        translate([0,0,-0.1]) cylinder(d=2.7, h=4.2);
    }
}

difference() {
    union() {
        linear_extrude(height=talca_vastagsag) {
            talca_alap_2d();
        }
        
        translate([ raspi_dx/2,  raspi_dy/2, talca_vastagsag]) raspi_bak();
        translate([-raspi_dx/2,  raspi_dy/2, talca_vastagsag]) raspi_bak();
        translate([ raspi_dx/2, -raspi_dy/2, talca_vastagsag]) raspi_bak();
        translate([-raspi_dx/2, -raspi_dy/2, talca_vastagsag]) raspi_bak();
    }
    
    translate([ 15.24,  18.80, -0.5]) cylinder(d=2.6, h=talca_vastagsag + 1);
    translate([ 17.78, -32.00, -0.5]) cylinder(d=2.6, h=talca_vastagsag + 1);
    translate([-33.02, -16.76, -0.5]) cylinder(d=2.6, h=talca_vastagsag + 1);
    
    cube([20, 45, talca_vastagsag * 3], center=true);
}