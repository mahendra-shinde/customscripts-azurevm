## Please Update all the below parameters 
$GroupName="group001"
$Location="southeastasia"
$Count = 1
## privide path and command to launch the powershell script (Must be accessible)
$ScriptPath="https://raw.githubusercontent.com/mahendra-shinde/customscripts-azurevm/main/linux/java-dev.sh"
## Command is name of script file without the path

New-AzResourceGroup -Name $GroupName -Location $Location
## Set the Password for all your VMs
$password = ConvertTo-SecureString 'Password@1234' -AsPlainText -Force


for ($i = 1 ; $i -le $Count ; $i++)
{
$Username = "Student$i"
$credential = New-Object System.Management.Automation.PSCredential($Username, $password)
$ScriptCommand= "bash java-dev.sh $Username"
# Launch task sequentially
./vm-create.ps1 $GroupName  "LabVM$i"  $Credential $Location $DNS  $ScriptPath $ScriptCommand
## Launch ALL VMs in Parallel (By launching vm creation script as a Background Job)
#Start-job -name "PrepareVM$i" -filepath ./vm-create.ps1 -ArgumentList  $GroupName, "LabVM$i", $credential, $Location , "lab000vm$i",  $ScriptPath , $ScriptCommand  
}
