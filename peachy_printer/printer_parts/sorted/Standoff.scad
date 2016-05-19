include <vars.scad>

//End of Variables
//---------------Push Snap:-------------------

//parameters:
//	curve
//		-radius of arc
//	arc
//		-degrees of the arc from tightest point to resting point after snapped
//	edges
//		-edges on 360 degrees of the circle
//	cut
//		-width of the cut for bending
//	thick
//		-width of the bending part
//	extraTension
//		-tension after it is snapped in
//	cutLength
//		-length of the cut for bending
//	width
//		-width of slot that it goes into
//	length
//		-length it takes up above snap point
//	stopwidth
//		-width after snap


module pushSnap(curve=2.5,arc=40,edges=40,cut=1,thick=3,extraTension=0.2,cutLength=5,width=TrackWidth_B,length=9,stopWidth=TrackWidth_A){
	difference(){
		union(){
			//left bend and curve:
			translate([-extraTension,-sheet_A])
				square([thick,sheet_A]);
			translate([+curve*cos(arc)-extraTension,-sheet_A-curve*sin(arc)+extraTension])
				circle(curve, $fn=edges);

			//right bend and curve:
			translate([width-thick+extraTension,-sheet_A])
				square([thick,sheet_A]);
			translate([width-curve*cos(arc)+extraTension,-sheet_A-curve*sin(arc)+extraTension])
				circle(curve, $fn=edges);

			//top
			translate([width/2-stopWidth/2,0])
			square([stopWidth,length]);
		}
		//cuts:
		translate([-cut/4-extraTension,0])
			square([cut/4,cutLength]);
		translate([+thick-extraTension,-sheet_A-curve*2])
			square([cut,+sheet_A+curve*2+cutLength-thick]);

	}
}
//----------------Standoff:-------------------

module standoff(length=magnetToBase_Z+freeThread+frameThick+threadhookThick*3+20,extraTension=laserCutWidth/2-.05){
	//bottom
	translate([-extraTension,0])
		pushSnap(width=TrackWidth_A-perimeterSlot*2+extraTension*2,length=10,cutLength=9);

	//middle
	translate([-perimeterSlot,10])
		square([TrackWidth_A,length-20]);

	//top
	translate([TrackWidth_A-perimeterSlot*2+extraTension,length])
		rotate(180)
			pushSnap(width=TrackWidth_A-perimeterSlot*2+extraTension*2,length=10,cutLength=9);
}

//----------------Call Modules:-----------------

standoff();