/**
* This is just single instance of bouncing ball, which 
* moves around and updates. 
* As it is single ball, it doesn't need "world" object to refer.
* This class is useful when you want some drawing to happen on the screen.
*/
class BouncingBall
{
   float x,y;
   private float ww, hh;
   float vx, vy;
   
   /**
   * Initializes ball and the boundaries. and places ball by default in the middle of the rectangle. 
   */
   
   BouncingBall(int w, int h, float vvx, float vvy){
      ww= w; 
      hh = h;
      x = ww / 2;
      y = hh / 2;
      vx = vvx;
      vy = vvy;
   }
   
   BouncingBall(int w, int h){
       this(w,h, 1.0f, 1.0f);
   }
   

   /**
   * Updates position of the ball.
   * PRE-CONDITION:
   *  ball is in valid location.
   */   
   void update(){
       x += vx;
       y += vy;
       println("before checkEdges(" + toString() + ") velocity(" + vx + ", " + vy + ")");
       checkEdges(); // checks if now we're out of range.
       println("after checkEdges(" + toString() + ")");
   }
   
   
   @Override
   String toString(){
      return "(" + x + ", " + y + ")";
   }
   
   void checkEdges(){
      if ( xIsOut() ){
         println("xIsOut(" + x + ")");
//         // we need to fix x
//         while ( x < 0 ){
//            x += ww;
//         }
//         while( x >= ww ){
//              x -= ww;
//         }
         vx = -1.0f * vx;
      }
      
         if ( yIsOut() ){
            println("yIsout(" + y + ")");
//            while( y < 0 ){
//               y += hh;
//            }  
//            while ( y >= hh){
//               y -= hh;
//            }
            
            vy = -1.0f * vy;
         }
   }//checkEdges
 
   /**
   * Returns true if x coordinate is out of range.
   */
   private boolean xIsOut(){
      return ( x < 0 || x >= ww );
   }
 
   /**
   * Return true if y coordinate is out of range.
   */
   private boolean yIsOut(){
      return ( y < 0 || y >= hh);
   }  
}

