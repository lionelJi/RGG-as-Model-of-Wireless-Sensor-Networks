//SquareLine: Draw lines between points.

void SquareLine() {
  long t1 = System.currentTimeMillis();  
  strokeWeight(1);
  
  for(int i = 0; i < (cNum * cNum); i++) {
      if(Cells.containsKey(i)) {
          for(int tag1 = 0; tag1 < Cells.get(i).size(); tag1++) {
              //find in the same cell
              for(int tag2 = 0; tag2 < Cells.get(i).size(); tag2++) {
                if(tag1 != tag2)
                  LineUp(Cells.get(i).get(tag1), Cells.get(i).get(tag2), 0.5);
              }
              //find in the below cell
              if(Cells.containsKey(i + cNum)){
                for(int tag2 = 0; tag2 < Cells.get(i + cNum).size(); tag2++) {
                    LineUp(Cells.get(i).get(tag1), Cells.get(i + cNum).get(tag2), 1);
                }
              }
              if((i+1)%cNum != 0) {
                //find in the next cell
                if(Cells.containsKey(i + 1)){
                  for(int tag2 = 0; tag2 < Cells.get(i + 1).size(); tag2++) {
                      LineUp(Cells.get(i).get(tag1), Cells.get(i + 1).get(tag2), 1);
                  }
                }
                //find in the top of the next cell                
                if(Cells.containsKey(i + 1 - cNum)){
                  for(int tag2 = 0; tag2 < Cells.get(i + 1 - cNum).size(); tag2++) {
                      LineUp(Cells.get(i).get(tag1), Cells.get(i + 1 - cNum).get(tag2), 1);
                  }
                }
                //find in the bottom of the next cell                
                if(Cells.containsKey(i + 1 + cNum)){
                  for(int tag2 = 0; tag2 < Cells.get(i + 1 + cNum).size(); tag2++) {
                      LineUp(Cells.get(i).get(tag1), Cells.get(i + 1 + cNum).get(tag2), 1);
                  }
                }                
              }
          }
      }
  }
  long t2 = System.currentTimeMillis();
  System.out.println("Time used in DrawLine step is: " + (t2 - t1) + "ms."); 
}     

void LineUp(Point p1, Point p2, float flag) {
    //flag and 'if' to avoid duplicate add in the same cell
    if(dist(p1.x, p1.y, p2.x, p2.y) <= R){
      stroke(lineColor[int(random(0,5))]);
      line(p1.x, p1.y, p2.x, p2.y); 
      p1.degree = p1.degree + flag;
      p2.degree = p2.degree + flag;
      if( !p1.AdjPoints.contains(p2) ) { p1.AdjPoints.add(p2); }
      if( !p2.AdjPoints.contains(p1) ) { p2.AdjPoints.add(p1); }
    }
}