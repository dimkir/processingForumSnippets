// =========================================================================
class Table {
  int rowCount;
  String[][] data;
  
  int mMapScreenWidth;
  int mMapScreenHeight;
  
  GeoRectangle mGeoRect;
  
  /**
  * Here we will be storing screen coordinates 
  * for each of the geograpihal points.
  * They will be calculated once during the CSV-loading stage
  * and later can be queried via getScreenX(row) an getScreenY(row) methods.
  */
  PVector[] mScreenCoords;


  Table(String filename, int wWidth, int hHeight, GeoRectangle geoRect) {
    mMapScreenWidth = wWidth;
    mMapScreenHeight = hHeight;
    mGeoRect = geoRect;
    
    // loads CSV file with lat/long data
          dprintln("Trying to load file: [" + filename +"]");
          String[] rows = loadStrings(filename);
          if ( rows == null ) {
            throw new RuntimeException("loadStrings() returned null");
          }
          dprintln("Loaded from csv " + rows.length + " lines");


    // init the array of pointers to stringars.
          data = new String[rows.length][];
    // here we will store screen coords for each point
          mScreenCoords = new PVector[rows.length];
    
    
    // loop though all lines read from CSV (empty or commented #)
    // and add them to 'data' array
    for (int i = 0; i < rows.length; i++) {
      if (trim(rows[i]).length() == 0) {
        continue; // skip empty rows
      }
      if (rows[i].startsWith("#")) {
        continue;  // skip comment lines
      }

      // split the row on the tabs
            dprintln("\nProcessing row: [" + rows[i] + "]");
            String[] pieces = split(rows[i], ',');
            dprintln("After splitting has " + pieces.length + " parts");
            
      // copy to the table array
      data[rowCount] = pieces;
      // calculate screen coords. 
      mScreenCoords[rowCount] = calculateScreenCoords(pieces);      
      rowCount++;
      // this could be done in one fell swoop via:
      //data[rowCount++] = split(rows[i], TAB);
    }
    // resize the 'data' array as necessary
    //data = (String[][]) subset(data, 0, rowCount);
    printDataToConsole();
  }

  void printDataToConsole() {
    dprintln("data[][] array length is: " + data.length);
    //return;
    for (int i = 0 ; i < data.length ; i++) {
      printlnDataRowToConsole(data[i]);
    }
  }

  void printlnDataRowToConsole(String[] dataRow) {
    dprintln(dataRow);
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
    dprintln("No row named '" + name + "' was found");
    return -1;
  }
  
  
  String getRowName(int row) {
    return getString(row, 0);
  }
  
  
  String getString(int rowIndex, int column) {
    return data[rowIndex][column];
  }
  
  // this one is strange as well.  
  String getStringByName(String rowName, int column) {
    return getString(getRowIndex(rowName), column);
  }
  
  
  int getInt(String rowName, int column) {
    return parseInt(getStringByName(rowName, column));
  }
  int getInt(int rowIndex, int column) {
    return parseInt(getString(rowIndex, column));
  }
  
  
  /**
  * The cause of the bug was here. Because 
  * PJS was calling getFloat(String, int)
  * instead of calling getFloat(int, int)
  */
  float getFloatByName(String rowName, int column) {
    return parseFloat(getStringByName(rowName, column));
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
  
  
  float getLatitude(int rowIndex){
     return getFloat(rowIndex, 0);
  }  
  
  float getLongitude(int rowIndex){
     return getFloat(rowIndex, 1);
  }
  
  /**
  * Returns precalculated during load stage 
  * coordinates on the screen for the points.
  * Note that I am using 1-dimensional array here
  * to store coordinates. Simply because 1-d arrays are
  * more obvious for mind, easier to implement, harder to make mistake
  * and should be more portable when trying ProcessingJS.
  */
  float getScreenX(int row){
     return mScreenCoords[row].x;
  }
  
  float getScreenY(int row){
     return mScreenCoords[row].y;
  }
  
  
  PVector calculateScreenCoords(String[] splittedCsvLine){
     float lat_y =  parseFloat(splittedCsvLine[0]);
     float lon_x =  parseFloat(splittedCsvLine[1]);
     dprintln("Calculating screen coordinates: ");
     dprintStringar(splittedCsvLine);
     PVector scr =geoToPixel(lon_x, lat_y); 
     dprintln(scr.toString());
     return scr;
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
  public PVector geoToPixel(float lon_x, float lat_y){
    return new PVector(mMapScreenWidth*(lon_x-mGeoRect.mapGeoLeft)/
      (mGeoRect.mapGeoWidth), mMapScreenHeight -
      mMapScreenHeight*(lat_y-mGeoRect.mapGeoBottom)
      /(mGeoRect.mapGeoHeight));
  }  
  
}// Table class
