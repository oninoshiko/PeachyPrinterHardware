include <vars.scad>

//----------------Laser Mount A----------------
//parameters:
//	perimeter
//		-thickness around slot and laser hole
module LaserMountA(perimeter=5) {
	difference() {
		union(){
			translate([mirrorAToLaserTrack_Y,-mirrorsToBase_Z]){
				difference() {
					translate([-mirrorAToLaserTrack_Y,-sheet_A-perimeter])
						square([mirrorAToLaserTrack_Y+TrackWidth_A+perimeter,sheet_A+perimeter+mirrorsToBase_Z]);
					translate([+laserCutWidth/2,-sheet_A])
						square([TrackWidth_A-laserCutWidth,sheet_A]);
				}

			}
			circle(LaserRadius+hoseTight+perimeter);
		}
		circle(LaserRadius+hoseTight);
		translate([-LaserRadius-hoseTight-perimeter,-LaserRadius-hoseTight-perimeter])
			square([LaserRadius+hoseTight+perimeter,hoseTight+perimeter]);
		rotate(20)
			translate([-LaserRadius-hoseTight-perimeter,-hoseTight-perimeter])
			square([LaserRadius+hoseTight+perimeter,hoseTight+perimeter]);
	}


}


//----------------Laser Mount B----------------
//parameters:
//	perimeter
//		-thickness around slot and laser hole
module LaserMountB(perimeter=3) {
	difference() {
		union(){
			translate([mirrorAToLaserTrack_Y+(TrackWidth_A- TrackWidth_B)/2,-mirrorsToBase_Z]){
				difference() {
					translate([-mirrorAToLaserTrack_Y-(TrackWidth_A- TrackWidth_B)/2,-sheet_A-perimeter])
						square([mirrorAToLaserTrack_Y-(TrackWidth_A- TrackWidth_B)/2+TrackWidth_A+perimeter,sheet_A+perimeter+mirrorsToBase_Z]);
					translate([+laserCutWidth/2,-sheet_A])
						square([TrackWidth_B-laserCutWidth,sheet_A]);
				}

			}
			circle(LaserRadius+perimeter);
		}
		circle(LaserRadius+.2);

	}


}
//----------------Call Modules:-----------------

module LaserMount(){
LaserMountA();
translate([mirrorAToLaserTrack_Y+
    TrackWidth_A*2+LaserRadius,0])
        LaserMountB();
}

LaserMount();