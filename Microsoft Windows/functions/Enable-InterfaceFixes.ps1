function Enable-InterfaceFixes {
    #Configure the Classic Context Menu for Microsoft Windows 11
    New-Item "HKCU:\Software\Classes\CLSID\" -Name "{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -Force
    New-Item "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\" -Name "InprocServer32" -Force
    Set-ItemProperty "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "(Default)" -Value $null -Force

    #Configure the Explorer for Microsoft Windows 11
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 -Force #unhide extensions for known file types
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPath" -Value 1 -Force #display the full path in title bar

    #Configure the Taskbar for Microsoft Windows 11
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Value 0 -Force #remove widgets from the taskbar
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Value 0 -Force #remove chat  from the taskbar
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0 -Force #remove search from the taskbar

}

#Examples
Enable-InterfaceFixes