#output must be 7.0.3 or above
$PSVersionTable.PSVersion

Connect-AzAccount

Get-AzSubscription

$subscription = Get-AzSubscription -SubscriptionId fcfd8558-600b-4e8c-8fc6-61a12221db20
Set-AzContext $subscription

Get-AzResourceGroup

Set-AzDefault -ResourceGroupName learn-8e69e00c-c40f-4b42-baaf-bc6acbc12655

#Run New-AzResourceGroupDeployment
New-AzResourceGroupDeployment `
-TemplateUri "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/what-if/what-if-before.json"

#Run New-AzResourceGroupDeployment with -whatIf
New-AzResourceGroupDeployment `
  -Whatif `
  -TemplateUri "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/what-if/what-if-after.json"

#Run New-AzResourceGroupDeployment with mode complete
New-AzResourceGroupDeployment `
-Mode Complete `
-Confirm `
-TemplateUri "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/empty-template/azuredeploy.json"