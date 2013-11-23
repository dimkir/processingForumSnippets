PImage a;
void setup(){
 a=loadImage("testimage.jpg");
 size(1000,1000,P3D);
}
int distance=0;
void draw(){
 background(0);
 image(a,50.0,50.0);
 camera(80,80,80,80,distance++,80,0,1,0);
}
