function Enable-SecurityFixes {
    #Protocol Security - Disable SSL 2.0
    $SChannelRegPath = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols"
    New-Item $SChannelRegPath -Name "SSL 2.0" -Force
    New-Item $SChannelRegPath"\SSL 2.0\Client" -Force
    New-Item $SChannelRegPath"\SSL 2.0\Server" -Force
    New-ItemProperty -Path $SChannelRegPath"\SSL 2.0\Client" -Name Enabled -Value 0 -PropertyType DWORD -Force
    New-ItemProperty -Path $SChannelRegPath"\SSL 2.0\Client" -Name DisabledByDefault -Value 1 -PropertyType DWORD -Force
    New-ItemProperty -Path $SChannelRegPath"\SSL 2.0\Server" -Name Enabled -Value 0 -PropertyType DWORD -Force
    New-ItemProperty -Path $SChannelRegPath"\SSL 2.0\Server" -Name DisabledByDefault -Value 1 -PropertyType DWORD -Force

    #Protocol Security - Disable SSL 3.0
    $SChannelRegPath = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols"
    New-Item $SChannelRegPath -Name "SSL 3.0" -Force
    New-Item $SChannelRegPath"\SSL 3.0\Client" -Force
    New-Item $SChannelRegPath"\SSL 3.0\Server" -Force
    New-ItemProperty -Path $SChannelRegPath"\SSL 3.0\Client" -Name Enabled -Value 0 -PropertyType DWORD -Force
    New-ItemProperty -Path $SChannelRegPath"\SSL 3.0\Client" -Name DisabledByDefault -Value 1 -PropertyType DWORD -Force
    New-ItemProperty -Path $SChannelRegPath"\SSL 3.0\Server" -Name Enabled -Value 0 -PropertyType DWORD -Force
    New-ItemProperty -Path $SChannelRegPath"\SSL 3.0\Server" -Name DisabledByDefault -Value 1 -PropertyType DWORD -Force

    #Protocol Security - Disable TLS 1.0
    $SChannelRegPath = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols"
    New-Item $SChannelRegPath -Name "TLS 1.0" -Force
    New-Item $SChannelRegPath"\TLS 1.0\Client" -Force
    New-Item $SChannelRegPath"\TLS 1.0\Server" -Force
    New-ItemProperty -Path $SChannelRegPath"\TLS 1.0\Client" -Name Enabled -Value 0 -PropertyType DWORD -Force
    New-ItemProperty -Path $SChannelRegPath"\TLS 1.0\Client" -Name DisabledByDefault -Value 1 -PropertyType DWORD -Force
    New-ItemProperty -Path $SChannelRegPath"\TLS 1.0\Server" -Name Enabled -Value 0 -PropertyType DWORD -Force
    New-ItemProperty -Path $SChannelRegPath"\TLS 1.0\Server" -Name DisabledByDefault -Value 1 -PropertyType DWORD -Force

    #Protocol Security - Enable TLS 1.1
    $SChannelRegPath = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols"
    New-Item $SChannelRegPath -Name "TLS 1.1" -Force
    New-Item $SChannelRegPath"\TLS 1.1\Client" -Force
    New-Item $SChannelRegPath"\TLS 1.1\Server" -Force
    New-ItemProperty -Path $SChannelRegPath"\TLS 1.1\Client" -Name Enabled -Value 0 -PropertyType DWORD -Force
    New-ItemProperty -Path $SChannelRegPath"\TLS 1.1\Client" -Name DisabledByDefault -Value 1 -PropertyType DWORD -Force
    New-ItemProperty -Path $SChannelRegPath"\TLS 1.1\Server" -Name Enabled -Value 0 -PropertyType DWORD -Force
    New-ItemProperty -Path $SChannelRegPath"\TLS 1.1\Server" -Name DisabledByDefault -Value 1 -PropertyType DWORD -Force

    #Protocol Security - Enable TLS 1.2
    $SChannelRegPath = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols"
    New-Item $SChannelRegPath -Name "TLS 1.2" -Force
    New-Item $SChannelRegPath"\TLS 1.2\Server" -Force
    New-Item $SChannelRegPath"\TLS 1.2\Client" -Force
    New-ItemProperty -Path $SChannelRegPath"\TLS 1.2\Server" -Name Enabled -Value 1 -PropertyType DWORD -Force
    New-ItemProperty -Path $SChannelRegPath"\TLS 1.2\Server" -Name DisabledByDefault -Value 0 -PropertyType DWORD -Force
    New-ItemProperty -Path $SChannelRegPath"\TLS 1.2\Client" -Name Enabled -Value 1 -PropertyType DWORD -Force
    New-ItemProperty -Path $SChannelRegPath"\TLS 1.2\Client" -Name DisabledByDefault -Value 0 -PropertyType DWORD -Force

    #Protocol Security - Enable TLS 1.3
    $SChannelRegPath = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols"
    New-Item $SChannelRegPath -Name "TLS 1.3" -Force
    New-Item $SChannelRegPath"\TLS 1.3\Server" -Force
    New-Item $SChannelRegPath"\TLS 1.3\Client" -Force
    New-ItemProperty -Path $SChannelRegPath"\TLS 1.3\Server" -Name Enabled -Value 1 -PropertyType DWORD -Force
    New-ItemProperty -Path $SChannelRegPath"\TLS 1.3\Server" -Name DisabledByDefault -Value 0 -PropertyType DWORD -Force
    New-ItemProperty -Path $SChannelRegPath"\TLS 1.3\Client" -Name Enabled -Value 1 -PropertyType DWORD -Force
    New-ItemProperty -Path $SChannelRegPath"\TLS 1.3\Client" -Name DisabledByDefault -Value 0 -PropertyType DWORD -Force
}

#Examples
Enable-SecurityFixes