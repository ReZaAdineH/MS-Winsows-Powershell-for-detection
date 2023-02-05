# Check for new user accounts
$newusers = net user | findstr /B /C:"The command completed successfully"
if ($newusers) {
    Write-Host "New user accounts detected:"
    Write-Host $newusers
}

# Check for new scheduled tasks
$newtasks = schtasks /query /fo LIST /v | findstr /B /C:"TaskName"
if ($newtasks) {
    Write-Host "New scheduled tasks detected:"
    Write-Host $newtasks
}

# Check for new services
$newsvcs = Get-WmiObject -Class Win32_Service | Where-Object {$_.StartName -eq "NT AUTHORITY\LocalService" -or $_.StartName -eq "NT AUTHORITY\NetworkService" -or $_.StartName -eq "NT AUTHORITY\LocalSystem"}
if ($newsvcs) {
    Write-Host "New services detected:"
    Write-Host $newsvcs
}

# Check for new process execution
$newprocs = Get-EventLog -LogName Security -Source Microsoft-Windows-Sysmon/Operational | Where-Object {$_.EventID -eq 1} | Select-Object -Property TimeGenerated, Message
if ($newprocs) {
    Write-Host "New process execution detected:"
    Write-Host $newprocs
}
