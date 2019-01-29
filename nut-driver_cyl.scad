d=7.75; //measured
doffset=0.2;
outer=11;

flathead=1.25;
foffset=0.0;
fheight=4;
fbase=0;

nheight=0.0;
nwidth=0.9;

htransfer=3;
dgrip=4.5;
dgrip_offset=0.2;
hgrip=4;

union() { 
    
    // cylinder cutout of outer hexagon  
    difference() {
      translate([0,0,-nheight]) cylinder(r=outer/2,h=fheight+fbase,$fn=6);
      translate([0,0,-nheight]) cylinder(r=((d+doffset)/2),h=fheight+nheight,$fn=40);
      //cube(50,50,50);
    }
    
    // gradient cylinder instead of nubs
    difference() {
      tightener();
      cylinder(r1=((d+doffset)/2)-nwidth+1,r2=((d+doffset)/2)-nwidth,h=fheight+nheight,$fn=40);
    }
        
    // transfer + grip
    translate([0,0,-nheight+fheight+fbase]) cylinder(r1=outer/2,r2=(dgrip/2)+dgrip_offset,h=htransfer,$fn=6);
    translate([0,0,-nheight+fheight+fbase+htransfer]) cylinder(r=(dgrip/2)+dgrip_offset,h=hgrip,$fn=6);
};

module tightener() {
    w=flathead-foffset;
    l=outer-2;
    h=fheight-nheight;
    //translate([0,0,h/2]) cube([w,l,h], center=true);
    translate([0,0,0]) cylinder(r=((d+doffset)/2)+0.25, h=h, $fn=40);
}