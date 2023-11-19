import { api, LightningElement } from 'lwc';
import { deleteRecord } from 'lightning/uiRecordApi';

export default class FileUploadSingle extends LightningElement {
    @api acceptedFormats;
    @api myRecordId;
    @api fileUploader;
    @api label;
    @api multiple
    @api single;
    message="Please Upload File";
    handleUploadFinished(event)
    {
        this.message='File Uploaded';
        let evt= new CustomEvent("uploaded");
        this.dispatchEvent(evt);
        
    }
}