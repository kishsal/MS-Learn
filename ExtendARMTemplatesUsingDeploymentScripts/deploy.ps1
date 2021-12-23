Connect-AzAccount

Get-AzSubscription

$subscription = Get-AzSubscription -SubscriptionId 520fb8d1-13c4-40bd-9af4-edb574e32a58
Set-AzContext $subscription

#Create RG
$ResourceGroupName="ksalgado-deployscript"
New-AzResourceGroup -Location eastus -Name $ResourceGroupName

#Deploy the template
$TemplateFile = "azuredeploy.json"
$Today=Get-Date -Format "MM-dd-yyyy"
$DeploymentName="deploymentscript-"+"$Today"
New-AzResourceGroupDeployment `
  -ResourceGroupName $ResourceGroupName `
  -Name $DeploymentName `
  -TemplateFile $TemplateFile