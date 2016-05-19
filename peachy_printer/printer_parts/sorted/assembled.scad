use <BFrameHolder.scad>
use <Cover.scad>
use <LaserMount.scad>
use <StaticDampener.scad>
use <ThreadAssembly.scad>
use <Base.scad>
use <CircuitMount.scad>
use <Frame.scad>
use <Standoff.scad>
use <StaticMagnetHolder.scad>
use <vars.scad>
//----------------Call Modules:-----------------

*threadAssembly();

*square([5,10]);
*cover();

*standoff();
*circuit();
*staticDampenerA();
*staticDampenerB();
translate([71,-10,-14])rotate([-90,0,90]) LaserMountB();
translate([33,-10,-14])rotate([-90,0,90])LaserMountA();
//LaserMount();

translate([-20,-18,-12])rotate([90,-45,90])StaticMagnetHolder();
translate([13,-9,22])rotate([0,0,45])StaticMagnetHolder();
translate([4,-14,-1])rotate([-90,0,45])Frame();
translate([0,-12,-3])rotate([0,45,-90])Frame();
translate([-1,-17,0])rotate([-90,0,90])BFrameHolder();
Base();
