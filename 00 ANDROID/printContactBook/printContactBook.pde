/**
* This sketch shows how to use Android services from processing sketch.
* 
*  Here we connect to the android system service providing 
* (phonebook) contact book details.
* 
* Sketch simply retrieves contacts and prints them to console and 
* prints few to the screen.
*
* Remember to set through PDE \\ ANDROID \\ SKETCH PERMISSIONS 
* permission READ_CONTACTS
* 
* Otherwise you will be getting "SecurityException" or smth like that.
*/

import android.net.Uri;


import android.provider.ContactsContract;

import android.database.Cursor;



void setup() {
   size(displayWidth, displayHeight);
   setupDefaultFont();
   colorMode(HSB, 255);
   populateArraysWidthPhoneBookData(listNames, listNumbers);
   
   outputContactToConsole(listNames, listNumbers);

}

ArrayList<String> listNames = new ArrayList<String>();
ArrayList<String> listNumbers = new ArrayList<String>();

/**
* Populates first arlis with names from address book and 
* second arlis with corresponding phone numbers.
*
* Under the hood connects to the Android service providing Contact details.
*
*/
void populateArraysWidthPhoneBookData(ArrayList<String> theNames, ArrayList<String> theNumbers) {
  Uri uri = ContactsContract.CommonDataKinds.Phone.CONTENT_URI;
  String[] projection    = new String[] {
    ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME, 
    ContactsContract.CommonDataKinds.Phone.NUMBER
  };

  Cursor people = getContentResolver().query(uri, projection, null, null, null);

  int indexName = people.getColumnIndex(ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME);
  int indexNumber = people.getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER);

  people.moveToFirst();
  do {
    String name   = people.getString(indexName);
    String number = people.getString(indexNumber);
    theNames.add(name);
    theNumbers.add(number);
    // Do work...
    //println("Found person: " + name + " and their phone number: " + number);
  } 
  while (people.moveToNext ());
}


void draw() {
   fadeScreen(color(0), 3);
   // get random contact and display on screen
   int randContact = (int) random(listNames.size());
   String msg = String.format("Name: %s ; phone: %s", listNames.get(randContact), listNumbers.get(randContact));
   textAtRandomScreenPosition(msg, randomColor());
}


// ********************************************************************
// ********************************************************************
// ***********Below are just helper functions whos purpsose************
// ***********should be clear from their name *************************
// ********************************************************************
// ********************************************************************


void textAtRandomScreenPosition(String str, color k){
   pushStyle();
   fill(k);
   float rx = random(width);
   float ry = random(height);
   text(str, rx, ry);
   popStyle();
}

void setupDefaultFont(){
   PFont f = createFont("Arial", 32);
   textFont(f);
   textAlign(CENTER);
}


void outputContactToConsole(ArrayList<String> names, ArrayList<String> numbers){
   for(int i = 0 ; i < names.size() ; i++){
     String msg = String.format("Name: %s ; phone: %s", names.get(i), numbers.get(i) );
      println(msg);
   }
}

void fadeScreen(color k , int transparency255){
   pushStyle();
   noStroke();
   fill(k, transparency255);
   rect(0,0, width, height);
   popStyle();
}

color randomColor(){
   return color((int) random(255), 255, 255);
}
