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

int counter;
int counter2;

Table locationTable;
int rowCount;


PFont font;

/** @pjs preload="gps.csv"; */

void setup() {
  size(1000, 800);
  font = createFont("Georgia", 24);
  textFont(font, 24);


  locationTable = new Table("gps.csv", width, height, geoRectangle);  // we pass width/height so that
                                                        // table precalculates
                                                        // correctly screen positions 

  rowCount = locationTable.getRowCount();

  smooth();
  noLoop();
}


void draw() {

  background(255);
  noStroke();


  // increases counter2 every up to 10 and then increases counter
  counter2 = counter2+1;

  if (counter2  == 10) {
    if (counter<rowCount) {
      counter = counter+1;
    }

    counter2 = 0;
  }


  for (int row = 0; row < rowCount; row++) {

//    float lat_y = locationTable.getLatitude(row);
//    float lon_x = locationTable.getLongitude(row);

    //  float x = map(locationTable.getFloat(row, 0), mapGeoRight, mapGeoLeft, 0, width);
    //   float y = map(locationTable.getFloat(row, 1), mapGeoTop, mapGeoBottom, 0, height);
    
    float screen_x = locationTable.getScreenX(row);
    float screen_y = locationTable.getScreenY(row);    
    
                                 
    //text( locationTable.getString(row, 1), p.x+4,p.y+4);     

    // get alpha 
    // calcualted as: latitude (NS) of the point like 57.123 
    // range of the world latitudes is from -90 to +90
    // the file sample it is in range around 57-56
//    float alpha = locationTable.getFloat(row, 0);
    float alpha = locationTable.getLatitude(row);
    
    
 
    // calculate ellipse diameter
    // based on: 
    
    // not on longitude, but on some number like 111 or 64 or 34:
    // divided by 2.5
    //57.693782,5.12873, 111
    //57.719688,5.346774, 111
    //56.856993,4.290668, 64
    //57.247939,6.203016, 34
    //57.771801,4.853899, 111     
    float diameter = locationTable.getFloat(row, 2)/2.5;
    
    drawEllipses(screen_x, screen_y, alpha, diameter);

    float t = map(mouseX, 0, width, -5, 5);
    //  curveTightness(t);
    //  curveVertex(p.x, p.y);
  }
//  endShape();
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



