@isTest
public with sharing class CaseRestServiceProviderTest {
    @isTest
    static void testGetCaseService_3() {
        // Create a test Case
        Case testCase = new Case(Subject = 'Test Case', Status = 'New', Origin = 'Phone', Priority = 'High');
        System.Test.startTest();
        insert testCase;
        // Call the REST service
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestURI = '/services/apexrest/Cases/' + testCase.Id;
        RestContext.request = request;
        
        Case result = CaseRestServiceProvider.getCaseService();
        System.Test.stopTest();
        
        // Verify the result
        System.assertEquals(testCase.Id, result.Id);
        System.assertEquals(testCase.CaseNumber, result.CaseNumber);
        System.assertEquals(testCase.Subject, result.Subject);
        System.assertEquals(testCase.Status, result.Status);
        System.assertEquals(testCase.Origin, result.Origin);
        System.assertEquals(testCase.Priority, result.Priority);
    }
    
    @isTest
    static void testCreateCase() {
        // Prepare the request body
        Case newCase = new Case(Subject = 'Test Case', Status = 'New', Origin = 'Phone', Priority = 'High');
        String requestBody = JSON.serialize(newCase);
        
        // Call the REST service
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestURI = '/services/apexrest/Cases/';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf(requestBody);
        RestContext.request = request;
        System.Test.startTest();
        Case result = CaseRestServiceProvider.postCaseService(newCase);
        System.Test.stopTest();
        
        // Verify the result
        System.assertEquals(newCase.Subject, result.Subject);
        System.assertEquals(newCase.Status, result.Status);
        System.assertEquals(newCase.Origin, result.Origin);
        System.assertEquals(newCase.Priority, result.Priority);
    }
    
    @isTest
    static void testUpdateCase() {
        // Create a test Case
        Case testCase = new Case(Subject = 'Test Case', Status = 'New', Origin = 'Phone', Priority = 'High');
        insert testCase;
        
        // Prepare the request body
        Case updatedCase = new Case(Id = testCase.Id, Subject = 'Updated Test Case', Status = 'In Progress', Origin = 'Email', Priority = 'Low');
        String requestBody = JSON.serialize(updatedCase);
        
        // Call the REST service
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestURI = '/services/apexrest/Cases/';
        request.httpMethod = 'PUT';
        request.requestBody = Blob.valueOf(requestBody);
        RestContext.request = request;
        System.Test.startTest();
        Case result = CaseRestServiceProvider.putCaseService(updatedCase);
        System.Test.stopTest();
        
        // Verify the result
        System.assertEquals(updatedCase.Id, result.Id);
        System.assertEquals(updatedCase.Subject, result.Subject);
        System.assertEquals(updatedCase.Status, result.Status);
        System.assertEquals(updatedCase.Origin, result.Origin);
        System.assertEquals(updatedCase.Priority, result.Priority);
    }
    
    @isTest
    static void testDeleteCaseService() {
        // Create a test Case
        Case testCase = new Case(Subject = 'Test Case', Status = 'New', Origin = 'Phone', Priority = 'High');
        insert testCase;
        
        // Call the REST service
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestURI = '/services/apexrest/Cases/' + testCase.Id;
        request.httpMethod = 'DELETE';
        RestContext.request = request;
        System.Test.startTest();
        CaseRestServiceProvider.deleteCaseService();
        System.Test.stopTest();
        
        // Verify the Case is deleted
        List<Case> deletedCase = [SELECT Id FROM Case WHERE Id = :testCase.Id];
        System.assertEquals(0, deletedCase.size());
    }
}