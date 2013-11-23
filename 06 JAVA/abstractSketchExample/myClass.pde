static class MyClass extends AbstractSketch
{
int i, s=1024, r;

 MyClass(PApplet sketch){
    super(sketch);
 }

  void setup(int w, int h, PGraphics pg) {
      pg.noStroke();
  }
  
  void draw(PGraphics pg) {
    r=8<<++i%6;
    pg.fill(-(r<<(i/s))+(i%24)*r, 270-r);
    pg.rect(i/9*8%s, 8*i*i*i%s, r, r);
  }//#p5
}

