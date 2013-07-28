/**
* This is abstract representation of "modes". 
* You can use it to loop through different modes. 
*/
class Modes
{
   private String[] mModes;
   private int mPointer = -1;
  
   private boolean mCaseINSENSITIVE = false; // set this to true if you want INSENSITIVE compares
  
   Modes(String m1, String m2){
      String[] modes = new String[2];
      modes[0] = m1;
      modes[1] = m2;
      init(modes);
   }
   
   Modes(String m1, String m2, String m3){
      String[] modes = new String[3];
      modes[0] = m1;
      modes[1] = m2;
      modes[2] = m3;
      init(modes);
   }

   Modes(String m1, String m2, String m3, String m4){
      String[] modes = new String[4];
      modes[0] = m1;
      modes[1] = m2;
      modes[2] = m3;
      modes[3] = m4;
      init(modes);
   }
   
   Modes(String[] allModes){
      init(allModes);
   }
   
   private void init(String[] allModes){
      if ( allModes == null ){
        throw new RuntimeException("Modes array supplied cannot be NULL");
      }
      
      if ( allModes.length == 0){
         throw new RuntimeException("Modes array supplied cannot be 0 length");
      }
      mModes = allModes;
      mPointer = 0;      
   }
   
   
   void switchToNextMode(){
      mPointer++;
      mPointer = mPointer % mModes.length;
   }
   
   boolean isCurrentMode(String s){
      String curMode = mModes[mPointer];
      return modeEquals(s, curMode);
   }
   
   
   /**
   * Compares two modes
   */
   private boolean modeEquals(String a, String b){
       if ( mCaseINSENSITIVE ){
          a = a.toLowerCase();
          b = b.toLowerCase();
       }
       
       return a.equals(b);
   }
   
   
   String getCurrentModeName()
   {
     return mModes[mPointer];
   }
   
}
