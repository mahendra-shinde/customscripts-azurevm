# LAB-VM Creation with Custom Script extension

## Synopsis

Create Set of Windows Server 2016 (Desktop) VMs with specific Powershell script launched with `custom script extension` to prepare your OWN lab environment on azure-cloud.

## Pre-Requsites

1.  Azure Subscription
2.  Azure Powershell Modules 'Az' installed and signed-in.
3.  A Custom powershell script accessible with URL. (eg. github)

## Contents

Script file | Description
------------|------------
vm-create.ps1 | Actual script to create single vm with custom script extension. To be used from inside the `Create-LabVMs.ps` script file.
Create-LabVMs.ps1 | Script to create/update a resource group and then create number of VMs using the other script `vm-create.ps`. Both script files must be at same location.


## How-To

1.  Copy both PS1 files in folder of your choice, eg. c:\temp
2.  Open `Create-LabVMs.ps1` in any text editor (notepad) or in `Powershell ISE` to edit variables
3.  Set the values for `$GroupName, $Location, $Count, $ScriptPath, $ScriptCommand` variables.
4.  Run the main script `Create-LabVMs.ps1` to start the execution. 

