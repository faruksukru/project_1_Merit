@RestResource(UrlMapping='/cases/*')
global with sharing class CaseRestServiceProvider {
/*    @HttpGet
    global static List<Case> getCaseService() {
        List<Case> caseList = [SELECT id, CaseNumber, Origin, Reason, OwnerId, Subject, Status, ParentId FROM Case LIMIT 15];   
return caseList;
    }*/
   @HttpGet
    global static Case getCaseService() {
        RestRequest request = RestContext.request;
        //String caseId = request.params.get('caseId');
        String caseId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Case requestedCase = [SELECT id, CaseNumber, Origin, Reason, Priority, Subject, Status FROM Case WHERE id=:caseId];   
return requestedCase;
    }
    @HttpPost
    global static Case postCaseService (Case createCase){
        Case newCase = new Case();
        newCase.Origin=createCase.Origin;
        newCase.Status=createCase.Status;
        newCase.Subject=createCase.Subject;
        newCase.Priority=createCase.Priority;
        Database.Insert (newCase, True);
        return newCase; 
    }
    @HttpPut
    global static Case putCaseService (Case upsertCase){
        //Case existingCase=[SELECT id, Origin, Subject, Status, Priority FROM Case WHERE id=:updateCase.id];
        Case thisCase= new Case();
        thisCase.Id=upsertCase.Id;
        thisCase.Origin=upsertCase.Origin;
        thisCase.Status=upsertCase.Status;
        thisCase.Priority=upsertCase.Priority;
        thisCase.Subject=upsertCase.Subject;
        Database.Upsert (thisCase, True);
        return thisCase;
    }
    @HttpDelete
    global static void deleteCaseService(){
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        //String caseId = request.params.get('caseId');
        Delete [SELECT id FROM Case WHERE id=:caseId];
    }
}