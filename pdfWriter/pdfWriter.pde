/**
* This is example illustrating how PDF graphics can be used
* to output shapes/points and images to it.
*
*/

import processing.pdf.*;

PGraphics pdfGraphics;

final String C_OUTPUT_PDF  = "mypdf.pdf";

// we'll try to write this image to PDF to see if it fails.
// image taken from wikipedia http://en.wikipedia.org/wiki/File:DublinMontage.jpg
final String testImageFilename  = "dublin_montage.jpg";
PImage testImage;

 


void setup(){
 size(800, 600, JAVA2D);
 testImage = loadImage(testImageFilename);
 
 
 pdfGraphics = createGraphics(width, height, PDF, C_OUTPUT_PDF);
 pdfGraphics.beginDraw();  // remember that before writing anything to pdf graphics you need to call
                           // beginDraw(); 
                           //  then you can draw shapes and points into grpahics, but they will be not 
                           // written to pdf yet. They will just be in memory. Until you call endDraw()
                           // then all your shapes and stuff will be flushed to PDF.
 frameRate(100);  
 text("Click mouse flush screen to pdf and exit sketch", 100, 100);  
}


void draw(){
     
   // here we draw random shape to our screen.
   randomShape(g);  
   // "g" refers to the current PGraphics. It is a variable which is defined in procesing
   // just like varibles "width" or "height"              
   
//   pdfGraphics.fill(random(255));
//   pdfGraphics.stroke(random(255));
//   randomShape(pdfGraphics);
 

   // if mouse pressed we write our pdfGraphics contents into PDF file on disk.
   // and exit sketch
   if ( mousePressed ){
        pdfGraphics.endDraw();  // if you don't do endDraw() before closing sketch your pdf will have no data     
        pdfGraphics.dispose();
        pdfGraphics = null;
        exit(); // i think this doesn't finish immediately, but tells processing
                // to exit sketch when draw() execution finishes. Thus i
                // call return to be sure that t
        return;
      }
        
   


   // if key is pressed, we take current screen and write it to pdf
   if ( keyPressed ){
      // here we take screen treating it as image and write it to pdf.
      // dunno if it works or crashes.
      //pdfGraphics.beginDraw();
      PImage img = g.get();
      pdfGraphics.image(img, 0, 0);
      
      //pdfGraphics.endDraw();
   }  
}



void stop(){
   if ( pdfGraphics != null ){
      // this makes sure that if we didn't reset the pdfGraphics, it will be saved to PDF.
      pdfGraphics.endDraw();
      pdfGraphics.dispose(); 
   }
   super.stop();
}


void randomShape(PGraphics pg){
   float x = random(100, width - 100);
   float y = random( 100, height - 100);
   float w = random(100);
   float h = random(100);
   float r = random(1); 
   
   color randomFillColor = randomColor();
   color randomStrokeColor = randomColor();
   
   fill(randomFillColor);
   stroke(randomStrokeColor);
   if ( r  < 0.1 ){  
     pg.ellipse(x, y, w, h);
   }
   else if (  r < 0.2 ) {
      pg.rect(x, y, w, h);
   }
   else{
      pg.point(x, y);
   }
   
}


color randomColor(){
   return color(random(255), random(255), random(255));
}
