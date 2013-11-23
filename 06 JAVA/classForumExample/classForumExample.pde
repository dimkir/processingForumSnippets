
void setup(){
  // as the sketch is a class itself, let's print it's names.
  printTheClassCanonicalName(this);
  printTheClassSimpleName(this); // this is also way to figure out name of your sketch.
  
  println();
  
  // now let's make our own class and try to see it's names:
  MyClass myClass = new MyClass();
  printTheClassCanonicalName(myClass);
  printTheClassSimpleName(myClass);
  
  exit();   
}

/**
* Just sample class, can be declard here or in
* the separate tab. (In the sep. tab NOT ending with ".java")
*/
class MyClass{
}


void printTheClassCanonicalName(Object obj){
   println("Your class canoical name is: " + obj.getClass().getCanonicalName());
}

void printTheClassSimpleName(Object obj){
   println("Your class SIMPLE name is: " + obj.getClass().getSimpleName());
}


void draw(){
}
