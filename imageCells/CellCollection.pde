/**
* Cell collection. Just as simple as possible.
*/
class CellCollection
{
   private ArrayList<ImageCell> mCells = new ArrayList<ImageCell>();
  
  
   void addCell(ImageCell cell){
      mCells.add(cell);
   } 
   void draw(){
     for(int i = 0; i < mCells.size() ; i++){
        mCells.get(i).draw();
     }
   }
   
   
   
   ImageCell getRandomCell(){
      int rI = (int) random(mCells.size());
      return mCells.get(rI);
   }
   
   
   void drawRandomCell()
   {
      getRandomCell().draw();
   }
}
