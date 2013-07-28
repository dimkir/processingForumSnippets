ImageGrid imgGrid;
CellCollection cellCollection;

String C_IMAGE_NAME = "image.jpg";
PImage myImage;
int C_ROW_COUNT = 20;
int C_COL_COUNT = 20;
ImageCell imgCell;

// define mode names
final String RANDOM_PIXEL = "random_pixel";
final String PIXEL_UNDER_MOUSE = "pixel_under_mouse";
final String CAT_SHAPE = "cat_shape";
Modes modes = new Modes(RANDOM_PIXEL, PIXEL_UNDER_MOUSE, CAT_SHAPE);


void setup(){
   // load image, so that we know it's size, to set sketch dimensions
   myImage = loadImage(C_IMAGE_NAME); 
   size(myImage.width, myImage.height);
   
   // here we create a "grid" object out of the image.
   // now we can "query" each cell of the image via
   // imgGrid.getCell(rowNumber, colNumber);
   imgGrid = new ImageGrid(myImage, C_ROW_COUNT, C_COL_COUNT);
   
   // create and set arial as font
   textFont(createFont("Arial", 22));   
   
   // here we do a bit of "acrobatics" in order to load "cat_path".
   // TODO: just make one method which would be loading cat path.
   shpChineseCat = loadShape("chinese_cat.svg");
   shpLayer1 = getShapeByNameOrThrow("layer1", shpChineseCat);
   shpCatPath = getShapeByNameOrThrow("cat_path", shpLayer1);

   // here we actually ask ImageGrid to return cells, into which 
   // the points are falling
   PVector[] catPoints = getPointsFromShape(shpCatPath);
   cellCollection = imgGrid.getCellsFromPoints(catPoints);
   
}



PShape shpChineseCat;
PShape shpLayer1;
PShape shpCatPath;

void mousePressed(){
  modes.switchToNextMode();
}


void draw(){
   
   clearScreen(0, 5);
   
   displayModeInfo();
   
   if ( modes.isCurrentMode(RANDOM_PIXEL) ){
         // get random row and column 
         int randRow = int( random(C_ROW_COUNT) );
         int randCol = int( random(C_COL_COUNT) );
         imgCell = imgGrid.getCell(randRow, randCol);
         // draw contents of the cell on the screen in the place where
         // this cell belongs.
         image(imgCell.getImage(), imgCell.getX(), imgCell.getY());
   }
   else if ( modes.isCurrentMode(PIXEL_UNDER_MOUSE) ){
         imgCell = imgGrid.getCellAtPoint(mouseX, mouseY);
         image(imgCell.getImage(), imgCell.getX(), imgCell.getY());
   }
   else if ( modes.isCurrentMode(CAT_SHAPE) ){
         cellCollection.drawRandomCell();      
   }
   else{
      // we only have 2 modes, so we shouldn't get to this "else"
      throw new RuntimeException("We shouldn't get here, unless we didn't mess up with the code");
   }
   
   
   //shape(shpChineseCat);
//   drawVertices(shpCatPath);
}





void displayModeInfo(){
  fill(255);
  text("Current mode: " + modes.getCurrentModeName() + ", click for next mode", 10, height - textDescent() );
}