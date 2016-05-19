include <vars.scad>

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

//----------------Static Dampeners:--------------
module staticDampenerA(){
	pushSnap(width=sheet_A+perimeterSlot,stopWidth=sheet_A+perimeterSlot*2,length=mirrorsToBase_Z,cutLength=8);
	//translate([-perimeterSlot/2,sheet_A+hoseThickness+mirrorsToBase_Z+4])
		//rotate(-45)	square(sheet_A+perimeterSlot*2);
}



module staticDampenerB(){
	difference() {
		translate([-perimeterSlot,-perimeterSlot])
			square([sheet_A+perimeterSlot*2,sheet_A*1.5+perimeterSlot*2]);
		translate([0,0])
			square([sheet_A,sheet_A+perimeterSlot]);
	}
	translate([-perimeterSlot,sheet_A+perimeterSlot])
		square([sheet_A+perimeterSlot*2,perimeterSlot+sheet_A+4.25]);
	//surface:
	difference(){
		translate([-perimeterSlot,sheet_A+perimeterSlot+perimeterSlot+sheet_A+3.5])
			square([sheet_A+perimeterSlot*2,4]);
		translate([+sheet_A/2,sheet_A+perimeterSlot+perimeterSlot+sheet_A+7.5])
			circle(3.25,$fn=15);
	}
}

//----------------Call Modules:-----------------

staticDampenerA();
staticDampenerB();
