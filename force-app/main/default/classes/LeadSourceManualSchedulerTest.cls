@isTest
public class LeadSourceManualSchedulerTest {
    @isTest static void executeTest(){
        SchedulableContext sc = null;
        LeadSourceManualScheduler tsc = new LeadSourceManualScheduler();
        tsc.execute(sc);
    }  
}