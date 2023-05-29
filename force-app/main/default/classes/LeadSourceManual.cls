public class LeadSourceManual implements Database.Batchable <SObject> {
    public Database.QueryLocator start (Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id, LeadSource FROM Lead');   
    }
    public void execute(Database.BatchableContext bc, List<Lead> leadList){
        for(Lead w:leadList){
            w.LeadSource ='Manual';
        }
        Database.update(leadList, True);
        
    } 
    Public void Finish (Database.BatchableContext bc){
    }
}