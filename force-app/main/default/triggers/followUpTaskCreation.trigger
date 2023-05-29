trigger followUpTaskCreation on Opportunity (after update, before insert, before update) {
    if (Trigger.isBefore && Trigger.isInsert){
        followUpTaskCreationHandler.stageLook(Trigger.new);   
    }
    if (Trigger.isBefore && Trigger.isUpdate){
        followUpTaskCreationHandler.accountLook(Trigger.new);   
    }
    if (Trigger.isAfter && Trigger.isUpdate){
        followUpTaskCreationHandler.newTask(Trigger.new, Trigger.oldmap);   
    }
}