Connect-AzAccount

Get-AzSubscription

#Set Subscription context
$context = Get-AzSubscription -SubscriptionId 91ea05ff-38f3-443d-8947-2c02a616f4d6
Set-AzContext $context

Set-AzDefault -ResourceGroupName learn-a64968f2-b584-48e6-8f9e-7abd94cc4685

#Deploy storage template with prefix
$templateFile = "azuredeploy.json"
$today=Get-Date -Format "MM-dd-yyyy"
$deploymentName="addfunction-"+"$today"
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -TemplateFile $templateFile `
  -storagePrefix "storage"

#Deploy storage template with variable
$templateFile = "azuredeploy.json"
$today=Get-Date -Format "MM-dd-yyyy"
$deploymentName="addVariable-"+"$today"
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -TemplateFile $templateFile `
  -storagePrefix "storage"

#Deploy storage with tags parameter
$templateFile = "azuredeploy.json"
$today=Get-Date -Format "MM-dd-yyyy"
$deploymentName="updateTags-"+"$today"
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -TemplateFile $templateFile `
  -storagePrefix "storage" `
  -storageSKU Standard_LRS

#Deploy storage with parameter file
$templateFile = "azuredeploy.json"
$parameterFile="azuredeploy.parameters.dev.json"
$today=Get-Date -Format "MM-dd-yyyy"
$deploymentName="addParameterFile-"+"$today"
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -TemplateFile $templateFile `
  -TemplateParameterFile $parameterFile