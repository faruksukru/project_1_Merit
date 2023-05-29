@isTest 
public class LeadSourceManualTest {
    @isTest
    public static void batchTest(){
        List<Lead> testLeads = new List<Lead>();
        for(Integer i=0 ;i <200;i++){
            Lead testLead = new Lead();
            testLead.LastName ='Test'+i;
            testLead.Company ='	Company'+i;
            testLeads.add(testLead);
        }
        Test.startTest();
        insert testLeads;
        Database.executeBatch(new LeadSourceManual());
        Test.stopTest();
        Lead testL = [SELECT id,LeadSource FROM Lead LIMIT 1];
        system.assertEquals('Manual', testL.LeadSource);
    }
}