import { LightningElement, api } from 'lwc';
import {NavigationMixin} from 'lightning/navigation';
export default class SAChildTile extends NavigationMixin(LightningElement)  {
@api recordId;
@api sadetail;
navigateToViewSAPage(event) {
var recId = event.target.name;
this[NavigationMixin.Navigate]({
type: "standard__recordPage",
attributes: {
objectApiName: "SA_Detail__c",
actionName: "view",
recordId: recId
}
});
} 
}