import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import SUPERVISOR_FIELD from '@salesforce/schema/sa_detail__c.Supervisor__c';
export default class SaSupervisor extends LightningElement {
@api recordId;
@wire (getRecord, {recordId: "$recordId", fields: [ SUPERVISOR_FIELD]})  sadetail;
get supervisorId(){
return getFieldValue(this.sadetail.data, SUPERVISOR_FIELD);
}
}