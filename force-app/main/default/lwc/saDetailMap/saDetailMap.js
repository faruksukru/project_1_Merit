import { LightningElement, wire } from 'lwc';
import {subscribe, unsubscribe, MessageContext} from 'lightning/messageService';
import SAMPLEMC from '@salesforce/messageChannel/MyUpdate__c';
export default class SaDetailMap extends LightningElement {
mapMarkers = [];
subscription = null;
@wire(MessageContext) messageContext;

connectedCallback(){
this.subscription = subscribe(this.messageContext, SAMPLEMC, (message) => {
this.handleList(message);
});
}
disconnectedCallBack(){
unsubscribe(this.subscription);
this.subscription = null;
}

handleList(message){
this.mapMarkers = message.sadets.map((sadet) => {
const  Latitude = sadet.Location__Latitude__s;
const Longitude = sadet.Location__Longitude__s; 
return{          
location: {Latitude, Longitude},
title: sadet.Name__c,
description: `Coords: ${Latitude}, ${Longitude}`,
icon:"standart:people"
};
});
} 
}