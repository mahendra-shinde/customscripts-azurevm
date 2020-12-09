Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart 
Enable-WindowsOptionalFeature -Online -FeatureName Containers -All -NoRestart

$script = "choco install docker-desktop git vscode -y; logoff" 
$trig = New-ScheduledTaskTrigger -AtLogOn -Once
$task = New-ScheduledTaskAction -Execute "powershell.exe" -Argument $script -AsJob
new-scheduledtask -Action $task -Trigger $trig 

#Trigger a restart to enable hyper-v and containers
Restart-Computer -Force
