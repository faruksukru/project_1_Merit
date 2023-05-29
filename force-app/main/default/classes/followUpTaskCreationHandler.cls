public class followUpTaskCreationHandler {
    public static void stageLook(List<Opportunity> oppList){
        for (Opportunity w:oppList) {
            if(w.StageName ==('Closed Won') || w.StageName ==('Closed Lost')) {
                w.addError('The newly created Opportunity record cannot stage Closed Won or Closed Lost'); 
            }    
        }
    }
    public static void accountLook(List<Opportunity> oppList){ 
        for (Opportunity w:oppList) {
            if(w.StageName =='Closed Won' && String.isBlank(w.AccountId)) {
                w.addError('Opportunity Account information must be filled'); 
            }    
        }
    }
    public static void newTask(List<Opportunity> oppList, Map<Id, Opportunity> oppOldList){
        List<Task> newTaskList = new List<Task>();
        for(Opportunity w:oppList){
            if(w.StageName =='Closed Won' && w.StageName != oppOldList.get(w.id).StageName){
                Task newTsk = new Task(Subject= 'Follow up Task', ActivityDate = w.CloseDate.addMonths(1), WhatId = w.Id, OwnerId = w.OwnerId);
                newTaskList.add(newTsk);
            }
        }
        database.insert (newTaskList, True);
    }
}