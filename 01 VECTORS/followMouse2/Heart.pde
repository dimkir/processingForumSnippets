class Heart extends PVector
{
   
   private float minRadius = 10;
   private float maxRadius = 50;
   
   /**
   * These variables will be used for pulsing.
   */
   private float angle = 0;
   private float angleStep = 3.14 / (90.0);
   
   
   void step(){
      angle += angleStep;
   }
   
   
   void run(){
      step();
      draw();
   }
   
   void draw(){
      fill(255);
      noStroke();
      float r = minRadius + maxRadius * sin(angle);
      r = abs(r);
      println(r);
      ellipse(x, y,  r, r);
   }
   
}
