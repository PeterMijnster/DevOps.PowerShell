function Enable-InterfaceFixes {
    #Set Classic Context Menu
    New-Item "HKCU:\Software\Classes\CLSID\" -Name "{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -Force
    New-Item "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\" -Name "InprocServer32" -Force
    Set-ItemProperty "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "(Default)" -Value $null -Force
}

#Examples
Enable-InterfaceFixes