// DrawDots

void DrawDots() {
  for(int i = 0; i < Num; i ++){
    point(Points[i].x, Points[i].y);
    //System.out.println("x: " + Points[i].x + ", y: " + Points[i].y);
  }
}