import { LightningElement, wire, api, track } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
export default class SaMap extends LightningElement {
@api recordId;
@track mapMarkers;
@wire(getRecord, {
recordId: '$recordId',
fields: [ 'SA_Detail__c.Location__Latitude__s', 'SA_Detail__c.Location__Longitude__s', 'SA_Detail__c.Name__c' ]
})
fetchAcc({ data, error }) {
if (data) {
this.mapMarkers = [
{
location: {
Latitude: data.fields.Location__Latitude__s.value,
Longitude: data.fields.Location__Longitude__s.value,
},

title: data.fields.Name__c.value,
}
];

console.log('this.mapMarkers => ', JSON.stringify(this.mapMarkers));
} else if (error) {
console.error('ERROR => ', error);
}
}
}