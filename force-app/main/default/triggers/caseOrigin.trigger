trigger caseOrigin on Case (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        caseOriginHandler.caseLook(Trigger.new);
    }
}