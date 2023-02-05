# Check for active network connections
$netstat = netstat -an | findstr "ESTABLISHED"
if ($netstat) {
    Write-Host "Active network connections detected:"
    Write-Host $netstat
}

# Check for recent DNS lookups
$dnslog = Get-EventLog -LogName System -Source Microsoft-Windows-DNS-Client | Where-Object {$_.TimeGenerated -gt (Get-Date).AddDays(-1)} | Select-Object -Property TimeGenerated, Message
if ($dnslog) {
    Write-Host "Recent DNS lookups detected:"
    Write-Host $dnslog
}

# Check for remote desktop connections
$rdplog = Get-EventLog -LogName Security -Source Microsoft-Windows-TerminalServices-LocalSessionManager | Where-Object {$_.TimeGenerated -gt (Get-Date).AddDays(-1)} | Select-Object -Property TimeGenerated, Message
if ($rdplog) {
    Write-Host "Recent RDP connections detected:"
    Write-Host $rdplog
}

# Check for scheduled tasks
$schtasks = schtasks /query /fo LIST /v | findstr "TaskName"
if ($schtasks) {
    Write-Host "Scheduled tasks detected:"
    Write-Host $schtasks
}
