/**************************************************************
* This tab contains 
* simply some "helper" drawing methods. 
* They're in this separate tab, not to clutter main tab.
*
*
* You DO NOT need them in your sketch if
* you just want to have async download functionality.
**************************************************************/


/**
* This method tries to covert byte-array which 
* supposedly contains image information, into PImage object.
* If imagebytes is NULL or is not image file, then it prints out
* error message to console and outputs.
*
* REMEMBER: 
*   In order to convert byte[] to PImage, the method first
*   saves byte-array to file in [data] directory and later
*   loads image from the directory.
*   Keep in mind that if image file is big, then writing to 
*   file to disk and loading it and decompressing to memory 
*   may take a significant CPU time. So if your files are big
*   and you call this method from inside draw(), you will 
*   experience sketch slow down.
*
*   @param imageFileBytes byte-array with image information
*   @param imageExtension you must explicitly specify format of the image (that's the way Processing works)
*              so it could be "png" "jpg" "gif" "tga" in other words any format loadImage()  supports.
*   @return on success valid instance of PImage,
*           on error NULL and prints out error message to console.
*/
PImage convertBytesToPImage(byte[] imageFileBytes, String imageExtension){
  
      // if image extension doesn't have "." in the beginning, add it.
      if ( imageExtension.charAt(0) != '.' ){
         imageExtension = "." + imageExtension;
      }    
  
      // here we assume that the file will be the jpeg.
      // but if you're going to be downloading other files
      // you may want to do your checks vs URL
      String filename= "file_" + fileCount + imageExtension; 
      filename = dataPath(filename);
      
      // we can't convert bytes to image directly,
      // so first we save them to file and then we load file.
      saveBytes(filename, imageFileBytes );
      
      
      PImage img = loadImage(filename);
      println("For image " + fileCount +  " loaded image: " + img.toString() );
      if ( img == null || img.width == -1 || img.height == -1 ){
         // image was invalid, we don't add it to the image arraylist
         println("image was invalid, we don't add it to the image arraylist");
         return null;
      }
      fileCount++;
      return img;
      
}      


void drawImageWithBorderAndText(PImage img, int x, int y, String msg){
     fill(#0000FF);
     rect(x, y, width -x, height -y);
     image(img, x , y);
     stroke(255);
     strokeWeight(3);
     noFill();
     rect(x, y, width -x, height -y);
     textAlign(LEFT, TOP);
     fill(255);
     text(msg, x + 5, y +  5);
  
}

void randomEllipse(){
   fill(#FF0000);
   noStroke();
   float x = random(width);
   float y = random(height);
   ellipse( x, y ,
         random(10,20), random(10, 20));
   
   String msg = "If ellipse freezes on screen, means that downloadJobComplete() " + 
                " takes too long to complete. Most likely loadImage() or saveBytes() " +
                " take long time because they have to operate on HUGE images (40Mp) "+ 
                " first with saveBytes() they have to write bytes to hard disk (which takes time) " +
                " but what's worse is that after they loadImage() which has to take a JPG and DECOMPRESS " +
                " it into PImage and this takes a LOT of time. For example 6Mb jpeg file will take 256Mb in memory " + 
                " so you can understand that decompression has to do significant job";        
   text(msg, x, y, 300, 300);
}


