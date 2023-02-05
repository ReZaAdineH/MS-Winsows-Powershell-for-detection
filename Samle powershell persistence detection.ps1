#Check for persistence via scheduled tasks
Get-ScheduledTask | Where-Object {$_.State -eq 'Ready'} | Select-Object TaskName,Triggers,Actions

#Check for persistence via services
Get-Service | Where-Object {($_.StartType -eq 'Auto' -or $_.StartType -eq 'Manual') -and ($_.Status -eq 'Running')} | Select-Object DisplayName,StartType,Status,PathName

#Check for persistence via startup items
Get-WmiObject -Class Win32_StartupCommand | Select-Object Name, Location, Command | Where-Object {$_.Location -notlike "*System*" -and ($_.Command -notlike "*Windows*")}

#Check for persistence via registry keys
Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' | Select-Object -Property *
Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce' | Select-Object -Property *
Get-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' | Select-Object -Property *
Get-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce' | Select-Object -Property *

#Check for persistence via WMI
Get-WmiObject -Namespace "root\subscription" -Class "__EventFilter" | Where-Object {$_.Name -notlike "*Health*"} | Select-Object Name,Query
