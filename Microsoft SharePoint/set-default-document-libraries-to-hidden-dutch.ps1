$SharePointSiteUri = ""
Set-SPOSite -Identity $SharePointSiteUri -DenyAddAndCustomizePages 0
Set-PnPList -Identity "Formuliersjablonen" -Hidden $true
Set-PnPList -Identity "Gebeurtenissen" -Hidden $true
Set-PnPList -Identity "Sitepagina's" -Hidden $true
Set-PnPList -Identity "Stijlbibliotheek" -Hidden $true
Remove-PnpList -Identity "Gedeelde Documenten" -Force