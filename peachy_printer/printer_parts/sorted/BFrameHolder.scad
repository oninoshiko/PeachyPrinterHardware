include <vars.scad>

//-----------Slots for Mirror A:------------

module MirrorASlots(){
		translate([0,3]){
		difference(){
		
			translate([-sheet_A-hoseTight*2+hoseTight+sheet_A/2,perimeterSlot+sheet_A+threadhookThin+mirrorThick])
				square([sheet_A+hoseTight,frameInsideWidth]);
			translate([-sheet_A-hoseTight*2+hoseTight+sheet_A/2,perimeterSlot+sheet_A+threadhookThin+mirrorThick])
				square([hoseTight,1]);
			translate([-sheet_A-hoseTight*2+hoseTight+sheet_A/2,perimeterSlot+sheet_A+frameInsideWidth-.5+threadhookThin+mirrorThick-.5])
				square([hoseTight,1]);
		}
		}

}

//---------------Snap for mirror frames:------------

//parameters:
//	curve
//		-radius of arc
//	arc
//		-degrees of the arc from tightest point to resting point after snapped
//	edges
//		-edges on 360 degrees of the circle
//	extraTension
//		-tension after it is snapped in

module FrameSnap(curve=3, arc=45, edges=30, extraTension=.2){


	difference() {
			rotate(-45)
				//move from mirror surface to where the frame rests
				translate([0,-sheet_A- threadhookThin- mirrorThick])
					{

						//back rest
						translate([-frameInsideWidth/2- frameThick+ laserCutWidth/2-perimeterSlot+ extraTension,-frameInsideWidth*1.4])
							square([frameInsideWidth+frameThick*2-laserCutWidth+perimeterSlot*2- extraTension*2,frameInsideWidth*1.4]);


						//left edge and curve:
						
						translate([-frameInsideWidth/2- laserCutWidth/2+curve*cos(arc),sheet_A+curve*sin(arc)-extraTension])
							circle(curve, $fn=edges);

						//right edge and curve:
						
						translate([+frameInsideWidth/2+ laserCutWidth/2-curve*cos(arc),sheet_A+curve*sin(arc)-extraTension])
							circle(curve, $fn=edges);						
						
												//connect between:
						translate([-frameInsideWidth/2-laserCutWidth/2,0])
							square([frameInsideWidth+laserCutWidth,sheet_A-extraTension]);
					}
		//cut edges:
		translate([-frameInsideWidth-sin(45)*(frameInsideWidth/2+frameThick+perimeterSlot+sheet_A+threadhookThin+mirrorThick),-frameInsideWidth*2-sin(45)*(frameInsideWidth/2+frameThick+perimeterSlot+sheet_A)])
			square([frameInsideWidth,frameInsideWidth*4]);
		translate([-sin(45)*(frameInsideWidth/2+frameThick+perimeterSlot+sheet_A+threadhookThin+mirrorThick),-frameInsideWidth*2-sin(45)*(frameInsideWidth/2+frameThick+perimeterSlot+sheet_A+threadhookThin+mirrorThick)])
		square(frameInsideWidth*2);

		//room for thread assembly:
		circle(4,$fn=30);
		rotate(45) translate([0,-4])square([10,8]);
	}

}

//--------------B frame holder:------------------
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

module BFrameHolder(curve=3, arc=36, edges=40, cut=0.2, cutLength=9.4, thick=2.7, extraTension=0.3){

	difference() {
		union(){
			translate([0,mirrorsToBase_Z]) rotate(45+90) translate([-3,7])
			square([8,21]);
			translate([0,mirrorsToBase_Z])
				{
				FrameSnap();
				}

			//left bend and curve:
			translate([-mirrorAToB-extraTension,-sheet_A])
				square([thick,sheet_A]);
			translate([-mirrorAToB+curve*cos(arc)-extraTension,-sheet_A-curve*sin(arc)+extraTension])
				circle(curve, $fn=edges);

			//right bend and curve:
			translate([mirrorAToB-thick+extraTension,-sheet_A])
				square([thick,sheet_A]);
			translate([mirrorAToB-curve*cos(arc)+extraTension,-sheet_A-curve*sin(arc)+extraTension])
				circle(curve, $fn=edges);


			//fill in gap between frame snap and bottom:
			//if(mirrorsToBase_Z>(sin(45)*(frameInsideWidth/2+frameThick+sheet_A+threadhookThin+mirrorThick)+mirrorBHolderWidth)){
				translate([-sin(45)*(frameInsideWidth/2+frameThick+sheet_A+threadhookThin+mirrorThick+perimeterSlot),0])
				square([sin(45)*(frameInsideWidth+frameThick*2+sheet_A+threadhookThin+mirrorThick+perimeterSlot),fillGap]);
			//}
			//for marking "2"
			translate([-11.78,19.32])rotate(-45)translate([-3,-3.3]) square([4,8]);
			translate([-11.78,19.32])rotate(-45)translate([-3,-3.3]) square([9,3]);
		
		}
		//cuts

		translate([-mirrorAToB-cut/4-extraTension,0])
			square([cut/4,cutLength]);


		translate([-mirrorAToB+thick-extraTension,-sheet_A-curve*2])
			square([cut,+sheet_A+curve*2+cutLength-thick]);
translate([0,mirrorsToBase_Z]) rotate(45+90) translate([0,3]) mirror([1,0,0])
MirrorASlots();
	}		

}

//----------------Call Modules:-----------------
BFrameHolder();
