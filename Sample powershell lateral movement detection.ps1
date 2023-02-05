# Get a list of all running processes
$processes = Get-Process

# Check for processes that have a name containing "psexec" or "wmic" (indicating they may be using PsExec or WMI for lateral movement)
$suspiciousProcesses = $processes | Where-Object {($_.Name -like "*psexec*") -or ($_.Name -like "*wmic*")}

# Print the names of any suspicious processes
$suspiciousProcesses | Select-Object -Property Name

# Get a list of all network connections
$connections = Get-NetTCPConnection

# Check for connections to known lateral movement tools
$suspiciousConnections = $connections | Where-Object {($_.RemoteAddress -like "*psexec*") -or ($_.RemoteAddress -like "*smb*") -or ($_.RemoteAddress -like "*dcerpc*")}

# Print the remote addresses of any suspicious connections
$suspiciousConnections | Select-Object -Property RemoteAddress

# Get a list of all open files on the system
$files = Get-ChildItem -Path C:\ -Recurse -Force

# Check for files that have been recently modified and contain "lateral" in the name
$suspiciousFiles = $files | Where-Object {($_.LastWriteTime -gt (Get-Date).AddDays(-1)) -and ($_.Name -like "*lateral*")}

# Print the names of any suspicious files
$suspiciousFiles | Select-Object -Property Name

# Get a list of all scheduled tasks on the system
$tasks = Get-ScheduledTask

# Check for tasks that are configured to run with high privileges
$suspiciousTasks = $tasks | Where-Object {$_.Principal.UserId -eq "NT AUTHORITY\SYSTEM"}

# Print the names of any suspicious tasks
$suspiciousTasks | Select-Object -Property TaskName
