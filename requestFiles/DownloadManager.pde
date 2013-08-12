interface IAsyncDownloadJobCompleteListener
{
   public void onAsyncDownloadJobComplete(DownloadJob djob);
}


public class DownloadManager
implements IAsyncDownloadJobCompleteListener
{
   PApplet mPapp;
   IOnDownloadComplete onCompleteListener;
   
   
   ArrayList<DownloadJob> completedDownloadJobs = new ArrayList<DownloadJob>();
   
   DownloadManager(PApplet pp){
       mPapp = pp;     
       pp.registerMethod("pre", this);

   }
   
   
   /**
   * @thread Any of the spawned download theads.
   */
   @Override // interface
   void onAsyncDownloadJobComplete(DownloadJob dj){
       synchronized( completedDownloadJobs ){
           completedDownloadJobs.add(dj);
       }
   }
   
   /**
   * @thread Animation thread.
   */
   public void pre(){
//     mPapp.ellipse(random(width), random(height),
//         random(10,20), random(10, 20));
//       mPapp.println("calling pre");
      
      if ( onCompleteListener == null ){
         return ; // if there's no listener, we just
                  // let the jobs to be collected.
                  // until memory is full i guess ;)
      }
      // check if the qty of completed jobs is larger and get them off
      // the list
      DownloadJob nextDownloadJob = null;
      synchronized( completedDownloadJobs ){
         if ( completedDownloadJobs.size() > 0 ){
             nextDownloadJob = completedDownloadJobs.get(0);
             completedDownloadJobs.remove(0);
         }
      }
      if ( nextDownloadJob != null ){
          onCompleteListener.onDownloadComplete(nextDownloadJob);
        
      }
   }
   
   
   void submitDownloadJob(String url){
       println("Submitting downloadJob: " + url);
       IAsyncDownloadJobCompleteListener asyncDJCompleteListener = this;
       new DownloadJob(url, asyncDJCompleteListener, mPapp );      
     
   }
   
   void setOnDownloadComplete(IOnDownloadComplete onComplete){
      onCompleteListener = onComplete;
   }
}

/**
* This interface is used to inform the drawing thread
* about the fact that download job is complete.
*/
interface IOnDownloadComplete
{
   public void onDownloadComplete(DownloadJob djob);  
 
}

class DownloadJob
implements AsyncBytesLoader.ILoaderCompleteListener
{
  
  private String mUrl;
  private byte[] mBytes;
  private AsyncBytesLoader mABL;
  
  private boolean mIsDownloadSuccess = false; // we kinda init as false, to avoid confusion.
  IAsyncDownloadJobCompleteListener onAsyncDownloadJobComplete;
  
  DownloadJob(String url, IAsyncDownloadJobCompleteListener  vOnAsyncDownloadJobComplete, PApplet papp){
     
     mUrl = url;
     onAsyncDownloadJobComplete = vOnAsyncDownloadJobComplete;
     mABL = new AsyncBytesLoader(url, this, papp); // i just pass PApplet, so that the thred can call String saveBytes()
     mABL.start();
  }
  
  
  /**
  * @thread Worker thread, when async loading is complete.
  */
  @Override // AsyncBytesLoader.
  public void onLoaderComplete(byte[] bytes)
  {
     mBytes = bytes;
     mIsDownloadSuccess = ( bytes == null )? false : true;
     onAsyncDownloadJobComplete.onAsyncDownloadJobComplete(this);
  }
  
  
  boolean isDownloadSuccess(){
      return mIsDownloadSuccess;
  }
  
  byte[] getBytes(){
     return mBytes;
  }
  
  String getUrl(){
     return mUrl;
  }
}




DownloadManager prepareDownloadObject(){
   System.setProperty("http.agent", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.95 Safari/537.36");  
   DownloadManager so = new DownloadManager(this);
   so.setOnDownloadComplete(new IOnDownloadComplete(){
       /**
       * You add your code here of what do you want to do upon download.
       * You can draw here, as this happens in (pre) call.
       */
       public void onDownloadComplete(DownloadJob djob){
            downloadJobComplete(djob);
       }
   });
   return so;
}
