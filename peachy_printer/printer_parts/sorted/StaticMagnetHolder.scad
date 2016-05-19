include <vars.scad>

//-----------------Static Magnet Holder:---------------

module StaticMagnetHolder(magnetStatic=6.7,magnetDynamic=2.3,curve=1.8,edges=30,arc=37,extraTension=0.21,ridge_Y=2){
	difference(){
		//outside
		translate([-frameInsideWidth/2-frameThick-ridge_Y- perimeterSlot,-sheet_A-magnetStatic-perimeterSlot-magnetDynamic])
		union(){
			square([(frameInsideWidth/2+frameThick+ridge_Y+ perimeterSlot)*2,(sheet_A+magnetStatic+perimeterSlot)*2+magnetDynamic*2]);
			translate([frameInsideWidth/2+frameThick+ridge_Y+ perimeterSlot-5,-1]) 
			union(){
				square([10,1]);
				difference(){
					translate([-2,-1.5])square([14,1.5]);
					translate([-2,-.7])rotate(40) square(3);
					translate([-2+14,-.7])rotate(-40)translate([-3,0]) square(3);
				}
			}
		}
		//snapped slot
		translate([-frameInsideWidth/2-frameThick+ extraTension,0])
		square([frameInsideWidth+frameThick*2- extraTension*2,sheet_A+threadhookThin+mirrorThick]);

		//unsnapped slot
		translate([-frameInsideWidth/2-frameThick-ridge_Y,-magnetDynamic-sheet_A])
		square([frameInsideWidth+frameThick*2+ridge_Y*2,sheet_A+magnetDynamic]);

		//magnet holes
		translate([0,+threadhookThin+mirrorThick+magnetDynamic+sheet_A+magnetStatic/2])
		circle(magnetStatic/2,$fn=40);

		translate([0,-magnetDynamic-sheet_A-magnetStatic/2]){
			circle(magnetStatic/2,$fn=40);
			translate([-2,0]) square([4,magnetStatic/2]);
		}
		
	}
	//snap curves:
		difference(){
			union(){
				translate([-frameThick- frameInsideWidth/2- curve*cos(arc)+extraTension, threadhookThin+mirrorThick- curve*sin(arc)+extraTension])
					circle(curve, $fn=edges);
				translate([frameThick+ frameInsideWidth/2+ curve*cos(arc)-extraTension, threadhookThin+mirrorThick- curve*sin(arc)+extraTension])
					circle(curve, $fn=edges);	
			}
				translate([-frameInsideWidth/2-frameThick-ridge_Y,-magnetDynamic-sheet_A])
		square([frameInsideWidth+frameThick*2+ridge_Y*2,sheet_A]);
		}
}

//----------------Call Modules:-----------------

translate([-20,-18,-12])rotate([90,-45,90])StaticMagnetHolder();
translate([13,-9,22])rotate([0,0,45])StaticMagnetHolder();
