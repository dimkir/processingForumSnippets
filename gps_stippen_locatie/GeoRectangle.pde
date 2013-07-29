/**
* Just a convenience class which serves as
* a container for the rectangle of geo-coordinates.
*/
class GeoRectangle
{
  float mapGeoTop;
  float mapGeoBottom;
  float mapGeoLeft;
  float mapGeoRight;

  /**
  * Calculated values.
  */
  float mapGeoWidth;
  float mapGeoHeight;  
   
  GeoRectangle(float x0, float y0, float x1, float y1){
     mapGeoTop = y0;
     mapGeoBottom = y1;
     mapGeoLeft= x0;
     mapGeoRight = x1;
     
     mapGeoHeight = mapGeoTop - mapGeoBottom;
     mapGeoWidth = mapGeoRight - mapGeoLeft;
  }
  
}
