Connect-AzAccount

Get-AzSubscription

$subscription = Get-AzSubscription -SubscriptionId ed3ca12d-4d7b-452c-8952-839cabcb406a
Set-AzContext $subscription

Set-AzDefault -ResourceGroupName learn-8846d67c-fef0-4ad7-a5a4-41cb34088b5e

#Run the following to download ARM template
curl -O 'https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-linux/azuredeploy.json'

#set secure password
$secure = "insecurepassword123!" | ConvertTo-SecureString -AsPlainText -Force


#Deploy VM
New-AzResourceGroupDeployment `
  -TemplateFile "./azuredeploy.json" `
  -adminUsername "azureuser" `
  -vmName "vm1" `
  -adminPasswordOrKey $secure

#Run command to connect VM over SSH
Invoke-Expression (Get-AzResourceGroupDeployment -Name azuredeploy -ResourceGroupName learn-8846d67c-fef0-4ad7-a5a4-41cb34088b5e).outputs.sshCommand.value
#Enter password for SSH session
#Enter hostname to validate VM name

#Deploy Keyvault
$KVNAME="tailwind-secrets" + (Get-Random -Count 1 -Maximum 9999999)

$KVNAME
#Create keyvault using the name above


#Create a secure string
$secretSecureString = ConvertTo-SecureString 'insecurepassword123!' -AsPlainText -Force

#Create a secret in keyvault
$secret = Set-AzKeyVaultSecret -VaultName $KVNAME -Name vmPassword -SecretValue $secretSecureString

#get keyvault ID
Get-AzKeyVault -VaultName $KVNAME | Select-Object -ExpandProperty ResourceId

#Deploy VM after creating the parameter file
New-AzResourceGroupDeployment `
  -TemplateFile "./azuredeploy.json" `
  -TemplateParameterFile "./azuredeploy.parameters.json" `
  -dnsLabelPrefix ("vm2-" + (Get-Random -Count 1 -Maximum 9999999))

#Run command to connect VM over SSH
Invoke-Expression (Get-AzResourceGroupDeployment -Name azuredeploy -ResourceGroupName learn-8846d67c-fef0-4ad7-a5a4-41cb34088b5e).outputs.sshCommand.value
#Enter password for SSH session
#Enter hostname to validate VM name




######## Condition DEPLOYMENT ########

#create storage account name variable
$STORAGE_ACCT_NAME="tailwindsa"+ (Get-Random -COUNT 1 -Maximum 9999999 )

#Deploy for Dev environment
New-AzResourceGroupDeployment `
  -TemplateFile "./condition.json" `
  -storageAccountName $STORAGE_ACCT_NAME `
  -environment dev

#Verify deployment to Dev
Get-AzStorageAccount -Name $STORAGE_ACCT_NAME -ResourceGroupName learn-8846d67c-fef0-4ad7-a5a4-41cb34088b5e
#This will show an error since Env is Dev

#Deploy for Prod environment
New-AzResourceGroupDeployment `
  -TemplateFile "./condition.json" `
  -storageAccountName $STORAGE_ACCT_NAME `
  -environment production

#Verify deployment to Prod
Get-AzStorageAccount -Name $STORAGE_ACCT_NAME -ResourceGroupName learn-8846d67c-fef0-4ad7-a5a4-41cb34088b5e



######## Copy DEPLOYMENT ########

$STORAGE_ACCT_NAME="tailwindsa" + (Get-Random -Count 1)

#Deploy 2 storage account
New-AzResourceGroupDeployment `
-TemplateFile "./copy.json" `
-storageAccountName $STORAGE_ACCT_NAME `
-storageCount 2

#Verify the deployment
Get-AzResource -Name tailwindsa* -ResourceGroupName learn-8846d67c-fef0-4ad7-a5a4-41cb34088b5e | Select-Object -Property Name,ResourceId

