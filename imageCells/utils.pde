void clearScreen(color c, int alpha_0_to_100){
   fill(c, alpha_0_to_100);
   noStroke();
   rect(0,0, width, height);
}


/**
* Gets shape with id {nodeId} from the root of the given shape.
* Or throws RuntimeException()
*/
PShape getShapeByNameOrThrow(String nodeId, PShape rootShape){
      PShape[] children = rootShape.getChildren();
      for( PShape child : children ){
         if ( child.getName().equals(nodeId) ){
            return child;
         }
      }  
      throw new RuntimeException("Cannot find shape with id [" + nodeId + "] inside of shape " + rootShape); 
}




void drawVertices(PShape shp){
   PVector v=  new PVector();
   println("** utils.pde ** drawVertices():: Vertex count: " + shp.getVertexCount() );
   for(int i = 0 ; i < shp.getVertexCount() ; i++){
       shp.getVertex(i, v);
       ellipse(v.x, v.y, 3, 3);
   }
}



/**
* Creates array of points from the shape. 
* What happens if there's 0 shapes?
* The simpliest solution is to throw an exception.
*/
PVector[] getPointsFromShape(PShape shp){
   int vertexCount = shp.getVertexCount();
   if ( vertexCount == 0 ){
      throw new RuntimeException(
      "Shape (or the current node of the shape) doesn't have any vertices. " + 
      "Maybe children nodes have. Shape has: " + shp.getChildCount() + " children");
   }
   PVector[] points = new PVector[vertexCount];
   for(int i = 0; i < vertexCount ; i++){
      points[i] = shp.getVertex(i);
   }  
  
   return points; 
}
