function Get-CustomMailboxPermissions {
    Param (
        $Mailbox,
        $GroupDisplayName,
        $UserDisplayName
    )

    #Custom User Variables
    if ($null -ne $GroupDisplayName) {$Users = Get-AzureADGroup -SearchString $GroupDisplayName| Get-AzureADGroupMember}
    if ($null -ne $UserDisplayName) {$Users = Get-AzureADUser -SearchString $UserDisplayName}

    #Get Mailbox Permissions
    if (($null -eq $GroupDisplayName) -and ($null -eq $UserDisplayName)) {Get-MailboxPermission -Identity $Mailbox | Format-List -Property User, -AccessRights}

    #Get Mailbox Recipient Permissions
    if (($null -eq $GroupDisplayName) -and ($null -eq $UserDisplayName)) {Get-RecipientPermission -Identity $Mailbox | Format-List -Property Trustee, AccessRights}

    #Get Mailbox Permissions and Recipient Permissions
    if ($null -ne $Users) {
        $Mailboxes = Get-Mailbox
        foreach ($Mailbox in $Mailboxes) {
            foreach ($User in $Users) {
                Get-MailboxPermission -Identity $Mailbox.Name -User $User.UserPrincipalName | Format-Table AccessRights, Identity -ErrorAction SilentlyContinue
            }
            foreach ($User in $Users) {
                Get-RecipientPermission -Identity $Mailbox.Name -Trustee $User.UserPrincipalName | Format-Table AccessRights, Identity -ErrorAction SilentlyContinue
            }
        }
    }
}

#Examples
Get-CustomMailboxPermissions -Mailbox "OneTribe - DevOps"
Get-CustomMailboxPermissions -Mailbox "OneTribe - DevOps" -GroupDisplayName "OneTribe - DevOps"
Get-CustomMailboxPermissions -Mailbox "OneTribe - DevOps" -UserDisplayName "Peter Mijnster"