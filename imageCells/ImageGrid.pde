/**
* This absraction abstracts image into "grid of images"
*/
class ImageGrid
{
   private PImage mImage;
   private ImageCell[][] mCells;
   
   private int mRowCount;
   private int mColCount;
   
   private int mCellWidth;
   private int mCellHeight;
   
   private int mLastCellWidth;
   private int mLastCellHeight;
   

   /**
   * Loads image from file and wraps it into "grid" object.
   * @throws RuntimeException in case there was an error with loading image or parameters.  
   */
   ImageGrid(String imgFilePath, int rowCount, int colCount){
      PImage img = getImageOrThrow(imgFilePath);
      init(img, rowCount, colCount);      
   }
   

   /**
   * Loads image from file and wraps it into "grid" object.
   * @throws RuntimeException in case there was an error with loading image or parameters.  
   */
   ImageGrid(PImage img, int rowCount, int colCount){
      init(img, rowCount, colCount);        
   }

   
  
   private void init(PImage img, int rowCount, int colCount){
        
       // set the image
       mImage = img; 
        
      // verify row and col parameters
        if ( rowCount < 1 ){
            throw new RuntimeException("Invalid rowCount (" + rowCount + "), should be 1 or higher");    
        }
        
        if ( colCount < 1 ){
           throw new RuntimeException("Invalid colCount (" +  colCount + "), should be 1 or higher");
        }
        mRowCount = rowCount;
        mColCount = colCount;
        
        
        
        mCellWidth = mImage.width / mColCount;
        mCellHeight = mImage.height / mRowCount;
        
        // this is something we will "crop"
        mLastCellWidth = mImage.width % mColCount;
        mLastCellHeight = mImage.height % mRowCount;
        
         
        // init cells array
        mCells = new ImageCell[mRowCount][mColCount];
             
   }
   
   
   /**
   * Returns null in case of invalid cell.
   */
   ImageCell getCell(int row, int col){
     checkGridBoundsOrThrow(row, col); 
     if ( mCells[row][col] == null ){
         mCells[row][col] = createCell(row, col);   
     }
     return mCells[row][col];
   }
   
   
   /**
   *  Creates cell from the image.
   */
   private ImageCell createCell(int row, int col){
      int cellX = col * mCellWidth;
      int cellY = row * mCellHeight;
      PImage img = mImage.get(cellX, cellY, mCellWidth, mCellHeight);
      return new ImageCell(img, cellX, cellY, mCellWidth, mCellHeight);
   }
   
   
   /**
   * Just checks whether parameters row and col are within 
   * allowed range. 
   * @throws RuntimeException with clear indications of what went wrong. 
   */
   private void checkGridBoundsOrThrow(int row, int col){
      if ( ! isValidRow(row) ){
         throw new RuntimeException("Value of row(" + row + ") is invalid, should be in range [0 .. " + (mRowCount -1) + "] inclusive."); 
      }
      
      if ( ! isValidCol(col) ){
         throw new RuntimeException("Value of col(" + row + ") is invalid, should be in range [0 .. " + (mColCount -1) + "] inclusive.");
      }
   }

   /**
   * Attempts to load image. If no success, throws RuntimeException.
   */
   private PImage getImageOrThrow(String imagePath){
        PImage img = loadImage(imagePath);
        if ( mImage == null ){
           throw new RuntimeException("Cannot load image: " + imagePath );
        }
        return img;
   }


   /**
   * Returns cell at point XY or NULL if XY is off the grid. 
   * 
   */
   ImageCell getCellAtPoint(int x, int y){
      if ( x < 0 || y < 0 ){
         dprintln(WARNING, "Coodinates x, y are off the grid: (" + x + ", " + y + ")");
         return null;
      }
      
      int prospectiveRowN = y / mCellHeight;
      int prospectiveColN = x / mCellWidth;
      
      if ( ! isValidRow(prospectiveRowN) ){
        dprintln(WARNING, "Coordinate y (" + y + ") is out of range");
        return null;
      } 
      
      if ( ! isValidCol(prospectiveColN) ){
        dprintln(WARNING, "Coordinate x (" + x + ") is out of range");
      }
      
      return getCell(prospectiveRowN, prospectiveColN);
      
   }
   
   
   private boolean isValidRow(int row){
      return  !(row < 0 || row >= mRowCount); 
   }
   
   private boolean isValidCol(int col){
      return !(col < 0 || col >= mColCount);
   }
   
   
   
   /**
   * Some constants for the levels of the debug messages.
   */ 
   private final int ERROR = 2;
   private final int WARNING = 3;
   private final int MSG = 4;
   
   
   private void dprintln(int level, String msg){
      println(level + ":" + msg);
   }
   
   
   
}// class ImageGrid
