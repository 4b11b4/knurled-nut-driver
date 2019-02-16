d=7.75; //measured
doffset=0.3;
outer=12;

flathead=1.25;
foffset=0.0;
fheight=3;
fbase=0;

nheight=0.95;
nwidth=1.25;
htransfer=4;
dgrip=4.5;
dgrip_offset=0.3;
hgrip=3;

union() { 
    
    // cylinder cutout of outer hexagon  
    difference() {
      translate([0,0,-nheight]) cylinder(r=outer/2,h=fheight+fbase,$fn=6);
      translate([0,0,-nheight]) cylinder(r=((d+doffset)/2),h=fheight+nheight,$fn=40);
      //cube(50,50,50);
    }
    
    //nubs
    difference() {
      rectangle();
      cylinder(r=((d+doffset)/2)-nwidth,h=fheight,$fn=30);
    }
    
    
    // transfer + grip
    translate([0,0,-nheight+fheight+fbase]) cylinder(r1=outer/2,r2=dgrip/2,h=htransfer,$fn=6);
    translate([0,0,-nheight+fheight+fbase+htransfer]) cylinder(r=dgrip/2,h=hgrip,$fn=6);
};

module rectangle() {
    w=flathead-foffset;
    l=outer-2;
    h=fheight-nheight;
    translate([0,0,h/2]) cube([w,l,h], center=true);
}