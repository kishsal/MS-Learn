Connect-AzAccount

Get-AzSubscription

#Set Subscription context
$context = Get-AzSubscription -SubscriptionId {Your subscription ID}
Set-AzContext $context

Set-AzDefault -ResourceGroupName learn-07818491-28e5-4b7c-9c26-841e7960af9b

#Deploy blank template
$templateFile = "azuredeploy.json"
$today=Get-Date -Format "MM-dd-yyyy"
$deploymentName="blanktemplate-"+"$today"
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -TemplateFile $templateFile

#Deploy storage template
$templateFile = "azuredeploy.json"
$today=Get-Date -Format "MM-dd-yyyy"
$deploymentName="addstorage-"+"$today"
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -TemplateFile $templateFile

#Deploy storage template with parameter
$templateFile = "azuredeploy.json"
$today=Get-Date -Format "MM-dd-yyyy"
$deploymentName="addnameparameter-"+"$today"
New-AzResourceGroupDeployment `
-Name $deploymentName `
-TemplateFile $templateFile `
-storageName "storageaccount20201217"

#Deploy storage with add sku
$today=Get-Date -Format "MM-dd-yyyy"
$deploymentName="addSkuParameter-"+"$today"
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -TemplateFile $templateFile `
  -storageName "storageaccount20201217" `
  -storageSKU Standard_GRS

#Deploy storage with output
$today=Get-Date -Format "MM-dd-yyyy"
$deploymentName="addOutputs-"+"$today"
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -TemplateFile $templateFile `
  -storageName "storageaccount20201217" `
  -storageSKU Standard_LRS