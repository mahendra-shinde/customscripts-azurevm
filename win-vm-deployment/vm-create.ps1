Param($GroupName, $VMName, $Credential, $Location, $DNS, $ScriptPath, $ScriptCommand, $VMSize="Standard_D4s_v3", $VNet="LabVNet")

$pip = "$VMName-pip"
New-AzVm `
    -ResourceGroupName $GroupName `
    -Name $VMName `
    -Credential $credential `
    -Location $Location `
    -VirtualNetworkName $VNet `
    -SubnetName "Subnet1" `
    -SecurityGroupName "LabNSG" `
    -AllocationMethod Dynamic `
    -PublicIpAddressName $pip `
    -DomainNameLabel $DNS `
    -OpenPorts 3389 `
    -Size $VMSize 
    
    write-host "VM Created $i"
 
Set-AzVMCustomScriptExtension -ResourceGroupName $GroupName `
    -VMName $VMName `
    -Location $Location `
    -FileUri  $ScriptPath `
    -Run $ScriptCommand `
    -Name InstallScript

