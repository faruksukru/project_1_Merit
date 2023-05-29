public class existOpportunityHandler {
    public static void newOpp (List<Account> accRecords) {
        List<Opportunity> newOppList = new List<Opportunity>();
        for (Account w:accRecords){
            Opportunity newOpportunity = new Opportunity(Name = w.Name + ' Opportunity', StageName = 'Prospecting', CloseDate = system.Today()+30, AccountId=w.Id);
            newOppList.add(newOpportunity);
        }
        if(newOppList.size()!=0){
            database.insert (newOppList, True);
        }
    }
    public static void existOpp (List<Account> accRecords) {
        List<Opportunity> newOppList = new List<Opportunity>();
        List<Account>  accList = new List<Account>();
        Set<Id> accountIds = new Set<Id>();
        for(Account w:accRecords){
            accountIds.add(w.Id);
        }
        accList = [SELECT Id, Name, (SELECT Id FROM Opportunities) FROM Account WHERE Id IN:accountIds];
        for (Account w:accList){
            if(w.Opportunities.size()==0){
                Opportunity newOpportunity = new Opportunity(Name = w.Name + ' Opportunity', StageName = 'Prospecting', CloseDate = system.Today()+30, AccountId=w.Id);
                newOppList.add(newOpportunity);
            }
            if(newOppList.size()!=0){
                database.insert (newOppList, True);
            }
        }
    }
}