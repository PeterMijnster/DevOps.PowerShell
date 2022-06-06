function Set-ProtocolSecurity{
    #Scan File Integrity and Repair Problems
    Start-Process "sfc.exe" -ArgumentList "/scannow"
    
    #Scan Image Integrity and Repair Problems
    Start-Process "dism.exe" -ArgumentList "/online /cleanup-image /restorehealth"
    
    #Clear ARP Cache
    Start-Process "arp.exe" -ArgumentList "/d"
    
    #Clear DNS Cache
    Start-Process "ipconfig.exe" -ArgumentList "/flushdns"
    
    #Clear Event Viewer Logs
    $Get-EventLog * | ForEach { Clear-EventLog $_.Log }

    #Remove Temporary Files
    Get-ChildItem $Env:WINDIR\Temp | Remove-Item -Recurse -Force -ErrorAction Ignore

}