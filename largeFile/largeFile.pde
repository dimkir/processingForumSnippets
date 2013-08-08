final String C_BIG_FILE = "c:\\tmp\\tmp\\myfile.txt";
//final String C_BIG_FILE = "lifta txt.txt";
Point[] pcloud;
int pointNum = 0;

void setup() {
  println("Starting sketch...");
  int timeStart = millis();
  String[] lines = loadStrings(C_BIG_FILE);
  int timeLoadingStrings = millis() - timeStart;
  
  timeStart = millis();
  pcloud = new Point[lines.length];
  int timeInitializingPointsArray = millis() - timeStart; 
  
  
  timeStart = millis();
  for (int i = 0; i < lines.length; i++) {
    String[] pieces = splitTokens(lines[i]);
    if (pieces.length == 6) {
      pcloud[pointNum] = new Point(pieces);
      pointNum++;
    }
  }
  int timePopulatingPointsArray = millis() - timeStart;
  
  println("Time loading strings to memory: " + timeLoadingStrings);
  println("Time initializing ponits array: " + timeInitializingPointsArray);
  println("Time populaintg points array  : " + timePopulatingPointsArray);
  
  // println is the slowest and  takes 2-3 minutes and freezes your sketch.
  // thus we comment it out. 
//  for (int i = 0; i < pointNum; i++) {
//    println(i);
//  }
}

class Point {
  float x;
  float y;
  float z;
  int r;
  int g;
  int b;

  public Point(String[] pieces) {
    x = float(pieces[0]);
    y = float(pieces[1]);
    z = float(pieces[2]);
    r = int(pieces[3]);
    g = int(pieces[4]);
    b = int(pieces[5]);
  }

}

      

