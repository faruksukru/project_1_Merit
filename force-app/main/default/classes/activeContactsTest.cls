@isTest
public class activeContactsTest {
    @testSetup static void setup(){
        Account testAccount = new Account(Name='Test Account');
        insert testAccount;
        List<Contact> testContacts = new List<Contact>();
        for(Integer i=1;i<3;i++){
            testContacts.add(new Contact (LastName='Test Account '+i, Active__c=True, AccountId=testAccount.id));   
        }
        for(Integer i=3;i<5;i++){
            testContacts.add(new Contact (LastName='Test Account '+i, Active__c=False, AccountId=testAccount.id));   
        }
        Test.startTest();   
        insert testContacts;
        Test.stopTest();   
    }
    @isTest
    public static void insertTest(){
        List<Contact> testContactsInsert = new List<Contact>();
        Account acc = [SELECT Id FROM Account WHERE Name ='Test Account'];
        for(Integer i=1;i<3;i++){
            testContactsInsert.add(new Contact (LastName='Test Account Insert '+i, Active__c=True, AccountId=acc.id));   
        }
        for(Integer i=3;i<5;i++){
            testContactsInsert.add(new Contact (LastName='Test Account Insert '+i, Active__c=False, AccountId=acc.id));   
        }
        Test.startTest();   
        insert testContactsInsert;
        Test.stopTest();
        Account acc1 = [SELECT Id, Active_Contacts__c FROM Account WHERE Name ='Test Account'];
        system.assertEquals(4, acc1.Active_Contacts__c);
    }
    
    @isTest
    public static void updateTest(){
        Account acc = [SELECT Id FROM Account WHERE Name ='Test Account'];
        List<Contact> cnt1 = [SELECT Id, Active__c FROM Contact WHERE Active__c=True AND AccountId=:acc.Id];
        cnt1[0].Active__c=False;
        Test.startTest();   
        update cnt1;
        Test.stopTest();
        Account acc2 = [SELECT Id, Active_Contacts__c FROM Account WHERE Name ='Test Account'];
        system.assertEquals(1, acc2.Active_Contacts__c);
    }
    
    @isTest
    public static void deleteTest(){
        Account acc = [SELECT Id FROM Account WHERE Name ='Test Account'];
        List<Contact> cnt1 = [SELECT Id, Active__c FROM Contact WHERE Active__c=True AND AccountId=:acc.Id];
        Test.startTest();   
        delete cnt1[0];
        Test.stopTest();
        Account acc3 = [SELECT Id, Active_Contacts__c FROM Account WHERE Name ='Test Account'];
        system.assertEquals(1, acc3.Active_Contacts__c);
    }
    
    @isTest
    public static void undeleteTest(){
        Account acc = [SELECT Id FROM Account WHERE Name ='Test Account'];
        List<Contact> cnt1 = [SELECT Id, Active__c FROM Contact WHERE Active__c=True AND AccountId=:acc.Id];
        Test.startTest();   
        delete cnt1[0];
        undelete cnt1[0];
        Test.stopTest();
        Account acc4 = [SELECT Id, Active_Contacts__c FROM Account WHERE Name ='Test Account'];
        system.assertEquals(2, acc4.Active_Contacts__c);
    }
}