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



// CONSTANTS (do not change)
KNURL_MEASURED_DIAMETER = 7.75; //measured outer diameter of a knurled nut
KNURL_MEASURED_HEIGHT   = 0.9;  //height of a knurled nut 

// PRINTER TWEAKS (you may experiment with)
// Depending on your filament size, layer heights, print temperature, etc
// you may find slightly better results by tweaking these.
KNURL_DIAMETER_PRINT_OFFSET = 0.2; //increase if nut does not fit
KNURL_HEIGHT_PRINT_OFFSET   = 0.5; //determines height of lip at end of bit 
BIT_DIAMETER_PRINT_OFFSET   = 0.2; //increase if shaft does not snugly

// VARIABLES (you may change)
OUTER_DIAMETER          = 11;  //may decrease for slightly less material
GRIP_DIAMETER_CHANGE    = 1;   //how much the grip diameter decreases
GRIP_HEIGHT             = 4;   //size of inside cone
BIT_DIAMETER            = 4.5; //common drill bit sizes: 4.5, 6mm
SHAFT_HEIGHT            = 4;   //shaft is inserted into drill chuck
TRANSFER_HEIGHT         = 3;   //"transfer" is between the bit and shaft
OUTER_NUM_ANGLES        = 6;   //usually bits are a hexagon...
GRIP_NUM_ANGLES         = 40;  //the number of "teeth"

// ADDITIONAL VARIABLE SETUP (do not change)
KNURL_RADIUS        = (KNURL_MEASURED_DIAMETER/2) + KNURL_DIAMETER_PRINT_OFFSET;
KNURL_HEIGHT        = KNURL_MEASURED_HEIGHT - KNURL_HEIGHT_PRINT_OFFSET;
GRIP_INNER_RADIUS   = KNURL_RADIUS - GRIP_DIAMETER_CHANGE;
BIT_RADIUS          = (BIT_DIAMETER/2) + BIT_DIAMETER_PRINT_OFFSET;
OUTER_RADIUS        = OUTER_DIAMETER/2;



union() {
  grip();
  transfer();
  shaft();
};

module grip() {
  difference() {
    cylinder(r=OUTER_RADIUS,h=GRIP_HEIGHT,$fn=OUTER_NUM_ANGLES); //outside
    cylinder(r=KNURL_RADIUS,h=KNURL_HEIGHT,$fn=GRIP_NUM_ANGLES); //lip
    translate([0,0,KNURL_HEIGHT]) //cone cutout
      cylinder(r1=KNURL_RADIUS,r2=GRIP_INNER_RADIUS,h=GRIP_HEIGHT-KNURL_HEIGHT,$fn=GRIP_NUM_ANGLES);
    translate([0,-500,-100]) cube(1000,1000,1000); //uncomment to see a cross-sectional view
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