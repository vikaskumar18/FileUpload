public with sharing class FileUploadAll {
    public FileUploadAll() {

    }
    class data{
        @auraenabled public  IndividualDoc__c docs;
@auraenabled public Integer size=0;
@auraenabled public list<ContentDocumentLink> attachments;
@auraenabled public list<ContentVersion> contentversions;


    }
    @AuraEnabled
    public static  list<data>  getAllFiles(string recordid,string objectName){
        list<data> datas= new list<data>();
        system.debug(recordid+' '+objectName);
    list<Document__c> docs=[SELECT id,name,Single__c,Object__c,Multiple__c,Extensions__c,Active__c FROM Document__c where Object__c=:objectName and Active__c=true];     
    list<IndividualDoc__c> attachs=new list<IndividualDoc__c>();
    Map<id,list<ContentDocumentLink>> parentvslink= new Map<id,list<ContentDocumentLink>>();
    Map<id,list<ContentVersion>> parentvsversion= new Map<id,list<ContentVersion>>();
    Map<id,list<ContentVersion>> recvsversion= new Map<id,list<ContentVersion>>();
                
    list<IndividualDoc__c> finalList=new list<IndividualDoc__c>();
            if(docs.size()>0)
            {
                list<IndividualDoc__c> attached=[SELECT id,Name,ParentId__c,Document__c	,Document__r.name,Document__r.Single__c,Document__r.Object__c,Document__r.Multiple__c,Document__r.Extensions__c,Document__r.Active__c from IndividualDoc__c where Document__c in :docs and ParentId__c=:recordid];
                if(attached.size()<1)
                {
                    for(Document__c doc:docs)
                    {
                        IndividualDoc__c attachm= new IndividualDoc__c();
                        attachm.Document__c= doc.id;
                        attachm.ParentId__c=recordid;
                        attachs.add(attachm);

                    }
                    if(attachs.size()>0)
                    {
                        insert attachs;
                        finalList=[SELECT id,Name,ParentId__c,Document__c	,Document__r.name,Document__r.Single__c,Document__r.Object__c,Document__r.Multiple__c,Document__r.Extensions__c,Document__r.Active__c from IndividualDoc__c where id in :attachs];
                
                        
                    }
                }
                else {
                    finalList=attached;
                    list<id> linked= new list<id>();
                    for(IndividualDoc__c att:attached)
                    {
                        linked.add(att.id);
                    }
                    
                    list<ContentDocumentLink> links= [Select id,linkedentityid,ContentDocument.contentsize,ContentDocument.FileType,ContentDocumentId,ContentDocument.title, ContentDocument.LatestPublishedVersionId from ContentDocumentLink where linkedentityid  in:linked];
                set<id> docid= new set<id>();
                
                  
                    for(ContentDocumentLink link:links)
                    {
                        docid.add(link.contentdocumentid);
                        if(parentvslink.containsKey(link.linkedentityid))
                        {
                            list<ContentDocumentLink> ln=parentvslink.get(link.linkedentityid);
                            
                             ln.add(link);
                                parentvslink.put(link.linkedentityid,ln);

                            

                        }
                        else {
                            list<ContentDocumentLink> ln= new list<ContentDocumentLink>();
                            ln.add(link);
                            parentvslink.put(link.linkedentityid,ln);

                        }
                    }
                   /* List<ContentVersion> conversions=[SELECT Id, ContentDocumentId, ContentUrl, VersionNumber, ContentBodyId, Title, Description, PathOnClient, ContentModifiedDate, FileType, ContentSize FROM ContentVersion where ContentDocumentId in :docid];

                    
                    for(ContentVersion conversion:conversions)
                    {
                       
                        if(parentvsversion.containsKey(conversion.ContentDocumentId))
                        {
                            list<ContentVersion> ln=parentvsversion.get(conversion.ContentDocumentId);
                            
                             ln.add(conversion);
                             parentvsversion.put(conversion.ContentDocumentId,ln);

                            

                        }
                        else {
                            list<ContentVersion> ln= new list<ContentVersion>();
                            ln.add(conversion);
                            parentvsversion.put(conversion.ContentDocumentId,ln);

                        }
                    }
                    for(ContentDocumentLink link:links)
                    {
                        recvsversion.put(link.linkedentityid,parentvsversion.get(link.ContentDocumentId));

                    }   */
             
                }
               
                for(IndividualDoc__c indi:finalList)
                {
                    data d= new data();
                    d.docs= indi;
                   // d.size=parentvslink.get(indi.id).size();
                    d.attachments=parentvslink.get(indi.id);
                   // d.contentversions=recvsversion.get(indi.id);
                    datas.add(d);
                }
              
                
            }
            return datas;
                
       
    }
}