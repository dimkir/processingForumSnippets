/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Cube Limit Series - Inward" by Manfred Mohr
Originally published in "Computer Graphics and Art" vol1 no2, 1976
Copyright (c) 2012 Calvin Hu - OSI/MIT license (http://recodeproject/license).
*/

int offset = 30;
int interval = 30;
int[] bitPositions = {0, 1, 2, 3, 4, 5, 12};
boolean[] permutation = {true,true,true,true,true,true,false,false,false,false,false,false};

void draw_cube(PGraphics pg, int slength, boolean[] permutation){
  int side = slength/2;
  int start_point = -side;
  if(permutation[0])
    pg.line(start_point, start_point, start_point, start_point, start_point, side);
  if(permutation[1])
    pg.line(start_point, start_point, start_point, start_point, side, start_point);
  if(permutation[2])
    pg.line(start_point, start_point, start_point, side, start_point, start_point);
  if(permutation[3])
    pg.line(start_point, start_point, side, start_point, side, side);
  if(permutation[4])
    pg.line(start_point, start_point, side, side, start_point, side);
  if(permutation[5])
    pg.line(start_point, side, start_point, side, side, start_point);
  if(permutation[6])
    pg.line(start_point, side, start_point, start_point, side, side);
  if(permutation[7])
    pg.line(side, start_point, start_point, side, side, start_point);
  if(permutation[8])
    pg.line(side, start_point, start_point, side, start_point, side);
  if(permutation[9])  
    pg.line(side, side, start_point, side, side, side);
  if(permutation[10])
    pg.line(side, start_point, side, side, side, side);
  if(permutation[11])
    pg.line(start_point, side, side, side, side, side);
}

boolean[] swap_boolean_array(boolean[] boolArr, int indexFrom, int indexTo){
  boolean temp = boolArr[indexTo];
  boolArr[indexTo] = boolArr[indexFrom];
  boolArr[indexFrom] = temp;
  return boolArr;
}

boolean nextPermutation(){
   for(int i = 5; i >= 0; i--){
     if(bitPositions[i] + 1 < bitPositions[i + 1]){
       permutation = swap_boolean_array(permutation, bitPositions[i], ++bitPositions[i]);
       if(i < 5){
         for(int j = i + 1 ; j < 6; j++){
           permutation = swap_boolean_array(permutation, bitPositions[j], bitPositions[j - 1] + 1);
           bitPositions[j] = bitPositions[j - 1] + 1;
         } 
       }
       return true;
     }
   }
   return false;
}

void setup(){
    size(990, 990);
    beginRaw(PDF, "something.pdf");
    ortho();
    background(0);
    noFill();
    stroke(255);
    for(int i = 0; i < 32; i++){
      int columnX = offset + i * interval;
      line(columnX, offset, columnX, height - offset);
    }
    for(int i = 0; i < 32; i++){
      int rowY = offset + i * interval;
      line(offset, rowY, width - offset, rowY);
    }
    
    
    boolean anyPermsLeft = true;
    pushMatrix();
    translate(32 * interval + offset/2, offset/2);
    for(int i = 0; i < 31 & anyPermsLeft; i++){
      translate(-interval, 0);
      pushMatrix();
      for(int j = 0; j < 31 & anyPermsLeft; j++){
          translate(0, interval);
          pushMatrix();
          rotateX(PI * 5/6);
          rotateY(PI * -5/6);
          draw_cube(g, 15, permutation);
          anyPermsLeft = nextPermutation();
          popMatrix();
      }
      popMatrix();
    }
    popMatrix();
}

void draw(){
}
