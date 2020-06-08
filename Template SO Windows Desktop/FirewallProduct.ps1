$FirewallProduct = Get-WmiObject -Namespace “root\SecurityCenter2” -Query “SELECT * FROM FirewallProduct”

if ($FirewallProduct) {

Switch ($args[0]) 
    { 
        "displayName" {Write-host $FirewallProduct.displayName} 
        "productState" {Write-host $FirewallProduct.productState}
        default {"ZBX_NOTSUPPORTED"}
    }
    }
else {
    Write-Host 0
    }