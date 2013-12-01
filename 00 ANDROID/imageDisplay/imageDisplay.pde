import peasy.*;
 
PImage b;
PeasyCam cam;
color[] dots;
 
void setup(){
  println("DATAPATH "+dataPath(""));
  size(480,800, P3D);
  b = loadImage("example.jpg");
    size(b.width, b.height, P3D);
 
    noSmooth();
    cam = new PeasyCam(this, 80,-10,-10,150);
    b.filter(GRAY);
    evalPixels();
}
 
void draw(){
  background(255);
  drawMatrix();
}
 
void drawMatrix(){
 
  for (int r = 0; r < b.height; r++){   // step through rows (lines) of pixels in image
 
    for (int p = 0; p < b.width; p++){  // step through each pixel value in row
 
      int loc = r + p * b.width;  // array ID for each pixel
      float x = r;
      float y = p;
      float z = (dots[loc]/1000000)*-1;
      point(x,y,z);
 
    }
 
  }
 
}
void evalPixels(){
  b.loadPixels();
  dots = b.pixels;
 
  for (int i = 0; i < dots.length; i++){
 
    print((dots[i]/100000)*-1 + " ");
  }
 
}
