At present, we lack a file upload solution in Salesforce that enforces the submission of required documents for specific objects. The proposed solution aims to address this by implementing a scalable and generic system to track mandatory documents for each object in Salesforce. The code will be continually optimized in subsequent releases.

We have a custom 'Document' object designed to track the specific documents required for each instance of an object. 

To facilitate this, we need to insert a record in the 'Document' object for each document associated with a particular object.

example


![Screenshot 2023-11-19 at 9 43 20 AM](https://github.com/vikaskumar18/FileUpload/assets/64322972/defb7112-6ee5-47fc-9a27-aa26373fe8fa)






It has certain fields that will help you to take req document as input eg. Document name,Type,Object

post creating record. you need to drag and drop fileContainer lwc component on record detail page from app builder.





It will look line below component on the detail page with same title as we uploaded.

![Screenshot 2023-11-19 at 9 47 26 AM](https://github.com/vikaskumar18/FileUpload/assets/64322972/a4b12bcd-f635-4c30-8405-e435334638de)



after uploading file, it will display list of documents uploaded to to it. It also gives option to preview, delete and download file.


![Screenshot 2023-11-19 at 9 49 26 AM](https://github.com/vikaskumar18/FileUpload/assets/64322972/54ace84a-ff25-4368-8307-8cc28f74e2d5)


Below is data model :

![Screenshot 2023-11-19 at 10 49 19 AM](https://github.com/vikaskumar18/FileUpload/assets/64322972/0e735f27-ce18-4218-9b02-3f9002a51037)
