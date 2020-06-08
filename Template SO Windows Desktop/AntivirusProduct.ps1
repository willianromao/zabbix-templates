$AntivirusProduct = Get-WmiObject -Namespace “root\SecurityCenter2” -Query “SELECT * FROM AntiVirusProduct”

if ($AntivirusProduct) {

Switch ($args[0]) 
    { 
        "displayName" {Write-host $AntivirusProduct.displayName} 
        "productState" {Write-host $AntivirusProduct.productState}
        default {"ZBX_NOTSUPPORTED"}
    }
    }
else {
    Write-Host 0
    }