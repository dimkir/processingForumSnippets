/**
* Absraction of the cell of the image. 
* Contains "image" of the cell and 
* it's x,y coordinates in the image.
*
* Cells can be fetched from the ImageGrid
* object by querying their column and row 
* numbers:
*
* ImageCell cell = imageGrid.getCell(row, col);
* Image cell is an immutable object (meaning that
* you can't modify cell's contents). (Actually the PImage
* inside of it is not really immutable).
*/
class ImageCell
{
   private final PImage mImg;
   private final int x;
   private final int y;
   private final int w;
   private final int h;
   
   /**
   * Creates new cell.
   * @param xx is the X position of the cell in the image. The type
   * is integer because we are working with discreet pixels.
   */
   ImageCell(PImage cellImage, int xx, int yy, int ww, int hh){
      mImg = cellImage;
      x = xx;
      y = yy;
      w = ww;
      h = hh;
   }
   
   PImage getImage(){
      return mImg;
   }
   
   float getX(){
      return x;
   }
   
   float getY(){
      return y;
   }
}
