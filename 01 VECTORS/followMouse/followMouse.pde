/**
* This sketch shows how to use vectors to implement
* target following.
*  
*/

float speed = 0.6; // 5px



PVector missile = new PVector();
PVector target = new PVector();


void setup(){
   size(400,400);
}

void draw(){
  
  fadeScreen(125);
  
  target.set(mouseX, mouseY); // to make it more fun, target is at mouse coords
  
  
  
  PVector direction = PVector.sub(target, missile);
  direction.normalize();
  
  PVector stepTowardsTarget = PVector.mult(direction, speed);
  
  missile.add(stepTowardsTarget);
  
  
  drawCircle(target);
  
  drawRect(missile);
  
}


void drawCircle(PVector v){
   fill(255);
   ellipse(v.x, v.y, 20, 20);

}

void drawRect(PVector v){
   fill(#FF0000);
   pushMatrix();
   translate(v.x, v.y);
   rectMode(CENTER);
   rotate(map(v.x, 0, width, 0, TWO_PI ));
   rect(0, 0, 30,30);
   popMatrix();
}



void fadeScreen(int val){
    fill(0, val);
    rectMode(CORNER);
    rect(0,0, width, height);
}
