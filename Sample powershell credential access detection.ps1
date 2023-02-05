# Get a list of all processes running on the system
$processes = Get-Process

# Check for processes that have a name containing "mimikatz" (indicating they may be using the Mimikatz tool to extract credentials)
$suspiciousProcesses = $processes | Where-Object {$_.Name -like "*mimikatz*"}

# Print the names of any suspicious processes
$suspiciousProcesses | Select-Object -Property Name

# Check for processes that have a name containing "lsass" (indicating they may be using the LSASS memory dump tool to extract credentials)
$suspiciousProcesses = $processes | Where-Object {$_.Name -like "*lsass*"}

# Print the names of any suspicious processes
$suspiciousProcesses | Select-Object -Property Name

# Get a list of all users on the system
$users = Get-WmiObject -Class Win32_UserAccount

# Check for users that have blank passwords
$suspiciousUsers = $users | Where-Object {$_.PasswordRequired -eq $false}

# Print the names of any suspicious users
$suspiciousUsers | Select-Object -Property Name

# Get a list of all network connections
$connections = Get-NetTCPConnection

# Check for connections to known C2 servers
$suspiciousConnections = $connections | Where-Object {$_.RemoteAddress -like "*attacker-server.com*"}

# Print the remote addresses of any suspicious connections
$suspiciousConnections | Select-Object -Property RemoteAddress

# Get a list of all open files on the system
$files = Get-ChildItem -Path C:\ -Recurse -Force

# Check for files that have been recently modified and contain "password" in the name
$suspiciousFiles = $files | Where-Object {($_.LastWriteTime -gt (Get-Date).AddDays(-1)) -and ($_.Name -like "*password*")}

# Print the names of any suspicious files
$suspiciousFiles | Select-Object -Property Name

# Get a list of all scheduled tasks on the system
$tasks = Get-ScheduledTask

# Check for tasks that are configured to run with high privileges
$suspiciousTasks = $tasks | Where-Object {$_.Principal.UserId -eq "NT AUTHORITY\SYSTEM"}

# Print the names of any suspicious tasks
$suspiciousTasks | Select-Object -Property TaskName

