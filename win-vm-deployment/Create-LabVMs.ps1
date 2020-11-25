## Please Update all the below parameters 
$GroupName="demo1"
$Location="southeastasia"
$Count = 2
## privide path and command to launch the powershell script (Must be accessible)
$ScriptPath="https://raw.githubusercontent.com/mahendra-shinde/customscripts-azurevm/main/windows/az-500.ps1"
## Command is name of script file without the path
$ScriptCommand= "az-500.ps1"

New-AzResourceGroup -Name $GroupName -Location $Location
## Set the Password for all your VMs
$password = ConvertTo-SecureString 'Password@1234' -AsPlainText -Force


for ($i = 1 ; $i -le $Count ; $i++)
{
$credential = New-Object System.Management.Automation.PSCredential("Student$i", $password)
## Launch ALL VMs in Parallel (By launching vm creation script as a Background Job)
Start-job -name "PrepareVM$i" -filepath ./vm-create.ps1 -ArgumentList  $GroupName, "LabVM$i", $credential, $Location , "lab000vm$i",  $ScriptPath , $ScriptCommand  
}
