# PSFlowApexActions
THIS SOFTWARE IS COVERED BY [THIS DISCLAIMER](https://raw.githubusercontent.com/thedges/Disclaimer/master/disclaimer.txt).

This package provides a variety of Flow Apex Actions to be used in Salesforce Flow. This package will continue to grow with new "actions" as I encounter them for demos.

## Record Info by RecordId

This action was built to provide easy way to retrieve record info such as object name, record type name, etc... for a given record id. The primary purpose was to be able to retrieve the RecordType Name/Label of a given record and then have conditional flow logic use the Name/Label versus a hard-coded id. This will allow your flows to be portable. I also added returning the record ids object label and API name. Granted most of the time you are building a flow for a specific object, but with this action you can determine the object at runtime and traverse a different flow path if necessary.

Here are the input parameters for this action:

| Input Param | Required/Optional | Description |
| ----------- | ----------------- | ----------- |
| recordId | required | The record id to retrieve info for. Supports any SObject type. |


Here are the output parameters for this action:

| Output Param | Required/Optional | Description |
| ----------- | ----------------- | ----------- |
| objectLabel | required | The label of the object (ex: Case or Payment)|
| objectName | required | The API name of the object (ex: Case or Payment__c)|
| recordTypeId | optional | If record types are defined for this object, the recordtype id of the record. |
| recordTypeLabel | optional |  If record types are defined for this object, the recordtype label of the record. (ex: Animal Control)|
| recordTypeName | optional |  If record types are defined for this object, the recordtype name of the record. (ex: Animal_Control)|

Here is snapshot of how the Apex Action will show in Flow Builder:

![](https://raw.githubusercontent.com/thedges/PSFlowApexActions/master/PSActionRecordIdInfo.png)

## Send Email with Template

This action was built because the standard Email Action that comes with Flow does not associate the email with the user or target records Activity feed. This action will associate with the Activity feed so you have a log of it.

Here are the input parameters for this action:

| Input Param | Required/Optional | Description |
| ----------- | ----------------- | ----------- |
| whoId | required | The contact, lead or user id |
| templateName | required | The API/developer name of the email template to use |
| whatId | optional | The id of the target object to use as base of the email template (ex: a case id) |

Here is snapshot of how the Apex Action will show in Flow Builder:

![](https://raw.githubusercontent.com/thedges/PSFlowApexActions/master/SendTemplateEmail.png)




<a href="https://githubsfdeploy.herokuapp.com">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>
