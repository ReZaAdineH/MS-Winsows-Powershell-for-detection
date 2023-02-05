# Get a list of all network connections
$connections = Get-NetTCPConnection

# Check for connections to known exfiltration domains or IPs
$exfiltrationConnections = $connections | Where-Object {($_.RemoteAddress -like "*exampleexfiltrationdomain1.com*") -or ($_.RemoteAddress -like "*exampleexfiltrationdomain2.com*") -or ($_.RemoteAddress -like "*111.222.333.444*")}

# Print the remote address and remote port of any exfiltration connections
$exfiltrationConnections | Select-Object -Property RemoteAddress, RemotePort

# Get a list of all scheduled tasks
$tasks = Get-ScheduledTask

# Check for tasks that have a name containing "exfiltration"
$exfiltrationTasks = $tasks | Where-Object {$_.TaskName -like "*exfiltration*"}

# Print the names of any exfiltration tasks
$exfiltrationTasks | Select-Object -Property TaskName

#Check for files with exfiltration extensions
$exfiltrationFiles = Get-ChildItem -Recurse -Include @("*.txt","*.csv","*.xls","*.doc","*.ppt","*.rtf")

# Print the names of any exfiltration files
$exfiltrationFiles | Select-Object -Property Name
