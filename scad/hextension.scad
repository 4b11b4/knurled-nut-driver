SIDES = 6;


//BIT
BIT_DIAMETER = 7.1;
BIT_LENGTH = 7;

cylinder(
r=BIT_DIAMETER/2,
h=BIT_LENGTH,
$fn=SIDES);


//EXTENSION
EXT_THICKNESS = 0.77;
EXT_OVERLAP = 2;
EXT_LENGTH = 7 + EXT_OVERLAP;
EXT_SIDES = 17;
NOTCH_HEIGHT = 0.2;
NOTCH_DEPTH = 0.2; 

translate([0,0,BIT_LENGTH-EXT_OVERLAP])
difference() {
  //extension
  difference() {
    cylinder(
    r=BIT_DIAMETER/2+EXT_THICKNESS,
    h=EXT_LENGTH,
    $fn=EXT_SIDES);

    cylinder(
    r=BIT_DIAMETER/2,
    h=EXT_LENGTH,
    $fn=6);
  }
  
  //notch
  translate([0,0,EXT_OVERLAP*2])
  difference() {
    cylinder(
      r=BIT_DIAMETER/2+EXT_THICKNESS,
      h=NOTCH_HEIGHT,
      $fn=EXT_SIDES);
    cylinder(
      r=BIT_DIAMETER/2+EXT_THICKNESS-NOTCH_DEPTH,
      h=NOTCH_HEIGHT,
      $fn=EXT_SIDES);
  }
}