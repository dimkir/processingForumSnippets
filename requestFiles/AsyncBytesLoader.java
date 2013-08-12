import processing.core.PApplet;

class AsyncBytesLoader extends Thread {


  public interface ILoaderCompleteListener
  {
     public void onLoaderComplete(byte[] bytes);
  }  
  
  
  
  static public final int bytes_requestImageMax = 2;
  static volatile int bytes_requestImageCount;

  String url;
  byte[] buffer;
  ILoaderCompleteListener onLoaderCompleteListener;
  private PApplet mPapp;

  public AsyncBytesLoader(String theUrl, ILoaderCompleteListener vOnLoaderCompleteListener, PApplet papp) {
    this.url = theUrl;
    this.onLoaderCompleteListener = vOnLoaderCompleteListener;
    this.mPapp = papp;
  }

  @Override
    public void run() {
    while (bytes_requestImageCount == bytes_requestImageMax) {
      try {
        Thread.sleep(100);
      } 
      catch (InterruptedException e) {
      }
    }
    bytes_requestImageCount++;

    byte[] bytes = mPapp.loadBytes(url);

    onLoaderCompleteListener.onLoaderComplete(bytes);
    bytes_requestImageCount--;
  }//run
}

