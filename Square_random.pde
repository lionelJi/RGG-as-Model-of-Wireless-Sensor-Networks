import java.util.*;
import java.math.*;
import java.io.*;

color[] styleyou = {#D9C6B0, #314650, #2D4761, #45718C, #B6E1F2};
color[] lineColor = styleyou;

int Num = 256000;
Point [] Points = new Point[Num];
int avgD = 64;
int SqWidth = 700;
int SqHeight = 700;
float PI = 3.14159265;
double R = Math.sqrt(SqWidth*SqHeight*(avgD+1) / (Num*PI));
int cNum = (int)(SqWidth/R) + 1;  
//Degree Info
int totalDegree = 0;
float avgDegree = 0;
int MaxDuringDel = 0;

//Cell structure
Map<Integer, ArrayList<Point>> Cells = new HashMap<Integer, ArrayList<Point>>();

//Degree Distribute
int MinDegree = Num;
int MaxDegree = 0;
List<Point> SLOrder = new ArrayList<Point>();
Map<Integer, Point> DL = new HashMap<Integer, Point>();

int CS = 0;
Deque<Float> DegAfterDel = new LinkedList<Float>();

//Color ID set
ArrayList<Integer> CidSet = new ArrayList<Integer>();
int[] ColorDistribute = new int[Num];

//Backbone
int[] BackboneColor = new int[4];
int[] BENum = new int[6];
List<Map<Point, Integer>> BMap = new ArrayList<Map<Point, Integer>>();

int[] Size = new int[2];
int[] Tag = new int[2];

void setup() {
  size(950, 770);
  smooth();
  background(#0C2550);
  //DrawButton(); 
  DrawSquare();
  noLoop();
}

void draw() {
  System.out.println("col: " + cNum + ", R: " + R/SqWidth + "\n");
  noLoop();
  stroke(0);
  strokeWeight(3);
  long t1 = System.currentTimeMillis();
  DrawDots();
  SquareLine(); //<>//
  DegreeInfo();
    //DrawDisk(1);
  // Initialize the num of colors as 0.
  CidSet.add(0);  // Initialize the num of colors as 0.
  Coloring();
  CreateBackbone();
  long t2 = System.currentTimeMillis();
  System.out.println("Time used in the whole procedure is: " + (t2 - t1) + "ms.");
}