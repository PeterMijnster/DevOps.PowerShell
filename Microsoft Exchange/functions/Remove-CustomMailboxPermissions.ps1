function Remove-CustomMailboxPermissions {
    Param (
        $Mailbox,
        $GroupDisplayName,
        $UserDisplayName,
        $Confirm
    )

    #Custom User Variables
    if ($null -ne $GroupDisplayName) {$Users = Get-AzureADGroup -SearchString $GroupDisplayName| Get-AzureADGroupMember}
    if ($null -ne $UserDisplayName) {$Users = Get-AzureADUser -SearchString $UserDisplayName}

    #Remove Mailbox Permissions
    if (($null -eq $GroupDisplayName) -and ($null -eq $UserDisplayName)) {
        $MailboxPermissions = Get-MailboxPermission -Identity $Mailbox
        foreach ($MailboxPermission in $MailboxPermissions) {
            if ($MailboxPermission.User -notlike "*NT AUTHORITY\*") {
            Remove-MailboxPermission -Identity $MailboxPermission.Identity -User $MailboxPermission.User -AccessRights $MailboxPermission.AccessRights
            }
        }
    }

    #Get Mailbox Recipient Permissions
    if (($null -eq $GroupDisplayName) -and ($null -eq $UserDisplayName)) {
        $RecipientPermissions = Get-RecipientPermission -Identity $Mailbox
        foreach ($RecipientPermission in $RecipientPermissions) {
            if ($RecipientPermission.Trustee -notlike "*NT AUTHORITY\*") {
            Remove-RecipientPermission -Identity $RecipientPermission.Identity -Trustee $RecipientPermission.Trustee -AccessRights $RecipientPermission.AccessRights
            }
        }
    }

    #Remove Mailbox Permissions and Recipient Permissions
    if ($null -ne $Users) {
        $Mailboxes = Get-Mailbox
        foreach ($Mailbox in $Mailboxes) {
            foreach ($User in $Users) {
                $MailboxPermissions = Get-MailboxPermission -Identity $Mailbox.Name -User $User.UserPrincipalName
                if ($null -ne $MailboxPermissions) {
                    Remove-MailboxPermission -Identity $Mailbox.Name -User $User.UserPrincipalName -AccessRights $MailboxPermissions.AccessRights -Confirm:$Confirm
                    }
            }
            foreach ($User in $Users) {
                $RecipientPermissions = Get-RecipientPermission -Identity $Mailbox.Name -Trustee $User.UserPrincipalName
                if ($null -ne $RecipientPermissions) {
                    Remove-RecipientPermission -Identity $Mailbox.Name -Trustee $User.UserPrincipalName -AccessRights $RecipientPermissions.AccessRights -Confirm:$Confirm
                }
            }
        }
    }
}

#Examples:
Remove-CustomMailboxPermissions -Mailbox "OneTribe - DevOps"
Remove-CustomMailboxPermissions -Mailbox "OneTribe - DevOps" -GroupDisplayName "OneTribe - DevOps"
Remove-CustomMailboxPermissions -Mailbox "OneTribe - DevOps" -UserDisplayName "Peter Mijnster"