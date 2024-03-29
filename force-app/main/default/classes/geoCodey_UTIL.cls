// Written by Jon Sayer, jon@datageekslab.com, as part of June 2021 Community Sprint
// This utility class contains functionality to determine if a point is within a polygon, used for geolocation.
// Can also match the same to Geographic_Definition__c records

public class geoCodey_UTIL {
    
    // This method returns the Id of a Geo Definition record that the provided point is within. 
    public static Id getTheGeoDef(Decimal latitude,Decimal longitude){
        List<Geographic_Definition__c> defs = [
            SELECT 	id,
            		Name,
            		Geographic_ID__c,
            		Internal_Point__c,
            		Land_Area__c,
            		Latitude_Northern_Most__c,
            		Latitude_Southern_Most__c,
            		Longitude_Eastern_Most__c,
            		Longitude_Western_Most__c,
            		Parent_Geography_Definition__c,
            		Polygon__c,
            		Secondary_Name__c,
            		Type__c,
            		Water_Area__c
            FROM 	Geographic_Definition__c
            WHERE 	Latitude_Northern_Most__c >= :latitude
             AND	Latitude_Southern_Most__c <= :latitude
             AND	Longitude_Eastern_Most__c >= :longitude
             AND	Longitude_Western_Most__c <= :longitude
        ];
        
        system.debug( 'found units:' + defs.size() );
        
        if(defs.size() == 0){
            return null;
        } else {
            for(Geographic_Definition__c def : defs){
                Id returned = geoDefIndivMatch(def,latitude,longitude);
                if(returned != null){
                    return returned;
                }
            }
            // if we get here, we've looped through the whole list and nothing was found. 
            return null;
        }
    }
    
    // this method returns the def id if the lat/long is inside the region
    // else returns null
    public static Id geoDefIndivMatch(Geographic_Definition__c def, Decimal latitude,Decimal longitude){
        List<Point> polygon = parsePolygon(def.Polygon__c);
        Boolean inside = isInside(polygon, makePoint( longitude,latitude ));
        if(inside){
            return def.id;
        } else {
            return null;
        }
    }
    
    // Sets the extreme points on a provided list of Geo defs, such as from a trigger
    public static void populateExtremePoints(List<Geographic_Definition__c> defs){
        List<Geographic_Definition__c> updateDefs = new List<Geographic_Definition__c>();
        for(Geographic_Definition__c def : defs){
            // generate a list of points as string pairs
            List<String> pairStrings = def.Polygon__c.replace('MULTIPOLYGON ', '').replace('POLYGON ', '').replace('(', '').replace(')', '').split(',');
            
            // generate point variables at their opposite extreme
            Decimal N = -90;
            Decimal S = 90;
            Decimal E = -180;
            Decimal W = 180;
            
            for(String pair : pairStrings){
                List<String> latLong = pair.split(' ');
                system.debug('Pair: ' + pair);
                system.debug('Split: ' + latLong[0] + ', ' + latLong[1]);
                if(N < Decimal.valueOf(latLong[1])){
                    N = Decimal.valueOf(latLong[1]);
                }
                if(S > Decimal.valueOf(latLong[1])){
                    S = Decimal.valueOf(latLong[1]);
                }
                if(E < Decimal.valueOf(latLong[0])){
                    E = Decimal.valueOf(latLong[0]);
                }
                if(W > Decimal.valueOf(latLong[0])){
                    W = Decimal.valueOf(latLong[0]);
                }
            }
            // to do, add a step here to make sure that if there is no change to the values on the existing record, to just not update that record
            def.Latitude_Northern_Most__c = N;
            def.Latitude_Southern_Most__c = S;
            def.Longitude_Eastern_Most__c = E;
            def.Longitude_Western_Most__c = W;
            updateDefs.add(def);
        }
        if(updateDefs.size() > 0){
            update updateDefs;
        }
    }
    
    // Takes in WKT formatted shape string and outputs a List of Points
    // https://en.wikipedia.org/wiki/Well-known_text_representation_of_geometry
    public static List<Point> parsePolygon(String polygon){
        List<Point> points = new List<Point>();
        
        List<String> pairStrings = polygon.replace('MULTIPOLYGON ', '').replace('POLYGON ', '').replace('(', '').replace(')', '').split(',');
        for(String pair : pairStrings){
            List<String> latLong = pair.split(' ');
            points.add( makePoint(Decimal.valueOf(latLong[0]),Decimal.valueOf(latLong[1]) ) );
        }
        
        return points;
    }
    
    
    /******** Below this line, this is mainly a port of this javascript code into Apex: https://www.geeksforgeeks.org/how-to-check-if-a-given-point-lies-inside-a-polygon/  ****/

    public class Point{
        public Decimal x;
        public Decimal y;
    }
    
    public static Point makePoint(Decimal x,Decimal y){
        Point p = new Point();
        p.x = x;
        p.y = y;
        return p;
    }
    
	// Given three colinear points p, q, r,
    // the function checks if point q lies
    // on line segment 'pr'
    public static boolean onSegment(Point p, Point q, Point r) {
        if (q.x <= Math.max(p.x, r.x) &&
            q.x >= Math.min(p.x, r.x) &&
            q.y <= Math.max(p.y, r.y) &&
            q.y >= Math.min(p.y, r.y))
        {
            return true;
        }
        return false;
    }
    
    // To find orientation of ordered triplet (p, q, r).
    // The function returns following values
    // 0 --> p, q and r are colinear
    // 1 --> Clockwise
    // 2 --> Counterclockwise
    public static Integer orientation(Point p, Point q, Point r) {
        Decimal val = (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y);
        
        if (val == 0) {
            return 0; // colinear
        }
        return (val > 0) ? 1 : 2; // clock or counterclock wise
    }
    
    // The function that returns true if
    // line segment 'p1q1' and 'p2q2' intersect.
    public static Boolean doIntersect(Point p1,Point q1,Point p2,Point q2) {
    	// Find the four orientations needed for
        // general and special cases
        Integer o1 = orientation(p1, q1, p2);
        Integer o2 = orientation(p1, q1, q2);
        Integer o3 = orientation(p2, q2, p1);
        Integer o4 = orientation(p2, q2, q1);
  
        // General case
        if (o1 != o2 && o3 != o4) {
            return true;
        }
  
        // Special Cases
        // p1, q1 and p2 are colinear and
        // p2 lies on segment p1q1
        if (o1 == 0 && onSegment(p1, p2, q1)) {
            return true;
        }
  
        // p1, q1 and p2 are colinear and
        // q2 lies on segment p1q1
        if (o2 == 0 && onSegment(p1, q2, q1)) {
            return true;
        }
  
        // p2, q2 and p1 are colinear and
        // p1 lies on segment p2q2
        if (o3 == 0 && onSegment(p2, p1, q2)) {
            return true;
        }
  
        // p2, q2 and q1 are colinear and
        // q1 lies on segment p2q2
        if (o4 == 0 && onSegment(p2, q1, q2)) {
            return true;
        }
  
        // Doesn't fall in any of the above cases
        return false;
	}
    
    // Returns true if the point p lies
    // inside the polygon[] with n vertices
    public static boolean isInside(List<Point> polygon, Point p) {
        // There must be at least 3 vertices in polygon[]
        if (polygon.size() < 3) {
            return false;
        }
        
        // Create a point for line segment from p to infinite
        Point extreme = new Point();
        // as the highest Longitude is 180, we will make "infinite" double that. 
        extreme.x = 360;
        extreme.y = p.y;
        
        // Count intersections of the above line
        // with sides of polygon
        Integer count = 0; 
        
        for(Integer i = 0; i < polygon.size(); i++) {
            Integer next = Math.mod((i + 1),polygon.size());
            
            // Check if the line segment from 'p' to
            // 'extreme' intersects with the line
            // segment from 'polygon[i]' to 'polygon[next]'
            if (doIntersect(polygon[i], polygon[next], p, extreme)) {
                // If the point 'p' is colinear with line
                // segment 'i-next', then check if it lies
                // on segment. If it lies, return true, otherwise false
                if (orientation(polygon[i], p, polygon[next]) == 0) {
                    return onSegment(polygon[i], p, polygon[next]);
                }
                count++;
            }
        }
        
        system.debug('Sides of polygon: '+polygon.size());
        system.debug('Number of times intercepted: '+count);
        
        // Return true if count is odd, false if even
        return (Math.mod(count,2) == 1); 
    }
    
    /******** End borrowed code  ****/
    
}