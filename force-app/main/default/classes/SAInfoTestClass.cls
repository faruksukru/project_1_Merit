@isTest
public with sharing class SAInfoTestClass {
   @isTest
     Public static void test(){
        System.Test.startTest();
        List<SA_Detail__c> saList = new List<SA_Detail__c>();
        SA_Detail__c SARecord1 = new SA_Detail__c(Name__c = 'Test SA1', 
                                                  Date_of_Joining__c=system.today(), 
                                                  Location__latitude__s =41.025, 
                                                  Location__longitude__s=28.97);
        saList.add(SARecord1);
        SA_Detail__c SARecord2 = new SA_Detail__c(Name__c = 'Test SA2', 
                                                  Date_of_Joining__c=system.today(),
                                                  Location__latitude__s =41, 
                                                  Location__longitude__s=28);
        saList.add(SARecord2);
        insert saList;
        String filter1 = 'Test SA1';
        List<SA_Detail__c> testResult1= SAInfo.getSASearch(filter1);
        String filter2 = '';
        SAInfo.getSASearch(filter2); 
        System.Test.stopTest();
        system.assertEquals(41.025, testResult1[0].Location__latitude__s);
        system.assertEquals(28.97, testResult1[0].Location__longitude__s); 
        
    }
}