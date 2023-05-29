trigger activeContacts on Contact (after insert, after update, after delete, after undelete) {
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            activeContactsHandler.countActive(Trigger.new);  
        } 
        if(Trigger.isUpdate) {
            activeContactsHandler.countActive(Trigger.new);   
        } 
        if(Trigger.isUndelete) {
            activeContactsHandler.countActive(Trigger.new);   
        }
        if(Trigger.isDelete) {
            activeContactsHandler.countActive(Trigger.old);    
        }
    }
}