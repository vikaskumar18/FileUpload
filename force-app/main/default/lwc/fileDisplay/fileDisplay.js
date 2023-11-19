import { api, LightningElement } from 'lwc';

import { NavigationMixin } from 'lightning/navigation';
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class FileDisplay extends NavigationMixin(LightningElement) {
@api objects;
preview(event)
{

let targetId = event.target.dataset.record;
//let target = this.template.querySelector(`[data-id="${targetId}"]`);
//target.scrollIntoView();
//alert('preview '+targetId);
    let base= this.getBaseUrl();
    this[NavigationMixin.Navigate]({
        type: 'standard__namedPage',
        attributes: {
            pageName: 'filePreview',
        
        },
        state:{
            selectedRecordId:targetId
        }
    });
}
deleterec(event)
{
    let targetId = event.target.dataset.record;
    //alert('delete '+targetId);
    deleteRecord(targetId)
    .then(() => {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Record deleted',
                variant: 'success'
            })
        );

        this.dispatchEvent(new CustomEvent("deleted"));

    }).catch(error => {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error deleting record',
                message: error.body.message,
                variant: 'error'
            })
        );
    });
}

download(event)
{
    let targetId = event.target.dataset.record;
    let base= this.getBaseUrl();
    let version=  event.target.dataset.version;
    //alert('download' +targetId)
    base= base+'sfc/servlet.shepherd/document/download/'+targetId;
    //let totalurl=
    console.log(base);
    this[NavigationMixin.Navigate]({
        type: 'standard__webPage',
        attributes: {
            url: base,
        }
        
    },
    false);
}

connectedCallback()
{
   
}
getBaseUrl()
{
    let baseurl='https://'+location.host+'/';
    console.log(baseurl);
    return baseurl
}
}