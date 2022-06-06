#Custom Mailbox Variables
$Mailbox = "" #User the 'DisplayName' value of the mailbox

#Custom User Variables (Choose One)
$UserFilter = "" #Exmaple: DisplayName eq 'Peter Mijnster' or startswith(JobTitle,'IT')
$UserGroup = "" #Use the 'DisplayName' value of the group

#Set Variables
if ($null -ne $UserFilter) {$Users = Get-AzureADUser -Filter $UserFilter}
if ($null -ne $UserGroup) {$Users = Get-AzureADGroup -SearchString $UserGroup | Get-AzureADGroupMember}

#Get Mailbox Permissions
(($null -eq $GroupDisplayName) -and ($null -eq $UserDisplayName)) {Get-MailboxPermission -Identity $Mailbox | fl -Property User, AccessRights}

#Get Mailbox Recipient Permissions
(($null -eq $GroupDisplayName) -and ($null -eq $UserDisplayName)) {Get-RecipientPermission -Identity $Mailbox | fl -Property Trustee, AccessRights}

#Get Mailbox Permissions and Recipient Permissions
if ($null -ne $Users) {
    $Mailboxes = Get-Mailbox
    foreach ($Mailbox in $Mailboxes) {
        foreach ($User in $Users) {Get-MailboxPermission -Identity $Mailbox.Name -User $User.UserPrincipalName | Format-Table AccessRights, Identity -ErrorAction SilentlyContinue}
        foreach ($User in $Users) {Get-RecipientPermission -Identity $Mailbox.Name -Trustee $User.UserPrincipalName | Format-Table AccessRights, Identity -ErrorAction SilentlyContinue}
        }
    }