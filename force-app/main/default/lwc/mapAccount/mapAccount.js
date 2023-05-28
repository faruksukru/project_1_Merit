import { LightningElement, wire, api, track } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import STREEET_FIELD from '@salesforce/schema/Account.BillingStreet';
import CITY_FIELD from '@salesforce/schema/Account.BillingCity';
import POSTCODE_FIELD from '@salesforce/schema/Account.BillingState';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import DESCRIPTION_FIELD from '@salesforce/schema/Account.Description';

export default class MapAccount extends LightningElement {
    @api recordId;
    @track mapMarkers;
    @wire(getRecord, {
        recordId: '$recordId',
        fields: [ STREEET_FIELD, CITY_FIELD, POSTCODE_FIELD, DESCRIPTION_FIELD, NAME_FIELD ]
    })
    fetchAcc({ data, error }) {
        if (data) {
            this.mapMarkers = [
                {
                    location: {
                        Street: data.fields.BillingStreet.value,
                        City: data.fields.BillingCity.value,
                        State: data.fields.BillingState.value
                    },

                    title: data.fields.Name.value,
                    description: data.fields.Description.value
                }
            ];
            
            console.log('this.mapMarkers => ', JSON.stringify(this.mapMarkers));
        } else if (error) {
            console.error('ERROR => ', error);
        }
    }
}