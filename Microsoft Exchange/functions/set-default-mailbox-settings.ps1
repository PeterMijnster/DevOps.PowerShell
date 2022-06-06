function Set-DefaultMailboxSettings{
    Param (
        $MailboxLanguage,
        $MailboxDateFormat,
        $MailboxTimeFormat,
        $MailboxTimeZone,
        $MailboxCalendarAccessRights,
        $MailboxMaxSendSize,
        $MailboxMaxReceiveSize
    )

foreach($user in Get-Mailbox -RecipientTypeDetails UserMailbox) {
    $cal = $user.Alias+":\Calendar"
    Set-MailboxRegionalConfiguration -Identity $user.Alias -LocalizeDefaultFolderName:$true -Language $MailboxLanguage -DateFormat $MailboxDateFormat -TimeFormat $MailboxTimeFormat -TimeZone $MailboxTimeZone
    Set-MailboxFolderPermission -Identity $cal -User Default -AccessRights $MailboxCalendarAccessRights
    Set-Mailbox -Identity $user.Alias -MaxSendSize $MailboxMaxSendSize
    Set-Mailbox -Identity $user.Alias -MaxReceiveSize $MailboxMaxReceiveSize
    }

#Examples
Set-DefaultMailboxSettings -MailboxLanguage "en-US" -MailboxDateFormat "dd-MM-yyyy" -MailboxTimeFormat "HH:mm" -MailboxCalenderAccessRights "LimitedDetails" -MailboxMaxSendSize "128MB" -MailboxMaxReceiveSize "128MB"