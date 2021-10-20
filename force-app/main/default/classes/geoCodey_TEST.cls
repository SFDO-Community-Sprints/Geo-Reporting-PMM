// Written by Jon Sayer, jon@datageekslab.com, as part of June 2021 Community Sprint

// Test class for geoCodey_UTIL, geoCodey_ExtremePoint_BATCH

@isTest
public class geoCodey_TEST {
    
    @isTest static void testExtremeBatch(){
        // create test data
        Geographic_Defination__c colorado = new Geographic_Defination__c(
        	Name = 'Colorado',
            Polygon__c = 'MULTIPOLYGON (((-109.000 41.000,-102.000 41.000,-102.000 37.000,-109.000 37.000)))',
            Geographic_Id__c = 'CO'
        );
        insert colorado;
        
        test.startTest();
        
        geoCodey_ExtremePoint_BATCH batch = new geoCodey_ExtremePoint_BATCH();  
        String chron = '0 0 0 * * ?';        
        system.schedule('Test Schedule', chron, batch);
        batch.execute(null);
        
        test.stopTest();
        
        Geographic_Defination__c result = [SELECT 	id, 
                                           			Latitude_Northern_Most__c,
                                           			Latitude_Southern_Most__c,
            										Longitude_Eastern_Most__c,
                                           			Longitude_Western_Most__c
                                          FROM		Geographic_Defination__c
                                          WHERE		id = :colorado.Id];
        
        system.assertEquals(41, result.Latitude_Northern_Most__c);
        system.assertEquals(37, result.Latitude_Southern_Most__c);
        system.assertEquals(-102, result.Longitude_Eastern_Most__c);
        system.assertEquals(-109, result.Longitude_Western_Most__c);
    }
    
    @isTest static void testPointMatch(){
        // create test data
        Geographic_Defination__c colorado = new Geographic_Defination__c(
        	Name = 'Colorado',
            Polygon__c = 'MULTIPOLYGON (((-109.000 41.000,-102.000 41.000,-102.000 37.000,-109.000 37.000)))',
            Latitude_Northern_Most__c = 41.00,
            Latitude_Southern_Most__c = 37.00,
            Longitude_Eastern_Most__c = -102.00,
            Longitude_Western_Most__c = -109.00,
            Geographic_Id__c = 'CO'
        );
        insert colorado;
        
        // create test data
        Geographic_Defination__c wyoming = new Geographic_Defination__c(
        	Name = 'wyoming',
            Polygon__c = 'MULTIPOLYGON (((-104.000 41.000,-111.000 41.000,-111.000 45.000,-104.000 45.000)))',
            Latitude_Northern_Most__c = 45.00,
            Latitude_Southern_Most__c = 41.00,
            Longitude_Eastern_Most__c = -104.00,
            Longitude_Western_Most__c = -111.00,
            Geographic_Id__c = 'WY'
        );
        insert wyoming;
        
        // Denver is in Colorado
        system.assertEquals(colorado.id, geoCodey_UTIL.getTheGeoDef(39.758524, -105.004322));
        
        // Old Faithful is in Wyoming
        system.assertEquals(wyoming.id, geoCodey_UTIL.getTheGeoDef(44.460180, -110.828443));
    }
    
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