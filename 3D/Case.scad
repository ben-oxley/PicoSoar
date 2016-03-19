module wingEdge(startchord,endchord,leadingEdgeThickness,trailingEdgeThickness,thickness){
    mainWingLength = startchord-(leadingEdgeThickness);
    linear_extrude(height = thickness, convexity = 10, twist = 0,scale=[endchord/startchord,1]){
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
    translate([-wingthickness,0,0]){
    wingEdge(startChord+wingthickness*2,endChord+wingthickness*2,5+wingthickness,3+wingthickness,sliceThickness);
    }
    {

    wingEdge(startChord,endChord,5,3,sliceThickness+2);
        mirror([0,1,0]){
            wingEdge(startChord,endChord,5,3,sliceThickness+2);
        }
    }
}
}

module wingHalf(){
translate([0,0,0.2*25.4]){
    wingsection(3.0*25.4,2.15*25.4,1.16*25.4);
}
    wingsection(0.2*25.4,2.15*25.4,2.15*25.4);
}

wingHalf();
mirror([0,0,1]){
    wingHalf();
}

