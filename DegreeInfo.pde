// DegreeInfo: Calculate the degree information

void DegreeInfo() {
  int MaxTag = 0;
  int MinTag = 0;
 
  for(int i = 0; i < Num; i++) {
      int d = (int)Points[i].degree;
      /*
        Update Degree List.
        Insert from Beginning.
      */
      if(DL.containsKey(d)) {
          DL.get(d).Next.Prev = Points[i];
          Points[i].Next = DL.get(d).Next;
          Points[i].Prev = DL.get(d);
          DL.get(d).Next = Points[i];
      } else {
          Point headPoint = new Point(0, 0, 0, -1);
          headPoint.Next = Points[i];
          Points[i].Prev = headPoint;
          Points[i].Next = null;
          DL.put(d, headPoint);
      }
      // Set Point's degree in Degree List
      Points[i].setDIL(d);
      // Calculate Degree Info of the whole graph
      totalDegree += d;
      if(d > MaxDegree){
         MaxDegree = d;
         MaxTag = i;
      }
      if(d < MinDegree) {
         MinDegree = d;
         MinTag = i;
      }
  }
  avgDegree = (float)totalDegree / Num;
  float dif = (float)(avgD - avgDegree);
  
 System.out.println("Total degree is: " + totalDegree + ", avgDegree is: " + avgDegree + 
                      "\nThe difference with estimate is: " + dif);
 System.out.println("The point with biggest degree is: Point#" + MaxTag + ", it's degree is: "+ MaxDegree);
 System.out.println("The point with smallest degree is: Point#" + MinTag + ", it's degree is: "+ MinDegree);
 
/*
 ellipseMode(CENTER);
 fill(#EA0000, 500);
 ellipse(Points[MaxTag].x, Points[MaxTag].y, (float)R, (float)R);
 fill(#000000, 500); 
 ellipse(Points[MinTag].x, Points[MinTag].y, (float)R, (float)R); 
 */
}