/* author: andimoto */

/* mil is the grid value of the ft232h's pcb
 see: https://learn.adafruit.com/adafruit-ft232h-breakout/downloads */
mil=25.4; //mm
plateThickness=2; //mm
standoff_thk=2; //mm
lenX=mil*1.35; //mm
lenY=mil*0.75; //mm
cylRadius=2; //mm
holeRadius=1.3; //mm

$fn=30;

module ft232h_plate(plateThk=2,standoffThk=2){
  difference() {
    union(){
      translate([cylRadius,cylRadius,0]) minkowski(){
        cube([lenX,lenY,plateThk/2]);
        cylinder(r=cylRadius);
      } /* minkowski */

      /* standoffs */
      translate([mil*0.1, mil*0.1, 0])
      for (i = [0,+1], j=[0,+1])
        translate([i*mil*1.3,j*mil*0.7,0])
        cylinder(r=cylRadius,h=plateThk+standoffThk);
    } /* union */

    /* standoff holes */
    translate([mil*0.1, mil*0.1, 0])
    for (i = [0,+1], j=[0,+1])
      translate([i*mil*1.3, j*mil*0.7, 0]){
      cylinder(r=holeRadius,h=plateThk+standoffThk);
}
} /* difference */
} /* module */


module ft232h_plate_top(plateThk=2,standoffThk1=2){
  difference() {
    ft232h_plate(plateThk=plateThk,standoffThk=standoffThk1);

      union() {
        translate([lenX/2+cylRadius,0,0])
        linear_extrude([0,0,plateThk/2])
        polygon([[-14,0],[14,0],[13,5],[-13,5]], paths=[[0,1,2,3]]);
      }
      union() {
        translate([lenX/2+cylRadius, lenY-cylRadius/2, 0])
        linear_extrude([0,0,plateThk/2])
        polygon([[-13,0],[13,0],[14,5],[-14,5]], paths=[[0,1,2,3]]);
      }

      /* usb */
      /* #union() {
        translate([3, lenY/2+cylRadius, plateThickness/2])
        cube([6,8,2],center=true);
      } */
  }
}


ft232h_plate(plateThk=plateThickness, standoffThk=standoff_thk);

/* put 1mm more on standoffs because of usb connector */
translate([0,30,0])
ft232h_plate_top(plateThk=plateThickness, standoffThk1=standoff_thk+1);
