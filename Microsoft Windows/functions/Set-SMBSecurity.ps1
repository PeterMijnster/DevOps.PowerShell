function Set-SMBSecurity{
    #SMB Security - Disable SMB v1
    Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force

    #SMB Security - Enable SMB Signing
    Set-SmbServerConfiguration -EncryptData $true -Force
    Set-SmbServerConfiguration -RequireSecuritySignature $true -Force
}

#Examples
Set-SMBSecurity