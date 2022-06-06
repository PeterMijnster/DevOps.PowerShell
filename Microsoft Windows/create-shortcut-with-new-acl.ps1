#Apply Global Variables
$CommonDesktop = (New-Object -ComObject Shell.Application).NameSpace('shell:Common Desktop').Self.Path

#Shortcut Custom Variables
$Application = ""
$ApplicationArguments = ""
$ShortcutName = ""

#Shortcut Custom ACL Variables
$Identity = "" #Everyone
$FileSystemRights = "" #FullControl

#Create Shortcut and Set New Shortcut ACL
if (!(Test-Path "$CommonDesktop\Shortcut.lnk")) {
    #Create Shortcut
    $WScriptShell = New-Object -ComObject WScript.Shell
    $ShortcutTarget = "$Application"
    $ShortcutTargetArguments = "$ApplicationArguments"
    $ShortcutTargetPath = "$CommonDesktop\$ShortcutName.lnk"
    $Shortcut = $WScriptShell.CreateShortcut($ShortcutTargetPath)
    $Shortcut.Arguments = $ShortcutTargetArguments
    $Shortcut.TargetPath = $ShortcutTarget
    $Shortcut.Save()
    
    #Set New Shotcut ACL
    $NewAcl = Get-Acl "$CommonDesktop\$ShortcutName.lnk"
    $NewAclIdentity = $Identity
    $NewAclFileSystemRights = $FileSystemRights
    $NewAclType = "Allow"
    $FileSystemAccessRuleArgumentList = $NewAclIdentity, $NewAclFileSystemRights, $NewAclType
    $FileSystemAccessRule = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $FileSystemAccessRuleArgumentList
    $NewAcl.SetAccessRule($FileSystemAccessRule)
    Set-Acl "$CommonDesktop\$ShortcutName.lnk" -AclObject $NewAcl
    }