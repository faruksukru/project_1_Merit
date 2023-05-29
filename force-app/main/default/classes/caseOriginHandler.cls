public class caseOriginHandler {
    public static void caseLook(List<Case> caseList){
        set<Id> accountIds = new set<Id>();
        List<Case> accList = new List<Case>();
        for(Case w:caseList){
            if(!string.isBlank(w.AccountId)){
                accountIds.add(w.AccountId);
            }
        }
        accList = [SELECT Id, AccountId, ParentId, Origin FROM Case WHERE AccountId IN:accountIds];
        for(Case w:caseList){
            for (Case rec:accList){
                if(w.AccountId==rec.AccountId && w.Origin==rec.Origin){
                    w.ParentId=rec.Id;
                }
            }
        }
    }
}