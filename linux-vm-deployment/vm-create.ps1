Param($GroupName, $VMName, $Credential, $Location, $DNS, $ScriptPath, $ScriptCommand, $VMSize="Standard_D4s_v3", $VNet="LabVNet")

$pip = "$VMName-pip"
New-AzVm `
    -ResourceGroupName $GroupName `
    -Name $VMName `
    -Credential $credential `
    -Location $Location `
    -Image "Canonical:UbuntuServer:18.04-LTS:18.04.202012111" `
    -AllocationMethod Dynamic `
    -VirtualNetworkName $VNet `
    -SubnetName "Subnet1" `
    -SecurityGroupName "LabNSG" `
    -PublicIpAddressName $pip `
    -DomainNameLabel $DNS `
    -OpenPorts @(4000,22) `
    -Size $VMSize     
    write-host "VM Created $i"
 
$settings = @{"fileUris"= @("$ScriptPath") ; "commandToExecute"="$ScriptCommand"}

Set-AzVMExtension -ResourceGroupName $GroupName `
    -VMName $VMName `
    -Location $Location `
    -ExtensionType CustomScript `
    -Name script1 `
    -Publisher 'Microsoft.Azure.Extensions' `
    -settings $settings `
    -typeHandlerVersion 2.0

