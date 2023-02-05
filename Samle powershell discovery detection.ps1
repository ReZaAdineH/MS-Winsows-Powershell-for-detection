# Get a list of all running processes
$processes = Get-Process

# Check for processes that have a name containing "net" (indicating they may be using the net command to discover network information)
$suspiciousProcesses = $processes | Where-Object {$_.Name -like "*net*"}

# Print the names of any suspicious processes
$suspiciousProcesses | Select-Object -Property Name

# Get a list of all network connections
$connections = Get-NetTCPConnection

# Check for connections to known network discovery tools
$suspiciousConnections = $connections | Where-Object {($_.RemoteAddress -like "*nmap*") -or ($_.RemoteAddress -like "*fping*")}

# Print the remote addresses of any suspicious connections
$suspiciousConnections | Select-Object -Property RemoteAddress

# Get a list of all open files on the system
$files = Get-ChildItem -Path C:\ -Recurse -Force

# Check for files that have been recently modified and contain "discover" in the name
$suspiciousFiles = $files | Where-Object {($_.LastWriteTime -gt (Get-Date).AddDays(-1)) -and ($_.Name -like "*discover*")}

# Print the names of any suspicious files
$suspiciousFiles | Select-Object -Property Name

# Get a list of all scheduled tasks on the system
$tasks = Get-ScheduledTask

# Check for tasks that are configured to run with high privileges
$suspiciousTasks = $tasks | Where-Object {$_.Principal.UserId -eq "NT AUTHORITY\SYSTEM"}

# Print the names of any suspicious tasks
$suspiciousTasks | Select-Object -Property TaskName

# Get a list of all services
$services = Get-Service

# Check for services that have the name containing "port" 
$suspiciousServices = $services | Where-Object {$_.Name -like "*port*"}

# Print the names of any suspicious services
$suspiciousServices | Select-Object -Property Name

