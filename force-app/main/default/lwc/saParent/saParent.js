import { LightningElement, track, wire } from 'lwc';
import getSAInfoSearch from '@salesforce/apex/SAInfo.getSASearch';
import {publish, MessageContext} from 'lightning/messageService';
import SAMPLEMC from '@salesforce/messageChannel/MyUpdate__c';
export default class SaParent extends LightningElement {
filterWord ="";
sadetails;
@wire(MessageContext) messageContext;
@wire(getSAInfoSearch,{filter : '$filterWord' }) SAList(result){ 
this.sadetails=result;
if(result.data){
const message = {
sadets: result.data,
};
publish(this.messageContext, SAMPLEMC, message);
}
}
handleInput(event){
window.clearTimeout(this.delaytimeout); 
const filterWord=event.target.value; 
this.delaytimeout = setTimeout(()=>{this.filterWord=filterWord;}, 2000);
}
}