// Written by Jon Sayer, jon@datageekslab.com, as part of June 2021 Community Sprint

// Test class for geoCodey_UTIL

@isTest
public class geoCodey_TEST {
    
    @isTest static void testPointsAndPolygons(){
        List<geoCodey_UTIL.Point> Square = new List<geoCodey_UTIL.Point>();
        Square.add(geoCodey_UTIL.makePoint(2.0,2.0));
        Square.add(geoCodey_UTIL.makePoint(6.0,2.0));
        Square.add(geoCodey_UTIL.makePoint(6.0,6.0));
        Square.add(geoCodey_UTIL.makePoint(2.0,6.0));
        
        system.assertEquals(False, geoCodey_UTIL.isInside(Square, geoCodey_UTIL.makePoint(1.0,1.0)));
        system.assertEquals(True, geoCodey_UTIL.isInside(Square, geoCodey_UTIL.makePoint(4.0,4.0)));
        system.assertEquals(False, geoCodey_UTIL.isInside(Square, geoCodey_UTIL.makePoint(1.0,4.0)));
        
        List<geoCodey_UTIL.Point> ComplexShape = new List<geoCodey_UTIL.Point>();
        ComplexShape.add(geoCodey_UTIL.makePoint(2.0,3.0));
        ComplexShape.add(geoCodey_UTIL.makePoint(9.0,1.0));
        ComplexShape.add(geoCodey_UTIL.makePoint(8.0,7.0));
        ComplexShape.add(geoCodey_UTIL.makePoint(6.0,6.0));
        ComplexShape.add(geoCodey_UTIL.makePoint(5.0,8.0));
        ComplexShape.add(geoCodey_UTIL.makePoint(3.0,6.0));
        
        system.assertEquals(True, geoCodey_UTIL.isInside(ComplexShape, geoCodey_UTIL.makePoint(6.0,2.0)));
        system.assertEquals(False, geoCodey_UTIL.isInside(ComplexShape, geoCodey_UTIL.makePoint(3.0,7.0)));
        system.assertEquals(False, geoCodey_UTIL.isInside(ComplexShape, geoCodey_UTIL.makePoint(2.0,4.0)));
        system.assertEquals(True, geoCodey_UTIL.isInside(ComplexShape, geoCodey_UTIL.makePoint(5.0,7.0)));
        
    }

}