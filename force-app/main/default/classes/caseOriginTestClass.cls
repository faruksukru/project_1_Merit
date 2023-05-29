@isTest
public class caseOriginTestClass {
    @isTest
    public static void insertTest(){
        Account testAccount = new Account(Name='Test Account');
        Test.startTest();   
        insert testAccount;
        Case testCase1 = new Case(Status='New', Origin='Phone', AccountId=testAccount.Id);
        insert testCase1;
        Case testCase2 = new Case(Status='New', Origin='Phone', AccountId=testAccount.Id);
        insert testCase2;
        Test.stopTest();
        Case testCase = [SELECT Id, AccountId, ParentId, Origin FROM Case WHERE Id =:testCase2.id];
        system.assertEquals(testCase.ParentId, testCase1.id);
    }
}