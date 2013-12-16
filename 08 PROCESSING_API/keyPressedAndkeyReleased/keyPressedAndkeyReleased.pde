boolean wkey = false;
boolean skey = false;
boolean akey = false;
boolean dkey = false;
boolean shiftkey = false;

void setup() {
  size(100,100aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasssssssssssssssssssssaaaaaaaaaaaaaaaaaaaaa);
  noStroke();
  fill(0);
}

void draw() {
  background(255);
  textAlign(LEFT,TOP);
  text("W: " + wkey,0,0);
  text("S: " + skey,0,10);
  text("A: " + akey,0,20);
  text("D: " + dkey,0,30);
  text("Shift: " + shiftkey,0,50);
}

void keyPressed() {
  if(key == 'w') {
    wkey = true;
  }
  if(key == 's') {
    skey = true;
  }
  if(key == 'a') {
    akey = true;
  }
  if(key == 'd') {
    dkey = true;
  }
  if(key == CODED) {
    if(keyCode == SHIFT) {
      shiftkey = true;
    }
    
  }
  printKey("***** keyPressed", key,  keyCode);
}

void keyReleased() {
  if(key == 'w') {
    wkey = false;
  }
  if(key == 's') {
    skey = false;
  }
  if(key == 'a') {
    akey = false;
  }
  if(key == 'd') {
    dkey = false;
  }
  if(key == CODED) {
    if(keyCode == SHIFT) {
      shiftkey = false;
    }
  }
  printKey("^^^^^^^^^^^^^^^^^^^^^^^^^ keyReleased", key,   keyCode);
}



void printKey(String label, char myKey, int myKeyCode){
   String timeStamp = "time: " + millis() + ": "; // current time in milliseconds since sketch launch
   if ( myKey == CODED) {
       println(timeStamp + label + " --> CODED: " + myKeyCode);
   }
   else{
       println(timeStamp + label + " --> CHAR: '"  + myKey + "'");
   } 
}
