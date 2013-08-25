/**
* This sketch is for illustration of 
* proxy bug in Processing 2.0.2
* 
* Bug:
* When setting proxy settings in 
*  [preferences.txt], namely:
proxy.host=someproxyname.net
proxy.port=8080
*  these settings won't make PDE use proxy,
*  neither they force sketch
*  to use proxy (Yes, these are two different things).
*
*  HOW TO REPRODUCE:
*  Open [preferences.txt] and add some "fake" proxy configuration
*  which you know will fail. For example make proxy point to 
*  closed port on localhost:
proxy.host=127.0.0.1
proxy.port=4567
   Now open this sketch and run it.
   
   ON BUG EXISTS:  your "fake" proxy setting won't be recognized 
   by the sketch. This sketch would print to console that there's no proxy
   server set up and will succeed in displaying logo.
   
   ON BUG DOESN'T EXIST: you will see in the console message informing you
   that 127.0.0.1 is used as server and you WILL NOT be able to see the image.

*/

String HTTP_urlToTest = "http://processing.org/img/processing2-logo.jpg";

PImage img;
void setup(){
   size(800,600);
   
   // getting proxy settings as described in 
   // @see http://docs.oracle.com/javase/6/docs/technotes/guides/net/proxies.html
   String proxyHost = System.getProperty("http.proxyHost");
   String proxyPort = System.getProperty("http.proxyPort");
   print("http.ProxyHost: ");
   println(proxyHost);
   
   print("http.ProxyPort: ");
   println(proxyPort);
   
   
   img = loadImage(HTTP_urlToTest);
   
}

void draw(){
   image(img, 0,0);
   text("if you see the image, then your fake proxy setting failed",
       50, 30);
}
