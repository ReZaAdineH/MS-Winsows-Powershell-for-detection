#Check for powershell event logs for suspicious command execution
Get-EventLog -LogName Microsoft-Windows-PowerShell/Operational | Where-Object {$_.EventID -eq 4104} | Select-Object TimeGenerated,Message

#Check for scheduled tasks that have been created or modified recently
Get-ScheduledTask | Where-Object {$_.State -eq 'Ready' -and ($_.LastRunTime -gt (Get-Date).AddDays(-7))} | Select-Object TaskName,LastRunTime

#Check for recently created or modified services
Get-Service | Where-Object {($_.StartType -eq 'Auto' -or $_.StartType -eq 'Manual') -and ($_.Status -eq 'Running') -and ($_.LastBootUpTime -gt (Get-Date).AddDays(-7))} | Select-Object DisplayName,StartType,Status,LastBootUpTime

#Check for recently created or modified startup items
Get-WmiObject -Class Win32_StartupCommand | Select-Object Name, Location, Command | Where-Object {$_.Location -notlike "*System*" -and ($_.Command -notlike "*Windows*")}

#Check for recently created or modified processes
Get-Process | Where-Object {($_.StartTime -gt (Get-Date).AddDays(-7))} | Select-Object ProcessName,StartTime
