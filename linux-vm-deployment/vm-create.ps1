Param($GroupName, $VMName, $Credential, $Location, $DNS, $ScriptPath, $ScriptCommand, $VMSize="Standard_D4s_v3", $VNet="LabVNet")

$Ubuntu1804 = Get-AzVMImage -Location SoutheastAsia -Offer UbuntuServer -PublisherName Canonical -Skus 18.04-LTS -Version 18.04.202012111

$LocationName = $Location
$ResourceGroupName = $GroupName
$ComputerName = $VMName
$VMName = $VMName
$VMSize = $VMSize

$NetworkName = $VNet
$NICName = "$VMName-NIC"
$SubnetName = "Subnet1"
$SubnetAddressPrefix = "10.0.0.0/24"
$VnetAddressPrefix = "10.0.0.0/16"

$SingleSubnet = New-AzVirtualNetworkSubnetConfig -Name $SubnetName -AddressPrefix $SubnetAddressPrefix
$Vnet = New-AzVirtualNetwork -Name $NetworkName -ResourceGroupName $ResourceGroupName -Location $LocationName -AddressPrefix $VnetAddressPrefix -Subnet $SingleSubnet
$NIC = New-AzNetworkInterface -Name $NICName -ResourceGroupName $ResourceGroupName -Location $LocationName -SubnetId $Vnet.Subnets[0].Id 

$VirtualMachine = New-AzVMConfig -VMName $VMName -VMSize $VMSize
$VirtualMachine = Set-AzVMOperatingSystem -VM $VirtualMachine -Linux -ComputerName $ComputerName -Credential $Credential -ProvisionVMAgent -EnableAutoUpdate
$VirtualMachine = Add-AzVMNetworkInterface -VM $VirtualMachine -Id $NIC.Id 
$VirtualMachine = Set-AzVMSourceImage -VM $VirtualMachine -PublisherName 'Canonical' -Offer 'UbuntuServer' -Skus '18.04-LTS' -Version '18.04.202012111'
$pip = "$VMName-pip"

New-AzVM -ResourceGroupName $ResourceGroupName -Location $LocationName -VM $VirtualMachine -Verbose -AllocationMethod Dynamic -PublicIpAddressName $pip -DomainNameLabel $DNS -OpenPorts 4000, 22 

Set-AzVMCustomScriptExtension -ResourceGroupName $GroupName `
    -VMName $VMName `
    -Location $Location `
    -FileUri  $ScriptPath `
    -Run $ScriptCommand `
    -Name InstallScript

