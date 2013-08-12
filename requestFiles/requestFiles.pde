/**
* This sketch illustrates how to download files 
* asynchronously from processing.  
*
* Keep in mind that all the files will be downloaded directly
* to memory, so if you decide to download huge zip-file,
* which fills up all memory, you'll get OutOfMemory exception.
*
* In this sketch for the illustration purposeses I download images,
* but this method allows you to download ANY file,
* because in the end you receive the file as byte[] array.
*
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
  
  // submit urls to the download manager, 
  // so that he starts asynchronouse download.
  for(String hugeImage : hugeImageURLs){
    so.submitDownloadJob(hugeImage);
  }
  
  
}




int fileCount =0;
/**
* This method is called when download is complete.
* (Can complete successfully or can be a "complete" failure.
*/
void downloadJobComplete(DownloadJob djob){
 
   println("Completed download job(we need to check for success status) for url:\n" + djob.getUrl());
   if ( djob.isDownloadSuccess() ){
      byte[] bbb = djob.getBytes();  // this could be any file returned as byte[] array.
      
      // as we know that it was image originally, we 
      // convert it to image.
      // but if it were html or txt or obj-file you could have
      // processed it the way you want.
      PImage img = convertBytesToPImage(bbb, "jpg");
      
      myImages.add(img);
      fileCount++;
      
   }
   else{
      println("Download wasn't successful");
   }
   println(); // empty line just for easier readability
 }




void draw(){
   background(0);

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

