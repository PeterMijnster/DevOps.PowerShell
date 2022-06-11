$SharePointSiteUri = ""
Set-SPOSite -Identity $SharePointSiteUri -DenyAddAndCustomizePages 0
Set-PnPList -Identity "Form Templates" -Hidden $true
Set-PnPList -Identity "Style Library" -Hidden $true
Set-PnPList -Identity "Site Assets" -Hidden $true
Set-PnPList -Identity "Site Pages" -Hidden $true
Remove-PnpList -Identity "Shared Documents" -Force