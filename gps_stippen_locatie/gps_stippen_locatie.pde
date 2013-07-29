float mapGeoTop = 59;  //LAT
float mapGeoBottom = 55; // lAT
float mapGeoLeft = 10;  //LON
float mapGeoRight = 0;   //LON

int counter;
int counter2;

int mapScreenWidth = width;
int mapScreenHeight = height; 

Table locationTable;
int rowCount;


PFont font;

/** @pjs preload="gps.csv"; */

void setup() {
  size(1000, 800);
  font = createFont("Georgia", 24);
  textFont(font, 24);
  locationTable = new Table("gps.csv");  // or .csv 

  rowCount = locationTable.getRowCount();

  mapScreenWidth = width;
  mapScreenHeight = height; 
  smooth();
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



  // shape is not needed here as
  // you don't use any shape methods
//  beginShape();

  for (int row = 0; row < rowCount; row++) {

//    float x = (locationTable.getFloat(row, 1));     
//    float y = (locationTable.getFloat(row, 0));
    float y = locationTable.getLatitude(row);
    float x = locationTable.getLongitude(row);

    //  float x = map(locationTable.getFloat(row, 0), mapGeoRight, mapGeoLeft, 0, width);
    //   float y = map(locationTable.getFloat(row, 1), mapGeoTop, mapGeoBottom, 0, height);

    //PVector p = geoToPixel(new PVector(x, y));
    PVector p = geoToPixel(x, y); // we use this method to save 
                                  // creation of extra PVector() object
                                  // each frame.
                                  
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
    
    // all the ellipse logic can be encapsulated into a function
    drawEllipses(p, alpha, diameter);

    float t = map(mouseX, 0, width, -5, 5);
    //  curveTightness(t);
    //  curveVertex(p.x, p.y);
  }
//  endShape();
}


/**
* Draws concentrating circles at given point.
* The bottom circle is of given diameter and given alpha.
*/
void drawEllipses(PVector p, float fFillAlpha, float ellipseDiameter){
    
     
    fill(0, fFillAlpha);
      
    float ellipseWidth = ellipseDiameter;
    float ellipseHeight = ellipseDiameter;
    
    ellipse(p.x, p.y, ellipseWidth , ellipseHeight );

    // draw rest of concetrating circles with fixed sizes    
    fill(255);
    ellipse(p.x, p.y, 16, 16);

    fill(0);
    ellipse(p.x, p.y, 12, 12);
    fill(255);
    ellipse(p.x, p.y, 8, 8);
    fill(0);
    ellipse(p.x, p.y, 4, 4);
    noFill();  
}


// =========================================================================


class Table {
  int rowCount;
  String[][] data;


  Table(String filename) {
    println("Trying to load file: [" + filename +"]");
    String[] rows = loadStrings(filename);
    if ( rows == null ) {
      throw new RuntimeException("loadStrings() returned null");
    }
    println("Loaded from csv " + rows.length + " lines");


    data = new String[rows.length][];
    for (int i = 0; i < rows.length; i++) {
      if (trim(rows[i]).length() == 0) {
        continue; // skip empty rows
      }
      if (rows[i].startsWith("#")) {
        continue;  // skip comment lines
      }
      // split the row on the tabs
      println("\nProcessing row: [" + rows[i] + "]");
      String[] pieces = split(rows[i], ',');
      println("After splitting has " + pieces.length + " parts");
      // copy to the table array
      data[rowCount] = pieces;
      rowCount++;
      // this could be done in one fell swoop via:
      //data[rowCount++] = split(rows[i], TAB);
    }
    // resize the 'data' array as necessary
    //data = (String[][]) subset(data, 0, rowCount);
    printDataToConsole();
  }

  void printDataToConsole() {
    println("data[][] array length is: " + data.length);
    //return;
    for (int i = 0 ; i < data.length ; i++) {
      printlnDataRowToConsole(data[i]);
    }
  }

  void printlnDataRowToConsole(String[] dataRow) {
    println(dataRow);
  }


  int getRowCount() {
    return rowCount;
  }


  // find a row by its name, returns -1 if no row found
  // DK: finds row by it's Langitude (50.123) parameter.. hmm.m.
  // that strange.
  int getRowIndex(String name) {
    for (int i = 0; i < rowCount; i++) {
      if (data[i][0].equals(name)) {
        return i;
      }
    }
    println("No row named '" + name + "' was found");
    return -1;
  }
  String getRowName(int row) {
    return getString(row, 0);
  }
  String getString(int rowIndex, int column) {
    return data[rowIndex][column];
  }
  String getString(String rowName, int column) {
    return getString(getRowIndex(rowName), column);
  }
  int getInt(String rowName, int column) {
    return parseInt(getString(rowName, column));
  }
  int getInt(int rowIndex, int column) {
    return parseInt(getString(rowIndex, column));
  }
  
  
  float getFloat(String rowName, int column) {
    return parseFloat(getString(rowName, column));
  }
  
  float getLatitude(int rowIndex){
     return getFloat(rowIndex, 0);
  }  
  
  float getLongitude(int rowIndex){
     return getFloat(rowIndex, 1);
  }
  
  float getFloat(int rowIndex, int column) {
    return parseFloat(getString(rowIndex, column));
  }
  void setRowName(int row, String what) {
    data[row][0] = what;
  }
  void setString(int rowIndex, int column, String what) {
    data[rowIndex][column] = what;
  }
  void setString(String rowName, int column, String what) {
    int rowIndex = getRowIndex(rowName);
    data[rowIndex][column] = what;
  }
  void setInt(int rowIndex, int column, int what) {
    data[rowIndex][column] = str(what);
  }
  void setInt(String rowName, int column, int what) {
    int rowIndex = getRowIndex(rowName);
    data[rowIndex][column] = str(what);
  }
  void setFloat(int rowIndex, int column, float what) {
    data[rowIndex][column] = str(what);
  }
  void setFloat(String rowName, int column, float what) {
    int rowIndex = getRowIndex(rowName);
    data[rowIndex][column] = str(what);
  }
  
  
  
}


/**
* Convenience version of geoToPixel which takes
* PVector as parameter.
*/
public PVector geoToPixel(PVector geoLocation)
{
  return geoToPixel(geoLocation.x, geoLocation.y);
}

/**
* Just converts geo-location to screen coordinate
* based on pre-defined parameters.
*/
public PVector geoToPixel(float x, float y){
  return new PVector(mapScreenWidth*(x-mapGeoLeft)/
    (mapGeoRight-mapGeoLeft), mapScreenHeight -
    mapScreenHeight*(y-mapGeoBottom)
    /(mapGeoTop-mapGeoBottom));
}
