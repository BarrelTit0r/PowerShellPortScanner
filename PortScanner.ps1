param (
    [Parameter(Mandatory = $true)]
    [string]$TargetIP
)

# Common TCP ports used by Windows systems
$Ports = @{
    53    = "DNS"
    80    = "HTTP"
    88    = "Kerberos"
    135   = "RPC Endpoint Mapper"
    389   = "LDAP"
    443   = "HTTPS"
    445   = "SMB"
    464   = "Kerberos Password Change"
    636   = "LDAPS"
    3268  = "Global Catalog"
    3269  = "Global Catalog (SSL)"
    3389  = "Remote Desktop"
    5722  = "DFSR"
    5985  = "WinRM HTTP"
    5986  = "WinRM HTTPS"
    9389  = "Active Directory Web Services"
}

Write-Host "Scanning $TargetIP for Domain Controller TCP ports..." -ForegroundColor Cyan
Write-Host ""

foreach ($Port in $Ports.Keys | Sort-Object) {
    try {
        $Result = Test-NetConnection -ComputerName $TargetIP -Port $Port -InformationLevel Quiet

        if ($Result) {
            Write-Host "[$Port] OPEN  - $($Ports[$Port])" -ForegroundColor Green
        }
    }
    catch {
        Write-Host "[$Port] ERROR  - $($Ports[$Port])" -ForegroundColor Red
    }
}
