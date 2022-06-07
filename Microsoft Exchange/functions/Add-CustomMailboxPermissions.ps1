function Add-CustomMailboxPermissions {
    Param (
        $Mailbox,
        $MailboxAutomap,
        $MailboxPermission,
        $MailboxRecipientPermission,
        $GroupDisplayName,
        $UserDisplayName
    )

    #Custom User Variables
    if ($null -ne $GroupDisplayName) {$Users = Get-AzureADGroup -SearchString $GroupDisplayName| Get-AzureADGroupMember}
    if ($null -ne $UserDisplayName) {$Users = Get-AzureADUser -SearchString $UserDisplayName}

    #Add Mailbox Permissions
    if ($null -ne $MailboxPermission) {
        foreach ($User in $Users) {
            Add-MailboxPermission -Identity $Mailbox -User $User.UserPrincipalName -AccessRights $MailboxPermission -InheritanceType All -AutoMapping $MailboxAutomap
        }
    }
    #Add Mailbox Recipient Permissions
    if ($null -ne $MailboxRecipientPermission) {
        foreach ($User in $Users) {
            Add-RecipientPermission -Identity $Mailbox -Trustee $User.UserPrincipalName -AccessRights $MailboxRecipientPermission -Confirm:$false
        }
    }
}

#Examples
Add-CustomMailboxPermissions -Mailbox "OneTribe - DevOps" -MailboxAutomap $false -MailboxPermission "FullAccess" -MailboxRecipientPermission "SendAs" -GroupDisplayName "OneTribe - DevOps"
Add-CustomMailboxPermissions -Mailbox "OneTribe - DevOps" -MailboxAutomap $false -MailboxPermission "FullAccess" -MailboxRecipientPermission "SendAs" -UserDisplayName "Peter Mijnster"