import android.webkit.WebView;
import android.app.Activity;
import java.lang.Runnable;

void setup(){
   size(displayWidth, displayHeight);

   
}

void mousePressed(){

  
  final Activity activity = (Activity) this;
  
  activity.runOnUiThread(new Runnable(){
     public void run(){
          WebView webView = new WebView(activity);
         String customHtml = "<html><body><h1>Hello, WebView</h1></body></html>";
         //webView.loadData(customHtml, "text/html", "UTF-8");
         webView.loadUrl("http://www.google.com");
         setContentView(webView);  
     }
  });

}

void draw(){
   randomEllipse();
}


void randomEllipse(){
   ellipse(random(width), random(height), random(10,20), random(10,20));
}
