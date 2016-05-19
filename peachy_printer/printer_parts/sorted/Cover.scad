include <vars.scad>

module cover(){
	difference(){
		union(){
			translate([front+overlap*2,0]) square([front+side*2,height+side+overlap]);
		}
		square([front,side+overlap]);

		translate([front+overlap*2,0]) square([side,side+overlap]);
		translate([front+overlap*2,0]) square([tinycut,side+overlap+height]);

		translate([front+side+overlap*2,0]) square([front,side+overlap]);
		translate([front+side+overlap*2,0]) square([tinycut,side+overlap+height]);

		translate([front+side+front+overlap*2,0]) square([side,side+overlap]);
		translate([front+side+front+overlap*2,0]) square([tinycut,side+overlap+height]);
	}


	difference(){
		union(){
			square([front+overlap,height+side+overlap]);
			translate([-overlap,side+overlap+tinycut]) square([overlap-tinycut,height]);
			translate([0,height+side+overlap+0.006]) square([front,overlap]);

		}
		square([front,side+overlap]);

		translate([front,0]) square([side,side+overlap]);
		translate([front,0]) square([tinycut,side+overlap+height]);


		translate([0,side+overlap]) square([front,tinycut]);


	}
	difference(){
		union(){
			translate([-overlap,0]) square([front+overlap*2,side+overlap]);


		}
		translate([-overlap,0]) square(overlap);
		translate([front,0]) square(overlap);

		translate([front,side+overlap-.006]) square([overlap,0.006]);
		square([0.006,side+overlap]);
		translate([0,overlap]) square([front,0.006]);
		translate([front,overlap]) square([0.006,side]);


		translate([safeX,safeY+overlap]) circle(safeR,$fn=10);
		translate([front+side,side]) square([.006,overlap]);
		translate([front*2+side,side]) square([.006,overlap]);
		translate([front,side+overlap+height]) square([.006,overlap]);
	}
}


//----------------Call Modules:-----------------
cover();