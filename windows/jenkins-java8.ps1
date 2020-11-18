## Install Chocolatey using Powershell script
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

## Install packages for Java Development
choco install jdk8 maven vscode git -y
## Install springtoolsuite (an IDE based on eclipse)
choco install springtoolsuite -y
## Install Jenkins-ci
## Proceed with post-installation
choco install jenkins -y
