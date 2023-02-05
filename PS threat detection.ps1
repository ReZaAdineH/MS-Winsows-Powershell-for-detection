# powershell script, script will check for suspicious processes, scheduled tasks, network connections, and Windows event logs, and will export the results to CSV files for further analysis.
# Check for suspicious processes
Get-Process | Where-Object {$_.Path -like "*\.exe"} | Select-Object Name, Path, Company | Export-Csv -Path C:\suspicious_processes.csv

# Check for suspicious scheduled tasks
Get-ScheduledTask | Select-Object TaskName, TaskPath, Principal | Export-Csv -Path C:\suspicious_scheduled_tasks.csv

# Check for suspicious network connections
Get-NetTCPConnection | Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State | Export-Csv -Path C:\suspicious_network_connections.csv

# Check for suspicious Windows event logs
Get-EventLog -LogName Security -InstanceId 4688 | Select-Object TimeGenerated, EventID, Message | Export-Csv -Path C:\suspicious_event_logs.csv
