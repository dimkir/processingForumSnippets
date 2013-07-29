import java.io.File;
// this tab tab contains code to be able to load Points representing cat-shape.
// The problem is that in AndroidMode shape.getVertex() throws an exception
// so we need a workaround and we need to encapsulate this workaround here


/**
* This is "specific" wrapper for shape, whose only purpose is 
* to get array of points which the shape(subshape in svg) is made of.
*
* TODO: points of the shapes are not returned via "defensive copy". 
* Just reference is returned. Maybe need to rethink how it's done.
*/
class MyShape2
{
  
  private PVector[] mPoints;
  
  private final String C_XML_ROOT = "points";
  private final String C_XML_POINT_NODE = "point";
  private final String C_XML_X = "x";
  private final String C_XML_Y = "y";
  
  
  /**
  * All it does just tries to read shapes from svg.
  * Load points to memory. If possible, it prefers to write
  * and read points from xml, rather than from SVG.
  * 
  */
  MyShape2(String svgFileName, String nodeName){
     dprintln("MyShape2::MyShape2(" + svgFileName+ ", " +  nodeName + ")");
//     String dtPath = dataPath(svgFileName);
//     File fileSvg = new File(dtPath);
//     File fileXml = new File( svgPath2Xml(dtPath) );
     
     /** filename relative to data directory **/
     String xmlFileName = svgPath2Xml(svgFileName);
     
     
  
     //dprintln(file.toString());
    // dprintln("Testing if exists file: [" + fileXml.getAbsolutePath() +"]");
     dprintln("Testing if exists file: [" + xmlFileName +"]");
//     on android exists() doesn't seem to work :(     
//     if ( fileXml.exists() ){
     if ( loadXML(xmlFileName) != null ){
        mPoints = loadPointsFromXml( xmlFileName );
        return;
     }   
     
     //loadPointsFromSvg(dtPath, nodeName);
     // seems like on Android we can't supply to loadShape() full path.
     // which kinda does and doesn't make sense.
     mPoints = loadPointsFromSvg(svgFileName, nodeName);
     
     // TODO: this probably will need to be changed as well
     // so that doesn't use File (as on android it yields some errors)
     savePointsToXml( xmlFileName, mPoints );
  }
  
  
  private PVector[] loadPointsFromXml(String xmlFile){
     dprintln("Loading points from Xml: [" + xmlFile + "]");
     XML xml = loadXML(xmlFile);
     if ( xml == null){
        throw new RuntimeException("Cannot load xml file with points: [" + xmlFile + "]");
     }
     
          
     XML[] xmlPointNodes = xml.getChildren(C_XML_POINT_NODE);
     PVector[] vertices = xmlPointNodesToVertices(xmlPointNodes);
     
     return vertices;
//     dprintln("MyShape2::loadPointsFromXml() is not implemented yet.");
//     throw new RuntimeException("Not implemented yet");
  }
  
  /**
  * Converts NON-EMPTY point node array to array of vertices
  * represented by PVector.
  * @throws RuntimeException() in case array is null or empty
  */
  private PVector[] xmlPointNodesToVertices(XML[] pointNodes){
     if ( pointNodes == null || pointNodes.length == 0){
        throw new RuntimeException("pointNodes array cannot be null or empty");
     }
     PVector[] vertices = new PVector[pointNodes.length];
     for( int i = 0 ;  i < pointNodes.length ; i++){
        XML node = pointNodes[i];
        float x = Float.parseFloat( node.getString(C_XML_X) );
        float y = Float.parseFloat( node.getString(C_XML_Y) );
        PVector v = new PVector(x, y);
        vertices[i] = v;
     }
     return vertices;     
  }
  
  
  /**
  * Saves points array to xml. 
  * @param xmlFile
  * @param points NON-EMPTY array of points
  */ 
  private void savePointsToXml(String xmlFile, PVector[] points){
     XML xml = new XML(C_XML_ROOT);
     for(int i = 0 ; i < points.length ; i++){
         PVector p = points[i];
         XML pointNode = xml.addChild(C_XML_POINT_NODE);
         pointNode.setString(C_XML_X, String.valueOf(p.x) );
         pointNode.setString(C_XML_Y, String.valueOf(p.y) );
     }
     saveXML(xml, xmlFile);
  }
  
  
  
  private String svgPath2Xml(String svgPath){
     return svgPath + ".xml";
  }  
  
  
  /**
  * Loads points using as source of points specific node (element) of SVG.
  * Define by it's id.
  */
  private PVector[] loadPointsFromSvg(String svgFullPath, String elementId){
       // here we do a bit of "acrobatics" in order to load "cat_path".
       // TODO: just make one method which would be loading cat path.
           dprintln("SVG fullpath: [" + svgFullPath + "]");
           PShape shpChineseCat = loadShape(svgFullPath);
           if ( shpChineseCat == null ){
              throw new RuntimeException("could not load svg file");
           }
//           shpLayer1 = getShapeByNameOrThrow("layer1", shpChineseCat);
//           shpCatPath = getShapeByNameOrThrow("cat_path", shpLayer1);
           PShape theCat = getShapeByIdOrThrow( elementId, shpChineseCat);
           
           if ( theCat == null ){
              throw new NullPointerException("wtf. cat cannot be nulL");
           }
        
           // here we actually ask ImageGrid to return cells, into which 
           // the points are falling
           return getPointsFromShape(theCat, 1.0f);
  }
 
 
  PShape  getShapeByIdOrThrow(String id, PShape container){
       PShape rez = findInTree(id, container);
       if ( rez == null ){
          throw new RuntimeException("Cannot find shape with id (" + id + ")");
       } 
       return rez;
  }
  
  /**
  * Recursively searches for the shape with given id.
  */
  private PShape findInTree(String id, PShape container){
       // find on current level
           for(int i = 0 ; i < container.getChildCount(); i++){
              PShape child = container.getChild(i);
              if ( id.equals(child.getName()) ){
                 return child;
              }
           }
       

       // search all chilren recursively
         for(int i = 0; i < container.getChildCount() ; i++){
            PShape child = container.getChild(i);
            PShape shp = findInTree(id, child);
            if ( shp != null ){
               return shp;
            } 
         }
       
       return null; 
  }
  
 
  /**
   * Return all points.
   */ 
  PVector[] getPoints(){
     return getPoints(1.0f);
  }
  
  
  /**
  * 
  * TODO: what happens when you have small or 0 percentage?
  *       need to test.
  */
  PVector[] getPoints(float percentage){
      if ( percentage < 0.0 ){
         throw new IllegalArgumentException("Percentage cannot be less than 0");
      }
      
      if ( percentage >= 1.0f ){
         return mPoints;
      }
      
      ArrayList<PVector> points = new ArrayList<PVector>();
      
      
      for(int i = 0 ; i < mPoints.length ; i++){
         float r = random(1);
         if ( r < percentage ){
            points.add(mPoints[i]);
         }
      }
      
      PVector[] retPoints = new PVector[points.size()];
      retPoints = points.toArray(retPoints);
      return retPoints;
    
  }
  
 
 
  
  private void dprintln(String s){
     println(s);
  }
  
}
