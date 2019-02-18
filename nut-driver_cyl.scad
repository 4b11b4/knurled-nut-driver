// Anton Bilbaeno
// 4     b11b4
// github: 4b11b4
// thingiverse: 4b11b4
// www.4b11b4.com
// 1/30/2019



// A model for a 3D printed drill bit designed to tighten 3.5mm
// knurled nuts. These are common in Eurorack synthesizer modules.

// This drill bit is unique in that most designs feature "nubs" to
// fit into two "slots" on these knurled nuts. This design completely
// ignores those "slots". Instead, the inside of the "grip" is a cone
// shape. In other words, the cutout is a cylinder with a decreasing
// diameter as it goes up.

// Instead of having "nubs" which fit into the "slots" of the knurled
// nut, this "grip" simply uses friction. A small amount of downward
// force is required. This does cause the "grip" to wear out over time.
// However, as you wear out one layer (i.e. each "layer" created by the
// 3D printer), the layer above it will begin to grip the knurled nut.

// With the proper driver, the bit can be used to tighten knurled
// nuts to an appropriate level of torque.

// It may be possible to design some even more complex structures
// inside the bit, so that as you wear out one layer, you will reach
// a completely new grip. This would eventually require removing
// some of the face of the bit (i.e. sanding down the front).



// While tweaking the variables below, it is helpful to see the inside of
// the bit. You will find a helpful comment in the grip() definition below.



// REAL-WORLD MEASUREMENTS USING METAL CALIPERS
// If default .STL files do not work, try check these measurements.
KNURL_D_MEASURE = 7.70; //measured outer diameter of a knurled nut
KNURL_H_MEASURE = 1.87; //height of a knurled nut
THREAD_H_MEASURE = 4.65; //height of threads on jack
BIT_D_MEASURE = 4.50; //common drill bit sizes: 4.5, 6mm

// PRINTER TWEAKS (you may experiment with)
// Depending on your filament size, layer heights, print temperature, etc
// you may find slightly better results by tweaking these.
KNURL_R_TWEAK = 0.125 ; //increase if nut does not fit
KNURL_H_TWEAK = 1.75; //reduce height of lip at end of bit, max=KNURL_H_MEASURE
BIT_R_TWEAK   = 0.200; //increase if shaft does not fit snugly
GRIP_H_TWEAK = 0.00; //increase if bit bottoms out. knurl_h is 1.87mm, so THREAD_H_MEASURE should be an extra 1.87mm too big already...? assuming the "grip" area is hitting the jack at the top

// VARIABLES SETUP (you may change)
GRIP_SHELL = 1.50; //thickness outside wall <-> grip cutout
GRIP_R_CHANGE = 0.750; //how much the grip radius decreases
SHAFT_HEIGHT            = 4;   //shaft is inserted into drill chuck
TRANSFER_HEIGHT         = 3;   //"transfer" is between the bit and shaft
OUTER_NUM_ANGLES        = 6;   //usually bits are a hexagon...
GRIP_NUM_ANGLES         = 40;  //the number of "teeth"
KNURL_R_STEP = -0.1;
KNURL_H_STEP = 0.0125;

// FINAL VARIABLE SETUP (do not change)
KNURL_R        = KNURL_D_MEASURE/2 + KNURL_R_TWEAK;
KNURL_H        = KNURL_H_MEASURE - KNURL_H_TWEAK;
GRIP_INNER_RADIUS   = KNURL_R - GRIP_R_CHANGE;
GRIP_HEIGHT         = THREAD_H_MEASURE + GRIP_H_TWEAK;   //size of inside cone
BIT_RADIUS          = BIT_D_MEASURE/2 + BIT_R_TWEAK;
OUTER_RADIUS        = KNURL_R + GRIP_SHELL;



union() {
  grip();
  transfer();
  shaft();
};

module grip() {
  union() {
    difference() {
      cylinder(r=OUTER_RADIUS,h=GRIP_HEIGHT,$fn=OUTER_NUM_ANGLES); //outside cylinder solid
      cylinder(r=KNURL_R,h=KNURL_H,$fn=GRIP_NUM_ANGLES); //KNURL_H ("lip") cylinder cutout
      translate([0,0,KNURL_H]) //cone cutout "cylinder with decreasing radius"
        cylinder(r1=KNURL_R,r2=GRIP_INNER_RADIUS,h=GRIP_HEIGHT-KNURL_H,$fn=GRIP_NUM_ANGLES);
      /////// UNCONMMENT TO VIEW CROSS-SECTION OF BIT
      //translate([0,-500,-100]) cube(1000,1000,1000);
      ///////
    }
    kk1();
  }
}

module kk1() {
  difference() {
    translate([0,0,KNURL_H+KNURL_H_STEP]) //cone cutout "cylinder with decreasing radius"
      cylinder(r=KNURL_R, h=GRIP_HEIGHT-KNURL_H, $fn=GRIP_NUM_ANGLES*2);
    translate([0,0,KNURL_H+KNURL_H_STEP]) //cone cutout "cylinder with decreasing radius"
      cylinder(r1=KNURL_R-KNURL_R_STEP,r2=GRIP_INNER_RADIUS, h=GRIP_HEIGHT-KNURL_H, $fn=GRIP_NUM_ANGLES/10);
    
    KK_MULT = 90;
    for (i=[0:KK_MULT]) {
      translate([0,0,KNURL_H+KNURL_H_STEP]) { //cone cutout "cylinder with decreasing radius"
        rotate([0,0,i*(360/KK_MULT)])
          cylinder(r1=KNURL_R-KNURL_R_STEP,r2=GRIP_INNER_RADIUS, h=GRIP_HEIGHT-KNURL_H, $fn=GRIP_NUM_ANGLES/KK_MULT);
      }
    }
  }
}

module transfer() {
  translate([0,0,GRIP_HEIGHT])
    cylinder(r1=OUTER_RADIUS,r2=BIT_RADIUS,h=TRANSFER_HEIGHT,$fn=OUTER_NUM_ANGLES);
}

module shaft() {
  translate([0,0,GRIP_HEIGHT+TRANSFER_HEIGHT])
    cylinder(r=BIT_RADIUS,h=SHAFT_HEIGHT,$fn=OUTER_NUM_ANGLES);
}