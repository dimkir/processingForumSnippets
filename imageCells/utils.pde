void clearScreen(color c, int alpha_0_to_100){
   fill(c, alpha_0_to_100);
   noStroke();
   rect(0,0, width, height);
}
