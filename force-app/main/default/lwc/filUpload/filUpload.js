import { api, LightningElement } from 'lwc';

import { NavigationMixin } from 'lightning/navigation';

export default class FilUpload extends LightningElement {
    @api documents;
    handletogglesection(event)
    {

    }
    fireparent()
{
    let evt= new CustomEvent("uploadedchild");
    this.dispatchEvent(evt);
}
    
}