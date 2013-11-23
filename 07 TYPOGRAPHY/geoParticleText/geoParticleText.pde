// from forum
// https://forum.processing.org/topic/moving-particles-following-text-contour

import processing.opengl.*;
import geomerative.*;
 
ArrayList <PVector> path = new ArrayList <PVector> ();
ArrayList <Particle> particles = new ArrayList <Particle> ();
 
void setup() {
  size(600, 400, OPENGL);
  colorMode(HSB, 360, 100, 100);
  noStroke();
  smooth();
  
  RG.init(this);
  RCommand.setSegmentLength(10);
  RFont font = new RFont("loaded.ttf", 200, RFont.CENTER);
  RPoint[] points = font.toGroup("GEO").getPoints();
  
  for (int i=0; i<points.length; i++) { path.add( new PVector(points[i].x, points[i].y) ); }
  for (int i=0; i<1000; i++) { particles.add( new Particle() ); }
}
 
void draw() {
  background(0);
  translate(width/2, 2*height/3);
  for (Particle p : particles) {
    p.update();
    p.display();
  }
  if ( frameCount %10 == 0 ){ 
    saveFrame("geo-###.png");
  }
}
 
class Particle {
  PVector pos;
  float speed, px, py, x, y, d, interpolate = 1;
  int target;
  
  Particle() {
    pos = new PVector();
    d = random(1, 10);
    target = int(random(path.size()));
    speed = random(0.001, 0.25);
  }
  
  void update() {
    interpolate += speed;
    if (interpolate >= 1) {
      pos = path.get(target).get();
      target = (target+1)%path.size();
      interpolate = 0;
    }
    PVector t = path.get(target);
    x = lerp(pos.x, t.x, interpolate);
    y = lerp(pos.y, t.y, interpolate);
  }
  
  void display() {
    if (dist(x,y, px,py)<2.5) {
      fill((frameCount-target)%360, 100, 100);
      float difx = sin((y + frameCount)*0.01)*20;
      float dify = cos((x + frameCount)*0.03)*25;
      ellipse(x+difx, y+dify, d, d);
    }
    px = x;
    py = y;    
  }
}

