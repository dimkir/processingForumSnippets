/**
* This sketch loads geographical coordinates from CSV-file
* and displayes them on the screen.
*
*/

final boolean DISABLE_DEBUG_CONSOLE_OUTPUT = true;

/**
* These are limits for the LAT/LON which
* define the "rect" in which drawing happens
*/
float mpGeoTop = 59;  //LAT
float mpGeoBottom = 55; // lAT
float mpGeoLeft = 10;  //LON
float mpGeoRight = 0;   //LON
GeoRectangle geoRectangle = new GeoRectangle(mpGeoLeft, mpGeoTop, mpGeoRight, mpGeoBottom);

Table locationTable;

PFont font;

/** @pjs preload="gps.csv"; */

void setup() {
  size(1000, 800);
  font = createFont("Georgia", 24);
  textFont(font, 24);

  locationTable = new Table("gps.csv", width, height, geoRectangle);  

  smooth();
  //noLoop();
}


void draw() {

  background(255);
  noStroke();

  for (int row = 0; row < locationTable.getRowCount() ; row++) {
    
    float screen_x = locationTable.getScreenX(row);
    float screen_y = locationTable.getScreenY(row);    

    float alpha = locationTable.getLatitude(row);
    
    float diameter = locationTable.getFloat(row, 2)/2.5;
    
    drawEllipses(screen_x, screen_y, alpha, diameter);

    float t = map(mouseX, 0, width, -5, 5);
  }

}


/**
* Just convenience method, if you want to use PVector 
* to draw circles.
*/
void drawEllipses(PVector p, float fFillAlpha, float ellipseDiameter){
   drawEllipses(p.x, p.y, fFillAlpha, ellipseDiameter);
}

/**
* Draws concentrating circles at given point.
* The bottom circle is of given diameter and given alpha.
*/
void drawEllipses( float px, float py, float fFillAlpha, float ellipseDiameter){
     
    fill(0, fFillAlpha);
      
    float ellipseWidth = ellipseDiameter;
    float ellipseHeight = ellipseDiameter;
    
    ellipse(px, py, ellipseWidth , ellipseHeight );

    // draw rest of concetrating circles with fixed sizes    
    fill(255);
    ellipse(px, py, 16, 16);

    fill(0);
    ellipse(px, py, 12, 12);
    fill(255);
    ellipse(px, py, 8, 8);
    fill(0);
    ellipse(px, py, 4, 4);
    noFill();  
}

/**
* All messages to console will be printed using
* dprinln() instead of println() and this way
* it is possible to disable all console output
* just by commenting one line in this method.
*/
void dprintln(String msg){
  if ( ! DISABLE_DEBUG_CONSOLE_OUTPUT ){
     println(msg);
  }
}

void dprintln(String[] array){
  if ( ! DISABLE_DEBUG_CONSOLE_OUTPUT ){
    println(array);
  }
}

void dprintStringar(String[] ar){
   if ( DISABLE_DEBUG_CONSOLE_OUTPUT ){
      return;
   }
   println(ar);
}



