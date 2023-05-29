@isTest
public class existOpportunityonAccountTest {
    @isTest
    public static void insertTest(){
        List<Account> testAccountsSetup = new List<Account>();
        for(Integer i=1;i<5;i++){
            testAccountsSetup.add(new Account (Name='Test Account '+i));   
        }
        Test.startTest();   
        insert testAccountsSetup;
        Test.stopTest();
        List<Account> accList = [SELECT Id, Name, (SELECT Id, Name, StageName, CloseDate, AccountId FROM Opportunities) FROM Account WHERE Name Like 'Test Account%'];
        for(Account w:accList){
            Opportunity opp = w.Opportunities;    
            system.assertEquals(w.Name+' Opportunity', Opp.Name);
            system.assertEquals('Prospecting', Opp.StageName);
            system.assertEquals(system.Today()+30, Opp.CloseDate);
        }
    }
    
    @isTest
    public static void updateTest(){
        Account acnt = new Account();
        acnt.Name = 'Test Account';
        Test.startTest();
        Insert acnt;
        Opportunity oppDelete = [SELECT Id FROM Opportunity WHERE AccountId=:acnt.id];
        Delete oppDelete;
        acnt.Name = 'New Test Account';
        Update acnt;
        Test.stopTest();
        Opportunity Opp = [SELECT Id, Name, StageName, CloseDate FROM Opportunity WHERE AccountId=:acnt.id];        
        system.assertEquals('New Test Account Opportunity', Opp.Name);
        system.assertEquals(system.Today()+30, Opp.CloseDate);
    }
}