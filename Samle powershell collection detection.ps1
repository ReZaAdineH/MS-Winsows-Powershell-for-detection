# Get a list of all running processes
$processes = Get-Process

# Check for processes that have a name containing "keylog" or "screencap" (indicating they may be keylogging or taking screenshots)
$suspiciousProcesses = $processes | Where-Object {($_.Name -like "*keylog*") -or ($_.Name -like "*screencap*")}

# Print the names of any suspicious processes
$suspiciousProcesses | Select-Object -Property Name

# Get a list of all files on the system
$files = Get-ChildItem -Path C:\ -Recurse -Force

# Check for files that contain "password" or "credentials" in the name
$suspiciousFiles = $files | Where-Object {($_.Name -like "*password*") -or ($_.Name -like "*credentials*")}

# Print the names of any suspicious files
$suspiciousFiles | Select-Object -Property Name

#Get All Installed Software on the system
$software = Get-WmiObject -Class Win32_Product

#Check for software that contain "keylog" or "screencap" in the name
$suspiciousSoftware = $software | Where-Object {($_.Name -like "*keylog*") -or ($_.Name -like "*screencap*")}

# Print the names of any suspicious software
$suspiciousSoftware | Select-Object -Property Name

# Check for files that have been recently modified
$recentlyModifiedFiles = $files | Where-Object {$_.LastWriteTime -gt (Get-Date).AddDays(-1)}

# Print the names of any recently modified files
$recentlyModifiedFiles | Select-Object -Property Name

# Check for scheduled tasks that have been recently modified
$recentlyModifiedTasks = Get-ScheduledTask | Where-Object {$_.LastWriteTime -gt (Get-Date).AddDays(-1)}

# Print the names of any recently modified tasks
$recentlyModifiedTasks | Select-Object -Property TaskName
