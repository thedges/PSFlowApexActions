global class PSActionRecordIdInfo {
    @InvocableMethod (label='Get Record Info by Id')
    global static List<TemplateOutput> getRecordInfo(List<TemplateInput> input) {
        TemplateOutput o = new TemplateOutput();

        String recId = ID.valueOf(input[0].recordId);

        DescribeSObjectResult objDesc = ID.valueOf(recId).getSObjectType().getDescribe();
        String objName = objDesc.getName();
        o.objectName = objName;
        o.objectLabel = objDesc.getLabel();

        List<RecordTypeInfo> rtInfoList = objDesc.getRecordTypeInfos();

        if (rtInfoList != null && rtInfoList.size() > 1)
        {
            SObject sobj = Database.query('SELECT RecordTypeId FROM ' + objName + ' WHERE Id=\'' + recId + '\'');
            o.recordTypeId = (String)sobj.get('RecordTypeId');
            o.recordTypeLabel = objDesc.getRecordTypeInfosById().get(o.recordTypeId).getName();
            o.recordTypeName = objDesc.getRecordTypeInfosById().get(o.recordTypeId).getDeveloperName();
        }
        
        return new List<TemplateOutput> {o};
    }

    global static void test()
    {
        TemplateInput i = new TemplateInput();
        i.recordId = 'a0M4p000002LaiOEAS';

        List<TemplateOutput> out = getRecordInfo(new List<TemplateInput> {i});
        System.debug('out1='+ JSON.serializePretty(out));

        i.recordId = '50046000009ghZzAAI';
        out = getRecordInfo(new List<TemplateInput> {i});
        System.debug('out2='+ JSON.serializePretty(out));
        
    }

    global class TemplateInput
    {
        @InvocableVariable(required=true)
        global String recordId;
    }

    global class TemplateOutput
    {
        @InvocableVariable(required=true)
        global String objectLabel;
        @InvocableVariable(required=true)
        global String objectName;
        @InvocableVariable
        global String recordTypeId;
        @InvocableVariable
        global String recordTypeLabel;
        @InvocableVariable
        global String recordTypeName;
    }
}