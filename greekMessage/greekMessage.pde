import java.net.URLDecoder;
import java.net.URLEncoder;
import java.io.UnsupportedEncodingException;


String decodedGreek;
String originalGreek;
String urlEncodedGreek;
void setup(){
   size(800, 600);
   originalGreek = "Η ελληνική γλώσσα είναι μία από τις ινδοευρωπαϊκές γλώσσες";
    
   try{
     // 
   urlEncodedGreek = URLEncoder.encode(originalGreek, "UTF-8");
   println(urlEncodedGreek);
   // or sendMessage(urlEncodedGreek);
   
   decodedGreek = URLDecoder.decode(urlEncodedGreek, "UTF-8");
   println("This is greek again: " + decodedGreek);
   
   }
   catch(UnsupportedEncodingException ex)
   { 
        println(ex.getMessage());  
   }


   textFont(createFont("Arial", 32));   
}



void draw(){
   background(0);
   fill(#00ff00);
   text("original greek: " + originalGreek, 10 , 30, width - 10, 200);
   
   fill(#ff0000);
   text("urlencoded: " + urlEncodedGreek, 10, 150, width-10, 300);
   
   fill(#0000ff); 
   text("decoded greek:  " + decodedGreek, 10, 450, width- 10, 300);
   
   noLoop();
}
