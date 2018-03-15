// Coloring based on Smallest-last order

void CreateSLOList(){
      int CliqueDegree = 0;
      int min = MinDegree;
      int tag = 1;
      int TDegree = totalDegree;
      int n = Num;
      //DrawRemains();
      System.out.println("\n\nStarts here:");
    
lable:for(int i = MinDegree; i <= MaxDegree && DL.size()>1; i++) {
        //System.out.println("\n\n\nSize of the degree list is: " + DL.size());
        //System.out.println("Now in degree : " + i);
            /*Determin the Max degree when delete.*/
            if(i > MaxDuringDel) {MaxDuringDel = i;}
            tag = 1;
            min = i;
            /*Get every point of this degree*/
            while(DL.containsKey(i) && DL.get(i).Next != null) {
                Point toBeDeleted = DL.get(i).Next;
                toBeDeleted.Prev.Next = toBeDeleted.Next;
                if(toBeDeleted.Next != null)
                    toBeDeleted.Next.Prev = toBeDeleted.Prev;
                if(DL.get(i).Next == null)  DL.remove(i);
                //System.out.println("\nPoint to be deleted is: " + toBeDeleted.id);
                SLOrder.add(toBeDeleted);  // Add a point to SLO list.
                //System.out.println(toBeDeleted.degree);
                for(int k = 0; k < toBeDeleted.AdjPoints.size(); k++) {
                     /*remove every adjpoints from DegreeList and add it to degree-1*/
                    //System.out.println("Point to be move is :" + toBeDeleted.AdjPoints.get(k).id); 
                    Point toBeMoved = toBeDeleted.AdjPoints.get(k);
                                                            
                    // A point that has already been deleted.
                    if(toBeMoved.Next == null && toBeMoved.Prev == null){
                        continue;
                    }
                    int degree = toBeMoved.getDIL();
                    if(DL.containsKey(degree)) {
                       // O(1)
                       toBeMoved.Prev.Next = toBeMoved.Next;
                       if(toBeMoved.Next != null)
                           toBeMoved.Next.Prev = toBeMoved.Prev;
                        else toBeMoved.Prev.Next = null;
                       toBeMoved.setDIL(toBeMoved.getDIL()-1);    
                       //System.out.println(degree + " to " + (degree-1));
                       if(DL.containsKey(degree - 1)){
                           toBeMoved.Next = DL.get(degree - 1).Next;
                           toBeMoved.Prev = DL.get(degree - 1);
                           if(DL.get(degree - 1) == null) System.out.println("!!!!!!!!!!!!!!!!!!!!");
                           if(DL.get(degree - 1).Next == null) System.out.println("???????");
                           if(DL.get(degree - 1).Next.Prev == null) System.out.println("+++++++++++++");
                           
                           DL.get(degree - 1).Next.Prev = toBeMoved;
                           DL.get(degree - 1).Next = toBeMoved;
                       }
                        else {
                           Point headPoint = new Point(0,0,0,-1); 
                           headPoint.Next = toBeMoved;
                           toBeMoved.Next = null;
                           toBeMoved.Prev = headPoint;
                           DL.put(degree-1, headPoint);
                           //System.out.println("New I is : " + (degree - 1));
                        }
                        if(degree - 1 < min) {
                           //System.out.println("Minimun degree is : " + (degree - 1));
                           min = degree - 1;  // min = Smallest degree in list
                           tag = 0;
                        }
                     }      
                     // Remove a degree if when go through a point's adj list a degree becomes empty.
                     if(DL.get(degree).Next == null){
                        DL.remove(degree);
                     }
                }
                n--;
                TDegree -= (toBeDeleted.getDIL() * 2);
                float avg = (float) TDegree / n; 
                DegAfterDel.addFirst(avg);
                
                /*Delete this Point from DL*/
                toBeDeleted.Next = null;
                toBeDeleted.Prev = null;
               
                //DrawRemains();
                
                //System.out.println("\nAfter delete point #" + toBeDeleted.id);
                if(tag ==0){
                    i = min - 1;
                    continue lable;
                }
            }
        // Delete a degree when go over all points in a degree.
        DL.remove(i);
     }       
     for(int i = MinDegree; i <= MaxDegree; i++) {
         if(DL.containsKey(i)) {
             CliqueDegree = i;
             break;
         }
     }     
     //Remain a clique, degree is CliqueDegree
     System.out.println("\nColoring Info:" + "\nCliqueDegree is :" + CliqueDegree);
     int CliqueSize = CliqueDegree + 1;
     CS = CliqueSize;
     System.out.println("CliqueSize is :" + CliqueSize); 
     Point temp = DL.get(CliqueDegree).Next;
     while(temp != null){
         SLOrder.add(temp);
         temp = temp.Next;
     }
     System.out.println("The size of the SLOrder is: " + SLOrder.size());  //Should be Num.
     System.out.println("The Max Degree when delete is: " + MaxDuringDel);
}

void Coloring(){
    long t1 = System.currentTimeMillis();    
    CreateSLOList();
    long t2 = System.currentTimeMillis();
    int size = SLOrder.size();
    int tag = 0;
    
    for(int i = size - 1; i >= 0; i--) {
        tag = 0;
        //System.out.println("\nThe Point coloring now is: #" + SLOrder.get(i).id + ", it's adjacent points' colors are: ");
        for(int j = 0; j < SLOrder.get(i).AdjPoints.size(); j++) {
            if(SLOrder.get(i).AdjPoints.get(j).getColor() != 0) {
                //System.out.print("#" + SLOrder.get(i).AdjPoints.get(j).id + " color is " + SLOrder.get(i).AdjPoints.get(j).getColor() + ".  ");
                CidSet.set(SLOrder.get(i).AdjPoints.get(j).getColor(), 1);
            }
        }
        // need to give this point a color.
        for(int k = 1; k < CidSet.size(); k++) {
            if(CidSet.get(k) == 0 && tag == 0) {    //find the first position that equals 0.
               SLOrder.get(i).setColor(k);
               //System.out.println("\nChoose color: " + k);
               tag = 1;
            }
            CidSet.set(k, 0);
        }
        if(tag == 0) {
            CidSet.add(0);
            SLOrder.get(i).setColor(CidSet.size() - 1);
            CidSet.set(0, CidSet.size() - 1);    
        }
    }

    System.out.println("Number of colors used is: " + (CidSet.size()-1));
    System.out.println("\nTime Info:" + "\nWithin Coloring step, time used in SLO generating step is: " + (t2 - t1) + "ms.");  
    long t3 = System.currentTimeMillis();
    System.out.println("Within Coloring step, time used in coloring step is: " + (t3 - t2) + "ms.");      
    System.out.println("Time used in whole Coloring step is: " + (t3 - t1) + "ms.");
    
    for(int i = size - 1; i >= 0; i--) {
        ColorDistribute[SLOrder.get(i).getColor()] ++;
    }    
    
    try{
        String pathName = "/Users/lionel/Desktop/Color.txt";
        File Writename = new File(pathName);
        Writename.createNewFile();
        BufferedWriter out  = new BufferedWriter(new FileWriter(Writename));
        for(int i = 1; i <= CidSet.get(0);i ++){
            String write = Integer.toString(ColorDistribute[i]);
            out.write(write + '\n');
            out.flush();
            //System.out.println("The number of color " + i + " has is: " + ColorDistribute[i]);
        }
        out.close();
    } catch(Exception e) {
            e.printStackTrace();
    }
    //WriteToFile();
}

void WriteToFile(){
    int size = SLOrder.size();    
    //Write Original degree to file.
    try {
        String pathName = "/Users/lionel/Desktop/Original.txt";
        File Writename = new File(pathName);
        Writename.createNewFile();
        BufferedWriter out = new BufferedWriter(new FileWriter(Writename));
        for(int i = size - 1; i >= 0; i--) {
            String write = Float.toString(SLOrder.get(i).degree);
            out.write(write + '\n');
            out.flush();
        }
        out.close();
    } catch(Exception e) {
            e.printStackTrace();
    }
    //Write deleted degree to file.
    try {
        String pathName = "/Users/lionel/Desktop/Deleted.txt";
        File Writename = new File(pathName);
        Writename.createNewFile();
        BufferedWriter out = new BufferedWriter(new FileWriter(Writename));
        for(int i = size - 1; i >= 0; i--) {
            String write = Integer.toString(SLOrder.get(i).getDIL());
            out.write(write + '\n');
            out.flush();
        }
        out.close();
    } catch(Exception e) {
            e.printStackTrace();
    }
    //Write deleted degree to file.
    try {
        String pathName = "/Users/lionel/Desktop/Average.txt";
        File Writename = new File(pathName);
        Writename.createNewFile();
        BufferedWriter out = new BufferedWriter(new FileWriter(Writename));
        out.write("0\n");
        out.flush();
        for(int i = 0; i < CS -1; i++) {
            String write = Integer.toString(i);
            out.write(write + '\n');
            out.flush();
        }
        while(DegAfterDel.size()>0){
            float avg = DegAfterDel.pop();
            String write = Float.toString(avg);
            out.write(write + '\n');
            out.flush();            
        }
        out.close();
    } catch(Exception e) {
            e.printStackTrace();
    }
}

void DrawRemains() {
    for(int i = 0; i <= MaxDegree; i ++){
        if(DL.containsKey(i)) {
            System.out.println("\nDegree is : " + i + ", points in this degree are: ");
            for(Point toPrint = DL.get(i).Next; toPrint != null; toPrint = toPrint.Next) {
                System.out.print("#" + toPrint.id);
            }
        }
    }
}