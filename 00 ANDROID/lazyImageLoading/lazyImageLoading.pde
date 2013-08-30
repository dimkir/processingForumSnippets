
// http://forum.processing.org/topic/problem-with-pimage-resize

final static int IMGS = 3;
PImage[] images = new PImage[IMGS];

void setup() {
  size(displayWidth, displayHeight);
  //noLoop();
  loadAllMyImages();
  // delay(2000); // this delay will just "freeze" the app for 2 seconds.  
}

void draw() {
  background(0);
  imageIfLoaded(images[0],0,0);
  imageIfLoaded(images[1], 100, 100);
  imageIfLoaded(images[2], width/2, height/2);
}

void loadAllMyImages() {
  new LoadAndResize(0, images, "my_bg.jpg", width, height).start();
  new LoadAndResize(1, images, "lostgarden/Character Boy.png", 64, 64).start();
  new LoadAndResize(2, images, "lostgarden/Character Pink Girl.png", 132, 132).start();
}

void imageIfLoaded(PImage img, float x , float y){
   if ( img == null ){
      return;
   }
   println("imageIfLoaded(" + img.toString() + ", " + x + ", " + y );   
   if ( img.width != -1 && img.height != -1 ){
      image(img, x, y);
   }
   else{
     println("image is not loaded yet");
   }
}

class LoadAndResize extends Thread {
  final PImage[] picts;
  final String path;
  final int idx, w, h;

  static final int PAUSE = 200;

  LoadAndResize(int number, PImage[] imgs, String name, int wdt, int hgt) {
    idx = number;
    picts = imgs;
    path = name;
    w = wdt;
    h = hgt;
  }

  void run() {
    picts[idx] = loadImage(path);
    //while (picts[idx] == null)   delay(PAUSE);
    picts[idx].resize(w, h);
  }
}


