abstract static class AbstractSketch
{
   AbstractSketch(PApplet sketch){
       this.setup(sketch.width, sketch.height, sketch.g);
   }
   
  abstract void setup(int givenWidth, int givenHeight, PGraphics pg);   
  abstract void draw(PGraphics pg);
   
}
