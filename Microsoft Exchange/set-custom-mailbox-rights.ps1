#Custom Variables
$Automap = $false
$Mailbox = ""
$MailboxPermission = "" #FullAccess, ChangePermission, ReadPermission
RecipientPermission "" #SendAs
$UserFilter = ""
$UserGroup = ""

#Set Variables
if ($null -ne $UserFilter) {$Users = Get-AzureADUser -Filter $UserFilter}
if ($null -ne $UserGroup) {$Users = Get-AzureADGroup -SearchString $UserGroup | Get-AzureADGroupMember}

#Set Full Access Rights
if ($null -ne $MailboxPermission) {foreach($User in $Users) {Add-MailboxPermission -Identity $Mailbox -User $User -AccessRights $MailboxPermission -InheritanceType All -AutoMapping $Automap}}

#Set Send As Rights
if ($null -ne $RecipientPermission) {foreach($User in $Users) {Add-RecipientPermission -Identity $Mailbox  -Trustee $User -AccessRights SendAs}}