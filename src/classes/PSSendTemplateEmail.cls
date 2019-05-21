global class PSSendTemplateEmail {
    @InvocableMethod (label='Send Template Email')
    global static void sendSendTemplateEmail (List<TemplateEmailInput> input) {
        
        //if (input == null || input[0].whoId == null || input[0].templateName == null)
        //{
        //}
        
        // setup Contact/Lead/User list and template names
        List<Id> whoIds = new List<Id>();
        List<String> templateNames = new List<String>();
        for (TemplateEmailInput inp : input)
        {
           whoIds.add(inp.whoId);  
           templateNames.add(inp.templateName);
        }
        
        Map<Id, String> emailMap = new Map<Id, String>();
        
       String objectName = Id.valueOf(input[0].whoId).getSObjectType().getDescribe().getName();
       System.debug(objectName);
       if (objectName == 'Contact')
       {
         for (Contact c : [SELECT Id, Email FROM Contact WHERE Id IN :whoIds])
         {
             emailMap.put(c.Id, c.Email);
         }
       }
       else if (objectName == 'Lead')
       {
         for (Lead l : [SELECT Id, Email FROM Lead WHERE Id IN :whoIds])
         {
             emailMap.put(l.Id, l.Email);
         }           
       }
       else if (objectName == 'User')
       {
         for (User u : [SELECT Id, SenderEmail FROM User WHERE Id IN :whoIds])
         {
             emailMap.put(u.Id, u.SenderEmail);
         }             
       }
        
        
        // get templateMap - have to do odd logic as Flow Apex Action parser failing on standard SOQL and Map constructs
        String soqlStr = 'SELECT Id, DeveloperName FROM EmailTemplate WHERE DeveloperName IN ' + convertStringListToInClause(templateNames);
        List<EmailTemplate> templateList = Database.query(soqlStr);
        
        Map<String, EmailTemplate> templateMap = new Map<String, EmailTemplate>();
        for (EmailTemplate t : templateList)
        {
            String devName = (String)t.get('DeveloperName');
            templateMap.put(devName, t);
        }
        
        if (!input.IsEmpty()) {
            for (TemplateEmailInput inp : input) {			                       
				Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage ();
    			mail.TemplateId = templateMap.get(inp.templateName).Id;
                mail.ToAddresses = new List<String> {emailMap.get(inp.whoId)};
                mail.TargetObjectId = inp.whoId;
                if (inp.whatId != null) mail.WhatId = inp.whatId;
    			mail.SaveAsActivity = true;
    			mail.UseSignature = false;
				Messaging.sendEmail(new List<Messaging.SingleEmailMessage> { mail });
            } 
        }
    }
    
    private static String convertStringListToInClause(List<String> input)
    {
        String cl = '(';
        
        for (String str : input)
        {
            cl += '\'' + str + '\'';
        }
        cl += ')';
        
        return cl;
    }
    
    global class TemplateEmailInput 
    {
        @InvocableVariable(required=true)
        global String whoId;
        @InvocableVariable(required=true)
        global String templateName;
        @InvocableVariable
        global String whatId;
    }

}