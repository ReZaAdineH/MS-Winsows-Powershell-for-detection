# Get a list of all running processes
$processes = Get-Process

# Check for processes with a parent process ID of 0 (indicating they were started by the system)
$suspiciousProcesses = $processes | Where-Object {$_.ParentProcessId -eq 0}

# Print the names of any suspicious processes
$suspiciousProcesses | Select-Object -Property Name

# Get a list of all scheduled tasks
$tasks = Get-ScheduledTask

# Check for tasks that are set to run with system-level privileges
$suspiciousTasks = $tasks | Where-Object {$_.Principal.UserId -eq "NT AUTHORITY\SYSTEM"}

# Print the names of any suspicious tasks
$suspiciousTasks | Select-Object -Property TaskName

# Get a list of all services
$services = Get-Service

# Check for services that are set to start automatically but are not running
$suspiciousServices = $services | Where-Object {($_.StartType -eq "Automatic") -and ($_.Status -ne "Running")}

# Print the names of any suspicious services
$suspiciousServices | Select-Object -Property Name

# Get a list of all Windows Event Logs
$logs = Get-WinEvent -ListLog *

# Check for logs that have been cleared recently
$suspiciousLogs = $logs | Where-Object {$_.LastAccessTime -gt (Get-Date).AddDays(-1)}

# Print the names of any suspicious logs
$suspiciousLogs | Select-Object -Property LogName
