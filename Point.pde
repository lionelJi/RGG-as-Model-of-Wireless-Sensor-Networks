class Point{
   private int   id;
   private float x;
   private float y;
   private float degree;
   private ArrayList<Point> AdjPoints = new ArrayList<Point>();
   public  int c;
   public  int degreeInList;
   public  int degreeInBB[] = new int[6];    // Degree in back bone;
   // Reference from former and latter Point in Degree List
   public Point Next;
   public Point Prev;
  
   Point(float X, float Y, float d, int ID) {
     this.id = ID;
     x = X;
     y = Y;
     degree = d;
     c = 0;  //  0 represent have no color
     degreeInList = 0;
     Prev = null;
     Next = null;
   }
   
   public int getColor() {
       return c;
   }
   
   public void setColor(int C) {
       this.c = C;
   }
   
   public int getDIL() {
       return degreeInList;
   }
   
   public void setDIL(int degree) {
       this.degreeInList = degree;
   }
   
}