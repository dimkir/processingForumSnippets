/**
* This sketch shows how Locale can be used
* to determine current system language.
* For more extensive version of documentation
* re android behaviour of Locale see:
* @see http://developer.android.com/reference/java/util/Locale.html

* Note that Locale is part of standard java distribution and
* works both in Android AND Java modes.
* @author Dimitry Kireyenkov
*/

import java.util.Locale;
void setup(){
     String dispLang = Locale.getDefault().getDisplayLanguage();
     println("displLang: " + dispLang); // returns "English"

     
     // returns language as specified by the  ISO639-2
     // (See first column of the page below) 
     // http://www.loc.gov/standards/iso639-2/php/code_list.php
     String iso3lang = Locale.getDefault().getISO3Language();
     println("iso3lang: " + iso3lang);   // returns "eng"
}


void draw(){
   drawRandomCircles();
}

void drawRandomCircles(){
   pushStyle();
   fill(random(100,200));
   strokeWeight(random(1,3));   
   ellipse(random(width),
           random(height),
           random(20,20),
           random(20,30)
           );
   
   popStyle();
}
