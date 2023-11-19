import { api, LightningElement, track, wire } from 'lwc';
import getAllFiles from '@salesforce/apex/FileUploadAll.getAllFiles';
export default class FileContainer extends LightningElement {
    @api recordId;
    @api objectApiName;
    @api records;
    callmethod()
    {
        getAllFiles({"recordid":this.recordId,"objectName":this.objectApiName,}).then(data=>{
        console.log("recieved "+JSON.stringify(data));
        this.records=data;

        }).catch(error=>{
            console.log("error accounted "+error)
        })
    }
    connectedCallback()
    {
        this.callmethod();
    }
    
}