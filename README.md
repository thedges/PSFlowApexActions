# PSFlowApexActions
THIS SOFTWARE IS COVERED BY [THIS DISCLAIMER](https://raw.githubusercontent.com/thedges/Disclaimer/master/disclaimer.txt).

This package provides a variety of Flow Apex Actions to be used in Salesforce Flow. This package will continue to grow with new "actions" as I encounter them for demos.

## Send Email with Template

This action was built because the standard Email Action that comes with Flow does not associate the email with the user or target records Activity feed. This action will associate with the Activity feed so you have a log of it.

Here are the input parameters for this action:

| Input Param | Required/Optional | Description |
| whoId | required | The contact, lead or user id |
| templateName | required | The API/developer name of the email template to use |
| whatId | optional | The id of the target object to use as base of the email template (ex: a case id) |

Here is snapshot of how the Apex Action will show in Flow Builder:

![](https://raw.githubusercontent.com/thedges/PSFlowApexActions/master/SendTemplateEmail.png)

<a href="https://githubsfdeploy.herokuapp.com">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>
