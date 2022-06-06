#Apply Global Settings
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'

#Apply Global Variables
$CommonDesktop = (New-Object -ComObject Shell.Application).NameSpace('shell:Common Desktop').Self.Path

#Patch My PC Custom Variables 
$ApplicationUri = "<your-own-uri-goes-here>/PatchMyPC.exe"
$SettingsUri = "<your-own-uri-goes-here>/PatchMyPC.ini" 

#Patch My PC Fixed Variables
$InstallationLocation = $ENV:ProgramFiles + "\Patch My PC"
$InstallationLocationApps = $InstallationLocation + "\.apps"
$InstallationLocationCache = $InstallationLocation + ".\cache"

#Download and Install Patch My PC
if (!(Test-Path $InstallationLocation)) {New-Item -Path "$ENV:ProgramFiles" -Name "Patch My PC" -ItemType "Directory"}
if (!(Test-Path $InstallationLocationApps)) {New-Item -Path "$InstallationLocation" -Name ".apps" -ItemType "Directory" -Force}
if (!(Test-Path $InstallationLocationCache)) {New-Item -Path "$InstallationLocation" -Name ".cache" -ItemType "Directory" -Force}
if (!(Test-Path $InstallationLocation\PatchMyPC.exe)) {
    
    #Download Patch My PC Application and Settings
    Invoke-WebRequest -Uri $ApplicationUri -OutFile "$InstallationLocation\PatchMyPC.exe"
    Invoke-WebRequest -Uri $SettingsUri -Outfile "$InstallationLocation\PatchMyPC.ini"
    
    #Apply Patch My PC Registry Settings
    New-Item -Path "HKLM:\SOFTWARE\Patch My PC" -Name "Options" -Force
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Patch My PC\Options" -Name "DownloadPath" -Value "$InstallationLocationCache"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Patch My PC\Options" -Name "PortableAppPath" -Value "$InstallationLocationApps"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Patch My PC\Options" -Name "RemoveIcons" -Value "1"

    #Create Patch My PC Shortcut on Public Desktop
    $WScriptShell = New-Object -ComObject WScript.Shell
    $ShortcutTarget = "$InstallationLocation\PatchMyPC.exe"
    $ShortcutTargetPath = "$CommonDesktop\PatchMyPC Updater.lnk"
    $Shortcut = $WScriptShell.CreateShortcut($ShortcutTargetPath)
    $Shortcut.TargetPath = $ShortcutTarget
    $Shortcut.Save()

    #Start Patch My PC To Apply Settings and Install Applications Silently
    Start-Process "$InstallationLocation\PatchMyPC.exe" -ArgumentList "/Silent"
    }

#Create Patch My PC Scheduled Task
if (!(Get-ScheduledTask | Where-Object {$_.TaskName -like "Patch My PC"})) {
    $ScheduledTask = New-ScheduledTaskAction -Execute "$InstallationLocation\PatchMyPC.exe" -Argument "/Silent"
    $ScheduledTaskPrinicpal = New-ScheduledTaskPrincipal -UserID "SYSTEM" -LogonType ServiceAccount -RunLevel Highest
    $ScheduledTaskTrigger =  New-ScheduledTaskTrigger -Daily -At "08:00"
    $ScheduledTaskSettingsSet = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -RunOnlyIfNetworkAvailable
    Register-ScheduledTask -Action $ScheduledTask -Trigger $ScheduledTaskTrigger -Principal $ScheduledTaskPrinicpal -TaskName "Patch My PC" 
    Set-ScheduledTask -TaskName "Patch My PC" -Settings $ScheduledTaskSettingsSet
    }