trigger existOpportunityonAccount on Account (after insert, after update) {
    if (Trigger.isAfter && Trigger.isInsert){
        existOpportunityHandler.newOpp(Trigger.new);   
    }
    if (Trigger.isAfter && Trigger.isUpdate){
        existOpportunityHandler.existOpp(Trigger.new); 
    }
}