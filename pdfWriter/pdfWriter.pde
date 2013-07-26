/**
* This is example illustrates how PDF graphics can be used
* to save contents of the screen to PDF.
*
* Sketch draws random shapes to screen and when user
* presses mouse - saves the screen contents to pdf file.
*/

import processing.pdf.*;

void setup(){
 size(800, 600, JAVA2D);
 text("Click mouse flush screen to pdf and exit sketch", 100, 100);  
}

void draw(){

   if ( mousePressed ){
        flushScreenToPdf("my_screen.pdf");  // file will be in sketch directory
  
        exit(); // this doesn't finish immediately, but tells processing
                // to exit sketch when draw() execution finishes. Thus i
                // call return to be sure that we finish here.
        return;
    }
      
   drawRandomShape();      
}



/**
* Just draws random shape with random colors (fill and stroke) to screen. 
* With 10% probability random ellipse
* with 10% probability random rect
* with 80% probability random point
*/
void drawRandomShape(){
   float x = random(100, width - 100);
   float y = random( 100, height - 100);
   float w = random(100);
   float h = random(100);
   float r = random(1); 
   
   color randomFillColor = randomColor();
   color randomStrokeColor = randomColor();
   
   fill(randomFillColor);
   stroke(randomStrokeColor);
   
   // with probability 10% draw ellipse
   if ( r  < 0.1 ){  
     ellipse(x, y, w, h);
   }
   // with probability 10% draw rect
   else if (  r < 0.2 ) {
      rect(x, y, w, h);
   }
   // with probability 80% draw point
   else{
      point(x, y);
   }
   
}


void flushScreenToPdf(String destPdfFile){
   flushGraphicsToPdf(g, destPdfFile);  
   // "g" is a Processing variable (just like "width" or "height") which refers to current
   // graphics, which is screen.
}


void flushGraphicsToPdf(PGraphics someGraphics, String destPdfFile){
     PGraphics pdfGraphics = createGraphics(someGraphics.width, someGraphics.height, PDF, destPdfFile);  // after this empty pdf file is created
     pdfGraphics.beginDraw();  // remember that BEFORE drawing anything to pdf graphics you need to call
                               // beginDraw(); 
                               // now you can draw shapes and points into grpahics, but they will be not 
                               // written to pdf yet. They will just be in memory. Until you call endDraw()
                               // then all your shapes and stuff will be flushed to PDF.

      PImage img = someGraphics.get(); // get contents of the screen as image 
      pdfGraphics.image(img, 0, 0);    // draw this image to pdfgraphics
      
      // you have to call these two methods in the end so that all your pgraphics is 
      // properly closed and saved to disk. Otherwise PDF will be empty.
      pdfGraphics.endDraw();           
      pdfGraphics.dispose();           
}


/**
* Just returns random color
*/
color randomColor(){
   return color(random(255), random(255), random(255));
}
