@istest
public class FileUploadAllTest {
    @testsetup
    public static void createdata()
    {
        Account test=new account();
        test.Name='Vikas';
        insert test;
        Document__c doc= new Document__c();
        doc.Active__c=true;
        doc.Extensions__c='.pdf';
        doc.Multiple__c=true;
        doc.Object__c='Account';
        doc.Name='Adhaar';
        insert doc;
    }
    @istest
    private static void testgetfiles()
    {
        Account acc= [select id from account];
        FileUploadAll.getAllFiles(acc.Id,'Account');
        
    }
    @istest
    private static void testgetfiles2()
    {
        Document__c doc= [select id from Document__c];
        IndividualDoc__c ind=new IndividualDoc__c();
        
        Account acc= [select id from account];
        ContentVersion contentVersion = new ContentVersion(
            Title = 'Penguins',
            PathOnClient = 'Penguins.jpg',
            VersionData = Blob.valueOf('Test Content'),
            IsMajorVersion = true
        );
        insert contentVersion;    
        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        ind.ParentId__c=acc.id;
        ind.Document__c=doc.id;
        insert ind;
        //create ContentDocumentLink  record 
        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = ind.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        
        FileUploadAll.getAllFiles(acc.Id,'Account');
        
    }
    
    
}