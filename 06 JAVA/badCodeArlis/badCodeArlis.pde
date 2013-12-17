final int THOUSAND = 1000;
void setup() {

  ArrayList someBigArlis = getManyRandomIntegers(300 * THOUSAND); // element count


  println("Starting good approach...");
  int goodApproachStartTime = millis();
  for(int i = 0 ; i < someBigArlis.size() ; i++){
      if ( (Integer) someBigArlis.get(i) < 100 ) {
        //println("Found element below 100: " + someBigArlis.get(i) );
      }
  }
  println("Good approach elapsed: " + (millis() - goodApproachStartTime) );
  println();


  // start timing
  println("Starting bad approach..");
  int badApproachStartTime = millis();
  
  

  // absolutely incorrect and horrific code to perform task
  // of filtering out all values below 100
  while ( someBigArlis.size () > 0 ) { 
    if ( (Integer) someBigArlis.get(0) < 100 ) {
     // println("Found element below 100: " + someBigArlis.get(0) );
    }
    someBigArlis.remove(0);
  }
  
  println("Bad approach elapsed: " + ( millis() - badApproachStartTime ) );
  
  

}

void draw(){}


ArrayList getManyRandomIntegers(int num){
   if ( num < 1 ){
      throw new IllegalArgumentException("num parameter should always be 1 or larger");
   }
   ArrayList arlis = new ArrayList();
   for(int i = 0 ; i < num ; i++){
      arlis.add((int)random(1000));
   }
   return arlis;
}
 

