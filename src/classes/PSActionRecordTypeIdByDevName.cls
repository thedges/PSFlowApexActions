global class PSActionRecordTypeIdByDevName {
    @InvocableMethod (label='Get Record Type Id By Developer Name')
    global static List<String> getId(List<TemplateInput> input) {
     
        List<RecordType> rtList = [SELECT Id FROM RecordType WHERE DeveloperName = :input[0].developerName AND SobjectType = :input[0].objectName];
        if (rtList != null && rtList.size() > 0)
        {
            return new List<String> {rtList[0].Id};
        }
       
        return null;
    }
    
    global class TemplateInput
    {
        @InvocableVariable(required=true)
        global String developerName;
        
        @InvocableVariable(required=true)
        global String objectName;
    }
}