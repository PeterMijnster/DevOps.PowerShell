#Custom Mailbox Variables
$Mailbox = "" #User the 'DisplayName' value of the mailbox
$MailboxAutomap = $false #Allowed values: $true, $false
$MailboxPermission = "" #Allowed values: FullAccess, ChangePermission, ReadPermission
$MailboxRecipientPermission "" #Allowed values: SendAs

#Custom User Variables (Choose One)
$UserFilter = "" #Exmaple: DisplayName eq 'Peter Mijnster' or startswith(JobTitle,'IT')
$UserGroup = "" #Use the 'DisplayName' value of the group

#Set Variables
if ($null -ne $UserFilter) {$Users = Get-AzureADUser -Filter $UserFilter}
if ($null -ne $UserGroup) {$Users = Get-AzureADGroup -SearchString $UserGroup | Get-AzureADGroupMember}

#Set Full Access Rights
if ($null -ne $MailboxPermission) {foreach($User in $Users) {Add-MailboxPermission -Identity $Mailbox -User $User -AccessRights $MailboxPermission -InheritanceType All -AutoMapping $MailboxAutomap}}

#Set Send As Rights
if ($null -ne $MailboxRecipientPermission) {foreach($User in $Users) {Add-RecipientPermission -Identity $Mailbox  -Trustee $User -AccessRights $MailboxRecipientPermission}}