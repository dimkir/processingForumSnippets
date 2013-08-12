/**
* This sketch illustrates how to download files 
* asynchronously from processing. 
* Keep in mind that all the files will be downloaded directly
* to memory. Th
*/ 

// these are the images we're going to download
ArrayList<PImage> myImages = new ArrayList();


SpecialObject so;
void setup(){
  size(800,600);
    

  so = prepareDownloadObject();
  
  // prepare list of urls which we want to download.
  // you can download ANY types of files with the downloadobject
  // just be sure that you handle them correctly when download job
  // completes.
  // But in this sketch for the illustration purposes, we will be using 
  // HUGE jpg-files as an example.
  String[] hugeImageURLs = {
    "http://wallpaperus.org/wallpapers/04/151/outer-space1-1472x6429-wallpaper-1634552.jpg",
    "http://upload.wikimedia.org/wikipedia/commons/e/e9/Sombrero_Galaxy_in_infrared_light_(Hubble_Space_Telescope_and_Spitzer_Space_Telescope).jpg",
    "http://universe-beauty.com/albums/userpics/2011y/05/06/1/10/universe-photos-76.jpg", // this is 40Megapix image
    "http://upload.wikimedia.org/wikipedia/commons/8/86/360-degree_Panorama_of_the_Southern_Sky_edit.jpg" // this is 70MegaPix image
                                                                                                          // keep in mind that it will take 0.5Gb in memory (yes, gigabytes!)
                                                                                                          // and it's only 6Mb (yes, only 6 MegaBytes) as jpeg on disk.
  };
  
  for(String hugeImage : hugeImageURLs){
    so.submitDownloadJob(hugeImage);
  }
  
  
}

int fileCount =0;
void downloadJobComplete(DownloadJob djob){
 
   println("Completed download job(we need to check for success status) for url:\n" + djob.getUrl());
   if ( djob.isDownloadSuccess() ){
      byte[] bbb = djob.getBytes();
      // here we assume that the file will be the jpeg.
      // but if you're going to be downloading other files
      // you may want to do your checks vs URL
      String filename= "file_" + fileCount + ".jpg"; 
      filename = dataPath(filename);
      
      // we can't convert bytes to image directly,
      // so first we save them to file and then we load file.
      saveBytes(filename, bbb );
      
      
      PImage img = loadImage(filename);
      println("For image " + fileCount +  " loaded image: " + img.toString() );
      if ( img == null || img.width == -1 || img.height == -1 ){
         // image was invalid, we don't add it to the image arraylist
         println("image was invalid, we don't add it to the image arraylist");
         return;
      }
      
      myImages.add(img);
      fileCount++;
      
   }
   println(); // empty line just for easier readability
 }




void draw(){
   background(0);
  // randomEllipse();
  if ( myImages.size() < 1 ){
    text("Downloading images ...", width/2, height/2);
  }
  else{
      int x = 0;
      int i = 1;
      for( PImage img : myImages){
         drawImageWithBorderAndText(img, x, x, "Image " + i );
         x+= 50;
         i++;
      }
   
  }
  
  // draw ellipse on screen to show to user that draw() is being called
  randomEllipse();  
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
