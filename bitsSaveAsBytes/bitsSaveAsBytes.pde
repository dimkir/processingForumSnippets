final int C_COUNT  = 30; //
final String C_FILENAME = "booleans_as_bytes.txt";


boolean[] myOriginalBooleans;

void setup(){

  // fill your boolean[] with some values
  myOriginalBooleans = makeRandomBooleanArray(C_COUNT);  
  printBoolean(myOriginalBooleans);

  saveBooleansToFile(C_FILENAME, myOriginalBooleans);
  

  // now load bytes from file into boolean array
  boolean[] reloadedBooleanValues = loadBooleansFromFile(C_FILENAME);
  
  printBoolean(reloadedBooleanValues);

 
  noLoop();

}
void draw(){
}



/**
* Saves given booleans into file, storing them as bytes.
*/
void saveBooleansToFile(String destFile, boolean[] booleans){
  // convert boolean to byte
  byte[] myBytes = new byte[booleans.length];
  for(int i = 0 ; i < booleans.length ; i++){
     if ( booleans[i] ){
        myBytes[i] = 1; // true
     }
     else{
        myBytes[i] = 0; // false
     }
  }
  saveBytes(destFile, myBytes);
}


/**
* Loads booleans from binary file, where each
* byte represents a true/false value.
*/
boolean[] loadBooleansFromFile(String filename){
    byte[] fileBytes = loadBytes(filename);
    if ( fileBytes == null ){
       println("Error file: " + filename + " cannot be opened. Cannot load booleans");
       return null; // error file was empty
    }
    boolean[] booleans = new boolean[fileBytes.length];
    for(int i = 0 ; i < fileBytes.length ; i++){
       if ( fileBytes[i] == 0 ){
          booleans[i] = false;
       }
       else{
          booleans[i] = true;
       }
    }
    
    return booleans;
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
