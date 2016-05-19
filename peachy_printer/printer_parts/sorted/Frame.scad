include <vars.scad>

//-------------- Frame:------------------------

module Frame(ridge_X=3,ridge_Y=1.5){
	//(counterclockwise starting at left middle)
	translate([0,-tighterSheet/2])
		square([ridge_Y*1.7+frameThick,ridge_X+tighterSheet/2]);
	translate([0,-sheet_A])
		square([frameThick,sheet_A]);
	translate([0,-sheet_A-ridge_X])
		square([frameThick+ridge_Y*1.7,ridge_X+tighterSheet/2]);
	
	//left to bottom:
	translate([0,-sheet-magnetToBase_Z- freeThread])
		square([frameThick,magnetToBase_Z+freeThread]);

	//bottom:
	difference() {
		translate([0,-sheet-magnetToBase_Z- freeThread- frameThick])
			square([frameThick*2+frameInsideWidth,frameThick]);

		//notches for thread
		translate([0,-sheet-magnetToBase_Z- freeThread-0.3])
			square([.6,0.01]);
		translate([frameInsideWidth+frameThick*2-.6,-sheet-magnetToBase_Z- freeThread-0.3])
			square([.6,0.01]);
		translate([frameThick+frameInsideWidth/2-0.005,-sheet-magnetToBase_Z- freeThread- frameThick])
			square([0.01,.6]);
	}
	
	//right:
	translate([frameThick+frameInsideWidth,-sheet-magnetToBase_Z- freeThread])
		square([frameThick,frameLengthInside]);

	//base ridges
	translate([frameThick+frameInsideWidth- ridge_Y*1.7,-tighterSheet/2])	
		square([ridge_Y*1.7,ridge_X+tighterSheet/2]);
	translate([frameThick+frameInsideWidth -ridge_Y*1.7,-sheet_A-ridge_X])
		square([ridge_Y*1.7,ridge_X+tighterSheet/2]);


	//top:
	difference() {
		union(){
			translate([0,mirrorsToBase_Z+mirrorLength/2+freeThread])
				square([frameInsideWidth+frameThick*2,frameThick]);
			translate([0,mirrorsToBase_Z+mirrorLength/2+freeThread -frameThick/2])
				square([frameThick, frameThick/2]);
		}
		//notches for thread
		translate([0,+.3+mirrorsToBase_Z+mirrorLength/2+freeThread])
			square([.6,0.01]);
		translate([frameInsideWidth+frameThick*2-.6,+.3+mirrorsToBase_Z+mirrorLength/2+freeThread])
			square([.6,0.01]);
		translate([frameThick+frameInsideWidth/2-0.005,mirrorsToBase_Z+mirrorLength/2+freeThread+frameThick-.6])
			square([0.01,.6]);
	}

	//magnet holder ridges
	//left
	translate([-ridge_Y,-sheet_A/2- magnetToBase_Z])
		square([ridge_Y,ridge_X+tighterSheet/2]);
	translate([-ridge_Y,-sheet_A*1.5- magnetToBase_Z- ridge_X])
		square([ridge_Y,ridge_X+tighterSheet/2]);
	//right
	translate([frameThick*2+frameInsideWidth,-sheet_A/2- magnetToBase_Z])
		square([ridge_Y,ridge_X+tighterSheet/2]);
	translate([frameThick*2+frameInsideWidth,-sheet_A*1.5- magnetToBase_Z- ridge_X])
		square([ridge_Y,ridge_X+tighterSheet/2]);
}

Frame();