// Draw Button 

void DrawButton() {
  rectMode(CORNER);
  fill(255);
  rect(45, 35, 125, 50);
  textSize(20);
  textAlign(CENTER, CENTER);
  fill(0);
  text("Square", 107.5, 60);
  fill(255);
  rect(45, 100, 125, 50);
  textSize(20);
  textAlign(CENTER, CENTER);
  fill(0);
  text("Disk", 107.5, 125); 
}