@isTest
public class followUpTaskCreationTestClass {
    @isTest
    public static void insertTest(){
        Opportunity testOpp1 = new Opportunity(Name = 'Test Opp 1', StageName = 'Closed Won', CloseDate = system.Today()+30);
        Opportunity testOpp2 = new Opportunity(Name = 'Test Opp 2', StageName = 'Closed Lost', CloseDate = system.Today()+30);
        Try{ 
            insert testOpp1;
            insert testOpp2;
        }catch(Exception e){
            System.assert(e.getMessage().contains('The newly created Opportunity record cannot stage Closed Won or Closed Lost'));   
        }
    }
    
    @isTest
    public static void beforeUpdateTest(){
        Opportunity testOpp = new Opportunity(Name = 'Test Opp', StageName = 'Prospecting', CloseDate = system.Today()+30);
        Try{ 
            insert testOpp;
            testOpp.StageName='Closed Won'; 
            update testOpp;
        }catch(Exception e){
            System.assert(e.getMessage().contains('Opportunity Account information must be filled'));   
        } 
    }
    
    @isTest
    public static void afterUpdateTest(){
        Account acnt = new Account (Name='Test Account');
        insert acnt;
        Opportunity testOpp = new Opportunity(Name = 'Test Opp 1', StageName = 'Prospecting', CloseDate = system.Today(), AccountId=acnt.id);
        Test.startTest();   
        insert testOpp;
        testOpp.StageName='Closed Won';
        update testOpp;
        Test.stopTest();
        Task Tsk = [SELECT Id, Subject, ActivityDate, WhatId, OwnerId FROM Task WHERE WhatId =:testOpp.id]; 
        system.assertEquals('Follow up Task', Tsk.Subject);
        system.assertEquals(testOpp.CloseDate.addMonths(1), Tsk.ActivityDate);
        system.assertEquals(testOpp.id, Tsk.WhatId);
    }
}