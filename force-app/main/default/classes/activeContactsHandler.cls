public class activeContactsHandler {
    public static void countActive (List<Contact> contactRecords){
        List<Account>  accList = new List<Account>();
        List<Account>  accListUpdate = new List<Account>();
        Set<Id> contactIds = new Set<Id>();
        for(Contact w:contactRecords){
            if(w.AccountId !=null){
                contactIds.add(w.AccountId);
            }
        }
        accList = [SELECT Id, Active_Contacts__c, (SELECT Id FROM Contacts WHERE Active__c=True) FROM Account WHERE Id IN:contactIds];
        if(accList.size()!=0){
            for (Account w:accList){
                w.Active_Contacts__c =w.contacts.size();
                accListUpdate.add(w);
            }
            database.update (accListUpdate, True);
        }
    }
}