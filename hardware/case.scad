width = 66;
length = 139;
end_panel_height = 22.6;
end_panel_thickness = 1.75;
end_panel_hole_radius = 1.0;
extra_height = 5.0;
wall_width = 3.0;
wall_height = end_panel_height/2 + extra_height + wall_width;
pcb_support_offset1 = [(32.75+23.4)/4,         -(45.16+36.0)/4, wall_width];
pcb_support_offset2 = [pcb_support_offset1[0], -(45.16+36.0)/4-(35.05+25.91)/2, wall_width];
pcb_support_external = 4.75;
pcb_support_internal = 2.4;
pcb_support_height = 4.0;
case_support_offset = [(60+45)/4 ,(53.16+64.0)/4, 0];
case_support_external = 5.5;
case_support_internal = 3.0;
case_support_hole_max_diam = 5.0;
bevel_length = 500;
rim_width = 1.0;
top_rim_width = 0.8;
top_rim_standoff = 5.0;
groove_width = 2.0;

module make_bevel(rotation,offset,radius) {
    translate(offset)
    rotate(rotation) 
  		difference() {
	        translate([0,0,-bevel_length/2]) cube([radius,radius,bevel_length]);
	        cylinder(r=radius,h=bevel_length+2,$fn=50,center=true);
        }
}
module bevelx (radius,offset) {
	difference() {
	    children();
	    make_bevel([0,90,0],offset,radius);
	}
}

module bevely (radius,offset) {
	difference() {
	    children();
	    make_bevel([-90,0,0],offset,radius);
	}
}

module bevelz (radius,offset) {
	difference() {
	    children();
	    make_bevel([0,0,0],offset,radius);
	}
}

module quad_copy (){
    union() {
		children();
		mirror ([0,1,0]) children();
		mirror ([1,0,0]) children();
		mirror ([1,0,0]) mirror([0,1,0]) children();
	}
}

module tube (ext, int, h) {
    difference() {
        cylinder(r=ext/2,h=h,$fn=50);
        cylinder(r=int/2,h=h,$fn=50);
    }
}

module front_panel() {
    translate([0,length/2-groove_width/2-rim_width,0]) {
        quad_copy() {
            //front wall
                translate([0,-groove_width/2-rim_width,wall_width]) cube([width/2-wall_width,groove_width+rim_width*2,extra_height]);
                
			    translate([0,groove_width/2,wall_width+extra_height]) cube([width/2-wall_width,rim_width,rim_width]);
			    translate([width/2-wall_width-rim_width,groove_width/2,wall_width+extra_height]) cube([rim_width,rim_width,end_panel_height/2]);
        }
    }
}

module rear_panel() {
    difference() {
        translate([0,-(length/2-rim_width-groove_width/2),(end_panel_height+extra_height)/2+wall_width]) 
            cube([width-wall_width*2,end_panel_thickness,end_panel_height+extra_height],center=true);
        translate([0,-length/2,(end_panel_height+extra_height)/2+wall_width])
            rotate([90,0,0])
            cylinder(h=10,r=end_panel_hole_radius,center=true,$fn=100);
        make_bevel([90,0,0],[width/2-wall_width-2,-length/2,end_panel_height+extra_height+wall_width-2],2.1);
        make_bevel([90,0,180],[-(width/2-wall_width-2),-length/2,end_panel_height+extra_height+wall_width-2],2.1);
        }
}

module pcb_supports() {
    translate(pcb_support_offset1) tube(pcb_support_external, pcb_support_internal, pcb_support_height);
    translate(pcb_support_offset2) tube(pcb_support_external, pcb_support_internal, pcb_support_height);
    mirror([1,0,0]) translate(pcb_support_offset1) tube(pcb_support_external, pcb_support_internal, pcb_support_height);
    mirror([1,0,0]) translate(pcb_support_offset2) tube(pcb_support_external, pcb_support_internal, pcb_support_height);
}

rotate([0,0,90])
    union() {
        quad_copy() {
            bevelz (wall_width+0.1,[width/2-wall_width,length/2-wall_width,0]) {
            bevely (1.1,[width/2-1,0,1.0]) {
            bevelx (1.1,[0,length/2-1,1.0]) {
                difference() {
	                union() {
                        //base	
	                    cube([width/2,length/2,wall_width]);
	                    //side wall
	                    translate([width/2-wall_width,0,0]) cube([wall_width,length/2,wall_height]);
			            //top rim
			            translate([(width-wall_width-top_rim_width)/2,0,wall_height]) cube([top_rim_width,length/2-top_rim_standoff,rim_width]);
	                    //pcb_supports
	                    //case supports
	                    translate(case_support_offset) tube(case_support_external, case_support_internal, wall_height);
                    }
                    translate([0,0,0.35]) translate(case_support_offset) {
                        cylinder(d1=case_support_hole_max_diam,d2=case_support_internal,h=wall_width-0.25,$fn=100);
                    }
                }
            }
            }
            }
        }
        front_panel();
        rear_panel();
        pcb_supports();
        
    };

