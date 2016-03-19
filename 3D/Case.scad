module wingEdge(startchord,endchord,leadingEdgeThickness,trailingEdgeThickness,thickness){
    mainWingLength = startchord-(leadingEdgeThickness);
    linear_extrude(height = thickness, convexity = 100, twist = 0,scale=[endchord/startchord,1-0.005*(abs(endchord-startchord))]){
    translate([mainWingLength,0,0]){
    intersection(){
    square(leadingEdgeThickness,[0,0,0]);
    circle(r=leadingEdgeThickness);
    
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
    

difference(){
    wingthickness = 1;//mm
    leadingEdgeChord = 5;
    trailingEdgeChord = 3;
    translate([-wingthickness,0,0]){
    wingEdge(startChord+wingthickness*2,endChord+wingthickness*2,leadingEdgeChord+wingthickness,trailingEdgeChord+wingthickness,sliceThickness);
    }
    {

    wingEdge(startChord,endChord,leadingEdgeChord,trailingEdgeChord,sliceThickness+2);
        mirror([0,1,0]){
            wingEdge(startChord,endChord,leadingEdgeChord,trailingEdgeChord,sliceThickness+2);
        }
    }
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
    thickness = 1;
    length = 25.4*(1.85-0.15);
    difference(){
        union(){ 
            basicWingHalf();
            translate([-1,0,offset]){
                cube([5,4,length+2*thickness]);
            }
         }
        translate([-2*thickness,-thickness,offset+thickness]){
            cube([5,12,length]);
        }
    }
    
    
    
}

rotate([0,0,177.5]){
wingHalf();
mirror([0,0,1]){
    wingHalf();
}
}


