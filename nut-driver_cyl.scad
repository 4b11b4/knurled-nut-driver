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
// ignores those "slots". Instead, the inside of the bit is a "cone"
// shape. In other words, the cutout is a cylinder with a decreasing
// diameter as it goes up.

// Instead of having "nubs" which fit into the "slots" of the knurled
// nut, this bit simply uses friction. A small amount of downward
// force is required. This does cause the bit to wear out over time.
// However, the bit is a very small amount of plastic, and this is 
// not too big of an issue.

// With the proper driver, the bit can be used to tighten knurled
// nuts to an appropriate level of torque.

// Additionally, as you wear out one layer, the layer above it will
// begin to grip the knurled nut.

// It may be possible to design some even more complex structures
// inside the bit, so that as you wear out one layer, you will reach
// a completely new grip. This would eventually require removing
// some of the face of the bit (i.e. sanding down the front).



// CONSTANTS (do not change)
KNURL_MEASURED_DIAMETER = 7.75; //measured outer diameter of a knurled nut

// VARIABLES (you may change)
OUTER_DIAMETER          = 11;  //may decrease for slightly less material
BIT_MEASURED_DIAMETER   = 4.5; //drill bit size

// PRINTER TWEAKS (you may experiment with)
// Depending on your filament size, layer heights, print temperature, etc
// you may find slightly better results by tweaking these.
KNURL_DIAMETER_PRINT_OFFSET = 0.2; //account for width of filament
BIT_DIAMETER_PRINT_OFFSET   = 0.4; //may adjust for a snug fit in drill

// ADDITIONAL VARIABLE SETUP (do not change)
KNURL_DIAMETER = KNURL_MEASURED_DIAMETER + KNURL_DIAMETER_PRINT_OFFSET;
BIT_DIAMETER   = BIT_MEASURED_DIAMETER + BIT_DIAMETER_PRINT_OFFSET;
KNURL_RADIUS   = KNURL_DIAMETER/2;
OUTER_RADIUS   = OUTER_DIAMETER/2;
BIT_RADIUS     = BIT_DIAMETER/2;

flathead=1.25;
fheight=4;

nwidth=0.9;

htransfer=3;
hgrip=4;

union() { 
    // cylinder cutout of outer hexagon
    difference() {
      translate([0,0,0]) cylinder(r=OUTER_RADIUS,h=fheight,$fn=6);
      translate([0,0,0]) cylinder(r=KNURL_RADIUS,h=fheight,$fn=40);
      //cube(50,50,50); //uncomment to see a cross-sectional view
    }
    
    // cylinder with decreasing diameter
    difference() {
      tightener();
      cylinder(r1=KNURL_RADIUS-nwidth+1,r2=KNURL_RADIUS-nwidth,h=fheight,$fn=40);
    }
  
        
    // transfer + grip
    translate([0,0,fheight]) cylinder(r1=OUTER_RADIUS,r2=(BIT_DIAMETER/2)+BIT_DIAMETER_PRINT_OFFSET,h=htransfer,$fn=6);
    translate([0,0,fheight+htransfer]) cylinder(r=(BIT_DIAMETER/2)+BIT_DIAMETER_PRINT_OFFSET,h=hgrip,$fn=6);
};

module tightener() {
    w=flathead;
    l=OUTER_DIAMETER-2;
    h=fheight;
    //translate([0,0,h/2]) cube([w,l,h], center=true);
    translate([0,0,0]) cylinder(r=KNURL_RADIUS+0.25, h=h, $fn=40);
}