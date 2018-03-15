// DrawSquare

void DrawSquare() {
  //bottom,top&left margin of 35px.
  fill(255);
  stroke(0);
  strokeWeight(1);
  rectMode(CENTER);
  int xMin = width - SqWidth - (height-SqHeight)/2;
  int xMax = width - (height-SqHeight)/2;
  int yMin = (height-SqHeight)/2, yMax = (height+SqHeight)/2;
  
  rect(width - SqWidth/2 - (height-SqHeight)/2 , height/2, SqWidth, SqHeight);


  for(int i = 0; i < Num; i ++){
    //Create a point.
    Points[i] = new Point(random(xMin, xMax), random(yMin, yMax), 0, i);
    
    //Calculate CellId of a Point
    int x =(int)((Points[i].x - xMin) / R), y = (int)((Points[i].y - yMin) / R);
    int cellId = y * cNum + x;
    //System.out.println(Points[i].x + ", " + Points[i].y + ", " + x + ", " + y + ", CellId: " + cellId);
    
    //Add point to Cells
    if(Cells.containsKey(cellId)){
      Cells.get(cellId).add(Points[i]);
    } else {
      ArrayList<Point> temp = new ArrayList<Point>();
      temp.add(Points[i]);
      Cells.put(cellId, temp);
    }
  } 
}