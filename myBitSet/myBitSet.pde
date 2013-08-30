/**
*
* Be sure not to call your sketch "bitset" or you will
* get really weird messgages like "function get(int) does not exist"
*/

final int  C_COUNT = 67; // 30 boolean values 
boolean[] bools = new boolean[C_COUNT];

void setup(){
   // initialize boolean array with 30 random bit values
   bools = makeRandomBooleanArray(C_COUNT);
   printBoolean(bools);
   
   // now let's convert bool array into bitset
       ExportableBitSet myBitSet = new ExportableBitSet();
       for(int i = 0 ; i < bools.length ; i++){
          myBitSet.set(i, bools[i]);
       }
       
   // now let's save them to file.
   byte[] array = myBitSet.toByteArray();
   saveBytes("mybits_saved.bin", array);
  
  
  
   // and now let's load the binary file and verify if
   // it is the same array 
   byte[] reloadedByteData = loadBytes("mybits_saved.bin");
   println("Loaded " + reloadedByteData.length + " bytes from file");
   ExportableBitSet reloadedBitSet = new ExportableBitSet(reloadedByteData);
   // now let's convert it to boolean
   boolean[] reloadedBoolean = new boolean[reloadedBitSet.length()];
   for(int i = 0 ; i < reloadedBitSet.length() ;i++){
      reloadedBoolean[i] = reloadedBitSet.get(i);
   }
   
   printBoolean(reloadedBoolean);
   
   println("The two lines above should be identical");
   
   
}


/**
* Generates boolean array of size c 
* filled with booleans at random.
*
*/
boolean[] makeRandomBooleanArray(int c)
{
   
   boolean[] b= new boolean[c]; 
   for(int i = 0 ; i < b.length; i++){
      if ( random(1) > 0.5 ){
         b[i] = true;
      }
   }
   
   return b;
}



void printBoolean(boolean[] b){
   for(int i = 0 ; i < b.length ; i++){
      if ( i % 8 == 0 && i > 0){
         print("|"); // divider of byes
      }
      if (b[i]){
         print("*");
      }
      else{
         print(".");
      }
   }
   
   print("\t array size: " + b.length);
   
   println();
}
