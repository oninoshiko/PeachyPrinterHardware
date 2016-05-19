//-----------Notes:--------------

/*(following is from description txt file. see it for more complete description of each part and function)
Parts: 
 
Base
	-holds laser mounts, snap them into [some] distance to mirror A, [some] distance outward is mirror A
	-holds mirror A frame, snaps. Mirror A is between snap circles, [some] distance outward.
	-holds mirror B mount, slot for snap. Mirror A is at bottom of slot, mirrors are [some] distance away from slot
	-holes for standoffs
Laser mounts
	-lines up laser in 2 directions with mirror A from close corner of slot

Mirror B mount
	-holds mirror B frame, snaps. mirrors height is [some] distance from bottom, mirror B left-right is [some] distance from bottom left (mirror a)

Mirror A frame
	-notches for snapping to base
	-mark squares [some] distance to mirror, static magnet holder
	-mark lines [some] distance to rod ends, dampener

Mirror B frame
	-all parts of mirror A frame
	-knobs on mirror end
*/

include <vars.scad>;

//--------------------Laser mount snaps:---------------------------

//parameters:
//	ridge_X
//		-width of ridge that stops laser from going left
//	ridge_Y
//		-depth of ridge that stops laser from going left
//	notch
//		-notch on top that holds laser mount in place
//	curve
//		-radius of arc
//	arc
//		-degrees of the circle from the tightest point to the resting point when snapped
//	edges
//		-edges on 360 degrees of the circle
//	length
//		-length of the track taken up by this module
//	width
//		-width of the track
//	cut
//		-width of the cut
//	thick
//		-width of the bending part
//	extraTension
//		-tension after the mount is snapped in

module laserSnap(ridge_X=2, ridge_Y=1, notch=1.2, curve=2.5, arc=40, edges=45, length=22, width=10, cut=1.5, thick=2.9, extraTension=0.4){		
	//laser mounts snap into this
	//zero x coord is left edge of mount

	//add ridge to stop mount from going further left
	translate([-ridge_X,-ridge_Y])
		square([ridge_X,ridge_Y]);

	difference(){
		union(){ 
			//main block
			square([length,width]);
			//add curve
				translate([sheet_A+curve*sin(arc),curve*cos(arc)-extraTension])
				circle(curve, $fn=edges);
			//(when snapped in) extra tension
				translate([cut,-extraTension])
					square([sheet_A-cut,extraTension]);
		}
		//cut out
		square([cut,thick]);
		translate([0,thick])
			square([length-thick*1.5,cut]);


	}
//notch on top
		translate([-notch,width])
			square([notch+.000505,notch/2]);
		translate([sheet_A,width])
			square([notch+.000505,notch/2]);
}

//----------------Laser track:-------------------


module laserTrack(){
	//top-right section of the base
	//two laser mounts snap onto this, one is thinner to allow the other past.
	
	//the distance to first mount lets the B frame attach to the first mount
	//the distance between mounts allows the laser to fit between tightly
	

	//there are two slots for standoffs to connect the base to the case

	difference() {
		union(){
			//block to first mount:
			translate([0,-laserCutWidth/2])
			square([LaserToMirrorBHolder_X,TrackWidth_A+laserCutWidth]);
			//snap for first mount:
			translate([LaserToMirrorBHolder_X,-laserCutWidth/2])
				laserSnap(width=TrackWidth_A+laserCutWidth, length=23);
			//block to second mount:
			translate([LaserToMirrorBHolder_X+23,-laserCutWidth/2])
				square([LaserLength*3/4-23-15,TrackWidth_A+laserCutWidth]);
			//snap for second mount:
			translate([LaserToMirrorBHolder_X+LaserLength*3/4,TrackWidth_A/2-TrackWidth_B/2])
				rotate(90)
					pushSnap(length=15,stopWidth=TrackWidth_A+laserCutWidth,cut=.5,cutLength=12);
		}
	//standoff slots:
	translate([LaserToMirrorBHolder_X-6,-laserCutWidth/2+perimeterSlot])
		square([sheet_A,TrackWidth_A- perimeterSlot*2+.075]);
	translate([LaserToMirrorBHolder_X+21,-laserCutWidth/2+perimeterSlot])
		square([sheet_A,TrackWidth_A- perimeterSlot*2+.075]);
	}
}


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

//-----------Slots for Mirror B:------------

module MirrorBSlots(){

	//frame holder slot:	
	difference(){
		//perimeter:
		translate([-sheet_A-perimeterSlot,-mirrorAToB*2-perimeterSlot- mirrorAToLaserTrack_Y])
			square([sheet_A+ perimeterSlot*2,mirrorAToB*2+ perimeterSlot*2+ mirrorAToLaserTrack_Y]);
		//slot:
		//(length of the slot is twice the distance between mirrors, with mirror B (y coord) in the center of the slot)
		translate([-sheet_A,-mirrorAToB*2+laserCutWidth/2- mirrorAToLaserTrack_Y-1])
			square([sheet_A+.02,mirrorAToB*2-laserCutWidth]);
	}
    
	//fill in above slot
	translate([-sheet_A-perimeterSlot,- mirrorAToLaserTrack_Y])
		square([sheet_A+perimeterSlot,TrackWidth_A+ mirrorAToLaserTrack_Y]);



	//dampener slot:
/*	difference() {
		translate([-sheet_A*2- hoseTight*2-perimeterSlot*3,- mirrorAToLaserTrack_Y-mirrorAToB- frameInsideWidth- perimeterSlot])
			square([sheet_A+perimeterSlot*2+hoseTight*2,frameInsideWidth+perimeterSlot*2]);
		translate([-sheet_A*2-hoseTight*2-perimeterSlot*2,- mirrorAToLaserTrack_Y-mirrorAToB- frameInsideWidth])
			square([sheet_A+hoseTight,frameInsideWidth]);


	}
	//hose clamp markers:
			translate([-sheet_A*2-hoseTight*2-perimeterSlot*2,- mirrorAToLaserTrack_Y-mirrorAToB- frameInsideWidth])
				square([hoseTight,.5]);
			translate([-sheet_A*2-hoseTight*2-perimeterSlot*2,- mirrorAToLaserTrack_Y-mirrorAToB- frameInsideWidth+frameInsideWidth-.5])
				square([hoseTight,.5]);
*/
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

//Base:
module Base(){
    difference(){ union(){
        laserTrack();
        MirrorBSlots();
        translate([mirrorsToBHolder_X,
            -mirrorAToLaserTrack_Y])
                rotate(-90) FrameSnap();
	}
    
	translate([mirrorsToBHolder_X,
        -mirrorAToLaserTrack_Y])
			rotate(-45+90) MirrorASlots();
    }
}

Base();