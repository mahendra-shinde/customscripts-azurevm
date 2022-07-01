param (
    $UserName  
)

## You need to restart vm after script finishes!
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart 
Enable-WindowsOptionalFeature -Online -FeatureName Containers -All -NoRestart

## Install Chocolatey using Powershell script
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

## Install VSCode & GIT for OSS Development
choco install vscode git awscli  firefox docker-desktop kubernetes-helm kubernetes-cli terraform -y

New-LocalGroup -Name docker-users -Description "Users of Docker Desktop"
Add-LocalGroupMember -Group 'docker-users' -Member $UserName

$trig = New-ScheduledTaskTrigger -AtLogOn 
$task = New-ScheduledTaskAction -Execute "C:\Program Files\Docker\Docker\Docker Desktop.exe" 
Register-ScheduledTask -TaskName start-docker -Force -Action $task -Trigger $trig -User $UserName


