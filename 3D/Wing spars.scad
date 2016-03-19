module wingEdge(startchord,endchord,leadingEdgeThickness,trailingEdgeThickness,thickness){
    mainWingLength = startchord-(leadingEdgeThickness);
    linear_extrude(height = thickness, convexity = 100, twist = 0,scale=[endchord/startchord,1-0.005*(abs(endchord-startchord))]){
    
    translate([mainWingLength,0,0]){
        scale([2,1,1,]){
    intersection(){
    square(leadingEdgeThickness,[0,0,0]);
    circle(r=leadingEdgeThickness);
    
}
}
    polygon(points=[[0,0],[0,leadingEdgeThickness],[-mainWingLength,trailingEdgeThickness],[-mainWingLength,0]]);
}
}
}
//6.4inches wide
//1.16 inches at wing edge
//2.15inches at wing middle
//front flat section at 0.2inches from center line
module wingsection(sliceThickness,startChord,endChord){

    wingthickness = 2;//mm
    leadingEdgeChord = 5;
    trailingEdgeChord = 2;
    translate([-wingthickness,0,0]){
    wingEdge(startChord+wingthickness*2,endChord+wingthickness*2,leadingEdgeChord+wingthickness,trailingEdgeChord+wingthickness,sliceThickness);
    }
}

module basicWingHalf(){
    wingCentre = 2.15*25.4;
    wingEdge = 1.16*25.4;
    winglength = 3.0*25.4;
    wingCentreLength = 0.2*25.4;
translate([0,0,0.2*25.4]){
    wingsection(winglength,wingCentre,wingEdge);
}
    wingsection(wingCentreLength,wingCentre,wingCentre);
}

//0.15in to 1.85in

module wingHalf(){
    offset = (3.2-1.85)*25.4;
    thickness = 2;
    length = 25.4*(1.85-0.15);
    difference(){
        union(){ 
            basicWingHalf();
            translate([-1,0,offset]){
                cube([5,4,length+2*thickness]);
            }
         }
        translate([-2*thickness,-thickness,offset+thickness]){
            cube([6,12,length]);
        }
    }
    
    
    
}

module copy_mirror(vec) 
{ 
    children(); 
    mirror(vec) children(); 
} 



//copy_mirror([0,1,0]){
//copy_mirror([0,0,1]){
//    wingHalf();
//}
//}
//wingspan = 6.4*25.4;
//thickness = 3;//mm
//cube([50,50,(wingspan/4)-thickness]);
difference(){
difference(){
    {
copy_mirror([0,1,0]){
copy_mirror([0,0,1]){
    wingHalf();
}
}
}
{
    wingspan = 6.4*25.4;
    thickness = 3;//mm
    for (i = [1:1:4]){
        translate([-10,-25,thickness-wingspan/2+((i-1)*(wingspan-thickness)/4)]){
        cube([100,50,(wingspan/4)-(thickness)]);
        }
        
    }
}
}
translate([-50,-0.6,-100]){
cube([100,1.2,200]);
}
}



