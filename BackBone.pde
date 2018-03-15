// Create two largest backbones.

void CreateBackbone() {
    long t1 = System.currentTimeMillis();
    // maxTag: color# with max distribution.
    // Initiate BackboneColor with 4 biggest distribution.
    for(int k = 1, maxSize = 0, maxTag = 0; k <= 4; k++, maxSize = 0, maxTag = 0){
        for(int i = 1; i <= CidSet.get(0); i++) {
            if(ColorDistribute[i] > maxSize) {
                maxSize = ColorDistribute[i];
                maxTag = i;
            }
        }
        ColorDistribute[maxTag] = 0;
        BackboneColor[k-1] = maxTag;
    }
    
    // Init all the Networks.
    for(int i = 0; i < 6; i ++)
        BMap.add(new HashMap<Point, Integer>());
        
    // Go through all the point(edges) and find 6 biggest amount of edges.  O(E)
    for(int i = 0; i < Num; i ++) {
        if(Points[i].c == BackboneColor[0]) {
            BMap.get(0).put(Points[i], -1); 
            BMap.get(1).put(Points[i], -1);
            BMap.get(2).put(Points[i], -1);
            for(int j = 0; j < Points[i].AdjPoints.size(); j++) {    
                if(Points[i].AdjPoints.get(j).c == BackboneColor[0]) { 
                    Points[i].degreeInBB[0] += 0.5;   Points[i].AdjPoints.get(j).degreeInBB[0] += 0.5;
                    Points[i].degreeInBB[1] += 0.5;   Points[i].AdjPoints.get(j).degreeInBB[1] += 0.5;
                    Points[i].degreeInBB[2] += 0.5;   Points[i].AdjPoints.get(j).degreeInBB[2] += 0.5;
                 }                
                if(Points[i].AdjPoints.get(j).c == BackboneColor[1])  { 
                    Points[i].degreeInBB[0]++; 
                    Points[i].AdjPoints.get(j).degreeInBB[0] ++;  
                }              
                if(Points[i].AdjPoints.get(j).c == BackboneColor[2])  {
                    Points[i].degreeInBB[1]++; 
                    Points[i].AdjPoints.get(j).degreeInBB[1]++;  
                }              
                if(Points[i].AdjPoints.get(j).c == BackboneColor[3])  { 
                    Points[i].degreeInBB[2]++; 
                    Points[i].AdjPoints.get(j).degreeInBB[2]++;  
                }              
            }
        } else if(Points[i].c == BackboneColor[1]) {
            BMap.get(0).put(Points[i], -1);
            BMap.get(3).put(Points[i], -1);
            BMap.get(4).put(Points[i], -1);
            for(int j = 0; j < Points[i].AdjPoints.size(); j++) {
                if(Points[i].AdjPoints.get(j).c == BackboneColor[1]) { 
                    Points[i].degreeInBB[0] += 0.5;   Points[i].AdjPoints.get(j).degreeInBB[0] += 0.5;
                    Points[i].degreeInBB[3] += 0.5;   Points[i].AdjPoints.get(j).degreeInBB[3] += 0.5;
                    Points[i].degreeInBB[4] += 0.5;   Points[i].AdjPoints.get(j).degreeInBB[4] += 0.5;
                }              
                if(Points[i].AdjPoints.get(j).c == BackboneColor[2]) {
                    Points[i].degreeInBB[3]++;
                    Points[i].AdjPoints.get(j).degreeInBB[3]++;                
                }
                if(Points[i].AdjPoints.get(j).c == BackboneColor[3]) {
                    Points[i].degreeInBB[4]++;
                    Points[i].AdjPoints.get(j).degreeInBB[4]++;                
                }
            }
        } else if(Points[i].c == BackboneColor[2]) {
            BMap.get(1).put(Points[i], -1);
            BMap.get(3).put(Points[i], -1);           
            BMap.get(5).put(Points[i], -1);
            for(int j = 0; j < Points[i].AdjPoints.size(); j++) {
                if(Points[i].AdjPoints.get(j).c == BackboneColor[2]) { 
                    Points[i].degreeInBB[1] += 0.5;   Points[i].AdjPoints.get(j).degreeInBB[1] += 0.5;
                    Points[i].degreeInBB[3] += 0.5;   Points[i].AdjPoints.get(j).degreeInBB[3] += 0.5;
                    Points[i].degreeInBB[5] += 0.5;   Points[i].AdjPoints.get(j).degreeInBB[5] += 0.5;
                }           
                if(Points[i].AdjPoints.get(j).c == BackboneColor[3]) {
                    Points[i].degreeInBB[5]++;
                    Points[i].AdjPoints.get(j).degreeInBB[5]++;                       
                }
            }
        } else if(Points[i].c == BackboneColor[3]) {
            BMap.get(2).put(Points[i], -1);
            BMap.get(4).put(Points[i], -1);           
            BMap.get(5).put(Points[i], -1);          
            for(int j = 0; j < Points[i].AdjPoints.size(); j++) {
                if(Points[i].AdjPoints.get(j).c == BackboneColor[3]) { 
                    Points[i].degreeInBB[2] += 0.5;   Points[i].AdjPoints.get(j).degreeInBB[2] += 0.5;
                    Points[i].degreeInBB[4] += 0.5;   Points[i].AdjPoints.get(j).degreeInBB[4] += 0.5;
                    Points[i].degreeInBB[5] += 0.5;   Points[i].AdjPoints.get(j).degreeInBB[5] += 0.5;
                }
            }
        }
    }    
    // Delete tails and not-major components.
    Modify();
    // Determine the two backbones.
    BackboneJudge();
    // Calculate the domination percentage of the two backbone.
    Domination();
    long t2 = System.currentTimeMillis();
    System.out.println("Time used in whole Backbone Creating step is: " + (t2 - t1) + "ms.");
}

void Modify(){  
  for(int i = 0; i <= 5; i ++) {
      int flag = 0;
      int count = 0;
      // Delete tails.    
      //System.out.println("In #" + (i+1) + " bipartite partition:");    
      //System.out.println("Original size is: " + BMap.get(i).size());       
      do {
          flag = 0;
          Set<Point> Set1 = new HashSet<Point>(BMap.get(i).keySet());
          for(Point P : Set1) {
              if(P.degreeInBB[i] <= 1){
                  // The one it adjacent with degree - 1.
                  for(Point Q : P.AdjPoints) {
                      if(BMap.get(i).containsKey(Q)) {
                          Q.degreeInBB[i]--;
                      }
                  }
                  // Remove this point.
                  BMap.get(i).remove(P);
                  flag = 1;
              }
          }
      } while(flag == 1);
      //System.out.println("After delete tails, modified size is: " + BMap.get(i).size());        

      // Delete other components.  BFS.   <Point, Integer> Integer: -1: white  0: grey  tag: black 
      int tag = 0;
      Point start = new Point(0,0,0,0);
      List<Integer> componentSize = new ArrayList<Integer>();
      componentSize.add(tag, 0);
      Deque<Point> BFSQueue = new LinkedList<Point>();
      do {
          flag = 0;
          tag++;
          // Size of component #'tag'.
          componentSize.add(tag, 0);
          componentSize.set(0, componentSize.get(0) + 1);  // How many components are there.
          Set<Point> Set2 = new HashSet<Point>(BMap.get(i).keySet());
          for(Point P : Set2) {
              if(BMap.get(i).get(P) == -1) {
                  flag = 1;
                  start = P;
                  break;
              }
          }
          if (flag == 1) {
              BMap.get(i).put(start, 0);
              BFSQueue.push(start);
              while(BFSQueue.size() > 0) {
                  Point temp = BFSQueue.pop();
                  for(Point Neighbor : temp.AdjPoints) {
                      if(BMap.get(i).containsKey(Neighbor)) {
                          if(BMap.get(i).get(Neighbor) == -1) {
                              BMap.get(i).put(Neighbor, 0);
                              BFSQueue.push(Neighbor);
                          }
                      }
                  }
                  BMap.get(i).put(temp, tag);
                  componentSize.set(tag, componentSize.get(tag) + 1);
              }
          }          
      } while(flag == 1);
      
      int maxSize = 0, maxTag = 0;
      for(int h = 1; h < componentSize.get(0); h ++) {
          if(componentSize.get(h) > maxSize) {
              maxSize = componentSize.get(h);
              maxTag = h;
          }
          //System.out.println("Component #" + h + " have a size of " + componentSize.get(h));
      }
      count = 0;
      Set<Point> Set3 = new HashSet<Point>(BMap.get(i).keySet());
      for(Point P : Set3) {
          if(BMap.get(i).get(P) != maxTag) 
              BMap.get(i).remove(P);
          else
              count += P.degreeInBB[i];
      }
      //System.out.println("After delete small components, modified size is: " + BMap.get(i).size() + "\n");     
      BENum[i] = count/2;
  }
}

void BackboneJudge() {
    // Get top 2 as backbones.
    for(int h = 0, max = 0; h <= 1; h++, max = 0){
        for(int i = 0; i < 6; i ++) {
            //System.out.println("Number of Edges in box# " + i + " is: " + BENum[i]); 
            if(BENum[i] > max) {
                max = BENum[i];
                Size[h] = BENum[i];
                Tag[h] = i;
            }
        }
        BENum[Tag[h]] = 0;
    }
    BENum[Tag[0]] = Size[0];
    BENum[Tag[1]] = Size[1];
    
    for(int h = 0; h <= 1; h++){
      System.out.print("The #" + (h+1) + " Backbone is build based on points of color  #");
      switch(Tag[h]) {
          case 0:
              System.out.println(BackboneColor[0] + " and color #" + BackboneColor[1]);
              System.out.println("There's " + BENum[0] + " edges in this backbone.");
              break;
          case 1:
              System.out.println(BackboneColor[0] + " and color #" + BackboneColor[2]);
              System.out.println("There's " + BENum[1] + " edges in this backbone.");
              break;
          case 2:
              System.out.println(BackboneColor[0] + " and color #" + BackboneColor[3]);
              System.out.println("There's " + BENum[2] + " edges in this backbone.");
              break;
          case 3:
              System.out.println(BackboneColor[1] + " and color #" + BackboneColor[2]);
              System.out.println("There's " + BENum[3] + " edges in this backbone.");
              break;
          case 4:
              System.out.println(BackboneColor[1] + " and color #" + BackboneColor[3]);
              System.out.println("There's " + BENum[4] + " edges in this backbone.");
              break;       
          case 5:
              System.out.println(BackboneColor[2] + " and color #" + BackboneColor[3]);
              System.out.println("There's " + BENum[5] + " edges in this backbone.");
              break;        
        }
        System.out.println("The backbone has a size of " + BMap.get(Tag[h]).size());
    }
}

void Domination() {
    float percent;
    for(int h = 0; h <=1; h++) {
        System.out.print("The backbone of #" + (h+1) + " schema ");
        Set<Point> set0 = new HashSet<Point>(BMap.get(Tag[h]).keySet());
        for(Point P : set0) 
            for(Point Q : P.AdjPoints) 
                if (!BMap.get(Tag[h]).containsKey(Q))
                    BMap.get(Tag[h]).put(Q, -2);
        System.out.println(" covers " + BMap.get(Tag[h]).size() + " points."); 
        percent = (float)BMap.get(Tag[h]).size()/ (float)Num;
        System.out.println("Domination percentage is: " + percent*100 + "%");
    }
}