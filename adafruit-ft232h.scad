/* author: andimoto */


$fn=30;

module ft232h_plate(){
  /* mil is the grid value of the ft232h's pcb
   see: https://learn.adafruit.com/adafruit-ft232h-breakout/downloads */
  mil=25.4; //mm
  plateThickness=2; //mm
  standoff_thk=2; //mm
  lenX=mil*1.35; //mm
  lenY=mil*0.75; //mm
  cylRadius=2; //mm
  holeRadius=1.3; //mm

  difference() {
    union(){
      translate([cylRadius,cylRadius,0]) minkowski(){
        cube([lenX,lenY,plateThickness/2]);
        cylinder(r=cylRadius);
      } /* minkowski */

      /* standoffs */
      translate([mil*0.1, mil*0.1, 0])
      for (i = [0,+1], j=[0,+1])
        translate([i*mil*1.3,j*mil*0.7,0])
        cylinder(r=cylRadius,h=plateThickness+standoff_thk);
    } /* union */

    /* standoff holes */
    translate([mil*0.1, mil*0.1, 0])
    for (i = [0,+1], j=[0,+1])
      translate([i*mil*1.3, j*mil*0.7, 0]){
      #cylinder(r=holeRadius,h=plateThickness+standoff_thk);
}
} /* difference */
} /* module */


module ft232h_plate_top(){
  ft232h_plate();
}

ft232h_plate();

translate([0,30,0])
ft232h_plate_top();
