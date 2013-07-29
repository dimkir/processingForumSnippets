ImageGrid imgGrid;
CellCollection cellCollection;

/* @pjs preload="image.jpg"; */
/* @pjs preload="chinese_cat.svg"; */
/* @pjs preload="chinese_cat.svg.xml"; */
String C_IMAGE_NAME = "image.jpg";
PImage myImage;
int C_ROW_COUNT = 10;
int C_COL_COUNT = 10;
ImageCell imgCell;

// define mode names
final String RANDOM_PIXEL = "random_pixel";
final String PIXEL_UNDER_MOUSE = "pixel_under_mouse";
final String CAT_SHAPE = "cat_shape";
final String BOUNCING_BALL = "bouncing_ball";
Modes modes = new Modes(RANDOM_PIXEL, PIXEL_UNDER_MOUSE, CAT_SHAPE, BOUNCING_BALL);

BouncingBall ball;

void setup(){
   // load image, so that we know it's size, to set sketch dimensions
   myImage = loadImage(C_IMAGE_NAME);
  
   //size(displayWidth,displayHeight);
   size(800,600);
   //size(myImage.width, myImage.height);
   
   // here we create a "grid" object out of the image.
   // now we can "query" each cell of the image via
   // imgGrid.getCell(rowNumber, colNumber);
   imgGrid = new ImageGrid(myImage, C_ROW_COUNT, C_COL_COUNT);
   
   // create and set arial as font
   textFont(createFont("Arial", 22));   
   
  
   MyShape2 catShape2 = new MyShape2("chinese_cat.svg", "cat_path");
   PVector[] catPoints = catShape2.getPoints(0.1f);
   //PVector[] catPoints = getPointsFromShape(shpCatPath, 0.1f);
   cellCollection = imgGrid.getCellsFromPoints(catPoints);
   
   
   ball = new BouncingBall(width, height, 3.0, 3.0);
   
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
         // maybe mouse is out of range of image (or inside image, but on the edge pixels which do not fall into the grid)
         if (imgCell != null){
           image(imgCell.getImage(), imgCell.getX(), imgCell.getY());
         }
   }
   else if ( modes.isCurrentMode(CAT_SHAPE) ){
         cellCollection.drawRandomCell();      
   }
   else if ( modes.isCurrentMode(BOUNCING_BALL) ){
         ball.update();
         imgCell = imgGrid.getCellAtPoint(ball.x, ball.y);
         if ( imgCell != null ){
            image(imgCell.getImage(), imgCell.getX(), imgCell.getY() );
         }
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
