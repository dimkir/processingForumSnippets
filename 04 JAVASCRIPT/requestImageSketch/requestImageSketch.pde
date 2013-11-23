/**
* This sketch shows how one can load
* images from internet with requestImage()
* to simulate 360 degree rotation.
*
* Sample bike images are originated from:
* JavaScript SpriteSpin library
* http://spritespin.ginie.eu/

* https://github.com/giniedp/spritespin
*
*/


final int C_MIN_IMAGE_NUM = 1;
final int C_MAX_IMAGE_NUM = 34;


void setup(){
   size(480,327);
   curImage = loadImage(makeImageUrl(16)); 
           // just load image from the middle.
           // this is blockign call.
   setupFont();   
}

PImage curImage;
PImage inProgressImage;


boolean isLoading = false;
String imageNameLoading = "";

void mouseDragged(){
  // calcualte index of the image to load
  int indexOfImage = calculateIndexFromMouse(mouseX);
  String imageUrl = makeImageUrl(indexOfImage); // returns image url in form    "https://raw.github.com/giniedp/spritespin/master/examples/images/rad_zoom_016.jpg"
  
  // set image name
  imageNameLoading = "image #" + indexOfImage;
  
  // start loading  
  
  startDownloadingImage(imageUrl);
}

int calculateIndexFromMouse(int mX){
   return (int) map(mX, 0, width, C_MIN_IMAGE_NUM, C_MAX_IMAGE_NUM);
}


void startDownloadingImage(String url){
   isLoading = true;
   inProgressImage = requestImage(url);
   
}



/**
* We have images in range [0 to C_MAX_IMAGE_NUM]
* "https://raw.github.com/giniedp/spritespin/master/examples/images/rad_zoom_016.jpg"
*/
String makeImageUrl(int n){
    if ( n < C_MIN_IMAGE_NUM || n > C_MAX_IMAGE_NUM ){
       throw new RuntimeException("Requested invalid image number: "  + n);
    }
    String threeDigitNum = nf(n, 3);
    println("generated url:");
    String url = "https://raw.github.com/giniedp/spritespin/master/examples/images/rad_zoom_" + threeDigitNum + ".jpg";
    println(url);
    return url;    
}

void draw(){
  
   curImage = updateIfLoaded(inProgressImage, curImage);
   image(curImage,0,0);
   if ( isLoading ){
     text("Loading ... ", width/2, height/2); 
     text(imageNameLoading, width/2, height/2 + 32); 
   }

      
}

PImage updateIfLoaded(PImage inProgress, PImage current){
   if ( !isLoading ){
      return current; 
   }
   
   if ( inProgress == null ){
       println("updateIfLoaded() inProgress image is null");
       return current;
   }
   if ( inProgress.width <= 0 ){
      return current;
   }
   
   if ( inProgress.height <= 0 ){
      return current;
   }
   
   isLoading = false;
   return inProgress; 
}


void setupFont(){ 
   PFont fff = createFont("Arial", 24);
   textAlign(CENTER);
   textFont(fff);
   fill(#FF00F0);
}
