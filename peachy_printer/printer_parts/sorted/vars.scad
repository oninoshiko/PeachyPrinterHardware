//--------------Variables:------------------


//note on variables: 	mirror locations refer to center of mirror
//						laser locations in Y and Z direction are to center of laser
//				 		other distances are to nearest edge

//measured variables:
//(3mm)  :
laserCutWidth=.16;				//thickness of plastic removed when cutting (diameter rather than radius)
						//acetate:
						//laserCutWidth=.7;

sheet=2.96;					//thickness of sheet
sheet_A=sheet-laserCutWidth;			//corrected for laser cut

hoseThickness=3;				//extra room the hose takes up 
hoseTight=1.75;					//gap when it is tight

LaserLength=50;					
LaserRadius=6.5;
mirrorThick=.7;					//thickness of mirrors

//controlled variables:
freeThread=5;					//length of thread free to rotate/stretch on each side (between mirrors/magnets and frame)

mirrorWidth=5;					//mirrors dimensions: 	
mirrorLength=10;				//	(both mirrors are mirrorWidth by mirrorLength)

threadhookThin=0;				//thinner part of threadhook
threadhookThick=1.2;				//thicker part of threadhook

frameThick=3.5;		   			//strength of frame

frameInsideWidth=13;				//inside width of frame
frameKnob=threadhookThick*1.5;			//spacer to allow threadhook movement when attaching B frame to laser mount

mirrorBHolderWidth=3;				//strength on a weak part of the mirror B holder

TrackWidth_A=15;				//laser track wide
TrackWidth_B=10;				//laser track narrow
perimeterSlot=3.5;				//width of plastic on edges of slots
dampenerToBase_Z=10;				//distance from dynamic dampener to the base in Z direction

//alignment variables:
mirrorsToBase_Z=max(mirrorLength/2,sin(45)*(frameInsideWidth/2+frameThick+
		sheet_A+threadhookThin+mirrorThick)+mirrorBHolderWidth);	//distance from mirrors to the base in z direction

mirrorAToLaserTrack_Y=sin(45)*(frameThick+frameInsideWidth/2+sheet_A+
		laserCutWidth)+sin(45)*(threadhookThin+mirrorThick);		//distance from mirror A to the wider part of the laser track

mirrorAToB=mirrorWidth*1.2;							//distance between the two mirrors (Y direction)

mirrorsToBHolder_X=sin(45)*(threadhookThin+mirrorThick+frameThick+
		frameInsideWidth/2+sheet_A+laserCutWidth)+perimeterSlot;	//distance from mirrors to b frame holder in x direction

LaserToMirrorBHolder_X=max((frameInsideWidth+frameThick*2+sheet_A*2)*sin(45)+
	hoseThickness+perimeterSlot,mirrorsToBHolder_X+mirrorLength/2+
	freeThread+frameThick+frameKnob)+3.5;					//distance from the laser to the Mirror B Holder

//simplifying variable:
fillGap=max(0,mirrorsToBase_Z-sin(45)*(frameInsideWidth/2+frameThick+sheet_A+threadhookThin+mirrorThick));

magnetToBase_Z=dampenerToBase_Z+10;
frameLengthInside=freeThread*2+mirrorLength/2+mirrorsToBase_Z+sheet+magnetToBase_Z;

tighterSheet=.07;

cardboard=4;
height=208+17;
front=171+8;
side=141.5;
overlap=15;
tinycut=0.006;

safeY=50+9;
safeX=25+6;
safeR=.3;

