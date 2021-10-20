global class geoCodey_ExtremePoint_BATCH  implements Database.Batchable<sObject> , schedulable {

    String query;
    
    global geoCodey_ExtremePoint_BATCH(){
        query = 'SELECT id, Latitude_Northern_Most__c, Latitude_Southern_Most__c, Longitude_Eastern_Most__c,Polygon__c, Longitude_Western_Most__c FROM Geographic_Defination__c WHERE Latitude_Northern_Most__c = null OR Latitude_Southern_Most__c = null OR Longitude_Eastern_Most__c = null OR Longitude_Western_Most__c = null';
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
 
    global void execute(Database.BatchableContext BC, List<Geographic_Defination__c> scope){
         geoCodey_UTIL.populateExtremePoints(scope);
    }  
    
    global void finish(Database.BatchableContext BC){
    }
    
    global void execute(SchedulableContext sc)
    {
        geoCodey_ExtremePoint_BATCH b = new geoCodey_ExtremePoint_BATCH();
       
        database.executebatch(b,1);
    }
    
}