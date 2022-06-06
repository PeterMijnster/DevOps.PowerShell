function Add-CustomMailboxPermissionUser {
    Param (
        $Mailbox,
        $MailboxAutomap,
        $MailboxPermission,
        $MailboxRecipientPermission,
        $UserDisplayName
    )

    #Custom User Variables
    $User = Get-AzureADUser -SearchString $UserDisplayName

    #Add Mailbox Permissions
    if ($null -ne $MailboxPermission) {Add-MailboxPermission -Identity $Mailbox -User $User.UserPrincipalName -AccessRights $MailboxPermission -InheritanceType All -AutoMapping $MailboxAutomap}
    
    #Add Mailbox Recipient Permissions
    if ($null -ne $MailboxRecipientPermission) {Add-RecipientPermission -Identity $Mailbox -Trustee $User.UserPrincipalName -AccessRights $MailboxRecipientPermission -Confirm:$false}
    }

Add-CustomMailboxPermissionUser -Mailbox "Sound of Data - Team Development" -MailboxAutomap $false -MailboxPermission "FullAccess" -MailboxRecipientPermission "SendAs" -UserDisplayName "Peter Mijnster"