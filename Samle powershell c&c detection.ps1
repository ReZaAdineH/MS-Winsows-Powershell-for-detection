# Get a list of all network connections
$connections = Get-NetTCPConnection

# Check for connections to known C2 domains or IPs
$c2Connections = $connections | Where-Object {($_.RemoteAddress -like "*examplec2domain1.com*") -or ($_.RemoteAddress -like "*examplec2domain2.com*") -or ($_.RemoteAddress -like "*111.222.333.444*")}

# Print the remote address and remote port of any C2 connections
$c2Connections | Select-Object -Property RemoteAddress, RemotePort

# Get a list of all scheduled tasks
$tasks = Get-ScheduledTask

# Check for tasks that have a name containing "c2"
$c2Tasks = $tasks | Where-Object {$_.TaskName -like "*c2*"}

# Print the names of any C2 tasks
$c2Tasks | Select-Object -Property TaskName

#Get All Installed Software on the system
$software = Get-WmiObject -Class Win32_Product

#Check for software that contain "c2" in the name
$suspiciousSoftware = $software | Where-Object {$_.Name -like "*c2*"}

# Print the names of any suspicious software
$suspiciousSoftware | Select-Object -Property Name
