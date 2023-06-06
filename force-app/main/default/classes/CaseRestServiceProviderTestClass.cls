@isTest
public with sharing class CaseRestServiceProviderTestClass {
    @isTest static void testGetCaseService_3() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/cases/'+ recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Case thisCase = CaseRestServiceProvider.getCaseService();
        // Verify results
        System.assert(thisCase != null);
        System.assertEquals('Test record', thisCase.Subject);
    }
    @isTest static void testCreateCase() {
        // Call the method to test
        Case caseTest = new Case(Subject='insert new test',Status='New', Origin='Phone',Priority='Medium');
        Case thisCase = CaseRestServiceProvider.postCaseService(caseTest);
        // Verify results
        System.assert(thisCase.Id != null);
        Case thisNewCase = [SELECT Id,Subject FROM Case WHERE Id=:thisCase.Id];
        System.assert(thisNewCase != null);
        System.assertEquals(thisNewCase.Subject, 'insert new test');
    }
    @isTest static void testDeleteCase() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/Cases/'+ recordId;
        request.httpMethod = 'DELETE';
        RestContext.request = request;
        // Call the method to test
        CaseRestServiceProvider.deleteCaseService();
        // Verify record is deleted
        List<Case> cases = [SELECT Id FROM Case WHERE Id=:recordId];
        System.assert(cases.size() == 0);
    }
    @isTest static void testUpsertCase() {
        // 1. Insert new record
        Case caseTest1 = new Case(Subject='insert new test',Status='New', Origin='Phone',Priority='Medium');
        Case thisCase1 = CaseRestServiceProvider.putCaseService(caseTest1);
        // Verify new record was created
        System.assert(thisCase1.Id != null);
        Case thisNewCase1 = [SELECT Id,Subject FROM Case WHERE Id=:thisCase1.Id];
        System.assert(thisNewCase1 != null);
        System.assertEquals(thisNewCase1.Subject, 'insert new test');
        // 2. Update status of existing record to Working
        Case caseTest2 = new Case(Subject='insert new test',Status='Working', Origin='Phone',Priority='Medium', Id=thisCase1.Id);
        Case thisCase2 = CaseRestServiceProvider.putCaseService(caseTest2);
        // Verify record was updated
        System.assertEquals(thisCase1.Id, thisCase2.Id);
        Case thisNewCase2 = [SELECT Id,Status FROM Case WHERE Id=:thisCase2.Id];
        System.assert(thisNewCase2 != null);
        System.assertEquals(thisNewCase2.Status, 'Working');
    }    
    // Helper method
    static Id createTestRecord() {
        // Create test record
        Case caseTest = new Case(
            Subject='Test record',
            Status='New',
            Origin='Phone',
            Priority='Medium');
        insert caseTest;
        return caseTest.Id;
    }   
}