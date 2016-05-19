include <vars.scad>

//---------------Thread Assembly:----------------

//parameters:
//	hole
//		-hole for thread/rod at top and bottom
//	dampener radius
//	dampener length
//	perimeter(s)
//		-width around cutouts at different areas
// 	width
//		-width on narrow section
//	total length
//		- frame length less free thread
//	mirror grab
//		-the length that wraps around the mirror's face
//	tab depth
//		-makes folding easier
//	magnetFold
//		-length/width of fold for the magnet

module threadAssembly(hole=.5,dampenerRadius=1.4,dampenerLength=6,perimeterMagnet=1.8,perimeterDampener=1.0,width=2, totalLength=frameLengthInside -freeThread*2+1 ,mirrorGrab=01,tabDepth=1.5,magnetFold=2.5){
	
//mirror:	
	difference(){
		square([mirrorWidth,mirrorLength],center = true);

		//circle
		translate([0,mirrorLength/2 -hole -laserCutWidth])
			rotate(-30) circle(hole*1.5,$fn=3);

	}
	translate([-.35,5])square([.7,.4]);
	translate([-.8,5.4])square([1.6,.8]);
//dampener:

	difference() {
		translate([-dampenerRadius-perimeterDampener,mirrorLength/2 -totalLength+10]){
			square([dampenerRadius*2+perimeterDampener*2,dampenerLength]);	
			translate([+dampenerRadius+perimeterDampener,dampenerLength])
				circle(dampenerRadius+perimeterDampener,$fn=40);
			translate([0,-perimeterDampener])
				square([dampenerRadius*2+perimeterDampener*2,perimeterDampener]);
			
		}
		//folding piece:
		translate([-dampenerRadius,mirrorLength/2 -totalLength+10]){
			square([dampenerRadius*2,dampenerLength]);
		translate([dampenerRadius,dampenerLength])
			circle(dampenerRadius,$fn=20);
		}
	}


	//thin part:
		translate([-width/2,mirrorLength/2 -totalLength+magnetFold])
			square([width,10-magnetFold]);
		translate([-width/2,mirrorLength/2 -totalLength+10+dampenerLength+dampenerRadius])
			square([width,totalLength -mirrorLength -dampenerRadius -dampenerLength-10]);


	difference(){
		
		//at magnet:
		translate([-perimeterMagnet,mirrorLength/2 -totalLength -magnetFold/2 -hole*2 -laserCutWidth*2])
			square([perimeterMagnet*2,+magnetFold*1.5+hole*2+laserCutWidth*2]);
		translate([0,mirrorLength/2 -totalLength-magnetFold/2 -hole -laserCutWidth])
			rotate(30) circle(hole*1.5,$fn=3);
		translate([0,mirrorLength/2 -totalLength-magnetFold/2])
			square([magnetFold/2,magnetFold]);
	}
	translate([-.35,-40.15])square([.7,.4]);
	translate([-.8,-40.15-.8])square([1.6,.8]);

}

//----------------Call Modules:-----------------


threadAssembly();
