public class LeadSourceManualScheduler implements Schedulable {
    public void execute (SchedulableContext sc){
       Database.executeBatch(new LeadSourceManual(), 10); 
    }

}