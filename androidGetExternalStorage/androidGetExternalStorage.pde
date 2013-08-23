/**
* This sketch shows how to 
* get writable filepath pointing 
* to external storage directory (SDCARD) in android mode.

* REMEMBER:
* For this sketch to be able to write to SD card, you need to
* go in PDE to menu Android /Sketch Permissions and 
* enable WRITE_EXTERNAL_STORAGE permission.
*
* @author Dimitry Kireyenkov
*/

import android.os.Environment;

String msgToDraw = "no message set";
void setup(){
  
  
  String dataFile = getSdWritableFilePathOrNull("strings.txt");
  if ( dataFile == null ){
        String errorMsg = "There was error getting SD card path. Maybe your device doesn't have SD card mounted at the moment";
        println(errorMsg);
        msgToDraw = errorMsg;
  }
  else{
      // now we can use save strings.
      String[] strings = split("This will become strings write into file", ' ');
      println("Now we're goign to attempt to save strings to file [" + dataFile + "]");
      saveStrings(dataFile, strings);
      
      msgToDraw = "looks like we've managed to save strings to file: [" + dataFile + "]";
  }
}



/**
* This method works in a similar way as dataPath() method, except
* but it provides writeable path on sd card.
* So if you call it like this:
* 
  getSdWritableFilePathOrNull("strings.txt");
    
    it will return string similar to this:
    
   /mnt/sdcard/androidGetExternalStorage/strings.txt
   
   where 'androidGetExternalStorage' will be the name of your sketch.

*/
String getSdWritableFilePathOrNull(String relativeFilename){
   File externalDir = Environment.getExternalStorageDirectory();
   if ( externalDir == null ){
      return null;
   }
   String sketchName= this.getClass().getSimpleName();
   //println("simple class (sketch) name is : " + sketchName );
   File sketchSdDir = new File(externalDir, sketchName);
   
   File finalDir =  new File(sketchSdDir, relativeFilename);
   return finalDir.getAbsolutePath();
}





void draw(){
   drawMessageInScreenCenter(msgToDraw);
   drawRandomCircle();   
  
}

void drawMessageInScreenCenter(String m){
   textAlign(CENTER, CENTER);
   fill(0);
   text(m, width/2, height/2);
}

void drawRandomCircle(){
   fill(random(128,255)); // light color filling for circles
   ellipse(random(width), 
           random(height),
           30, 30);
  
}
