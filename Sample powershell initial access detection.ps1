# Get a list of all processes currently running
$processes = Get-Process

# Initialize variables for process names and command line arguments
$processesWithCommandLine = @()
$processesWithParent = @()

# Iterate through each process and gather information
foreach ($process in $processes) {
    # Get the command line arguments for the process
    $commandLine = (Get-CimInstance Win32_Process -Filter "Name='$($process.ProcessName)'" | Select-Object CommandLine).CommandLine
    if ($commandLine) {
        $processesWithCommandLine += New-Object PSObject -Property @{
            ProcessName = $process.ProcessName
            CommandLine = $commandLine
        }
    }

    # Get the parent process for the current process
    $parentProcess = (Get-CimInstance -Class Win32_Process -Filter "Name='$($process.ProcessName)'" | Select-Object ParentProcessId).ParentProcessId
    if ($parentProcess) {
        $processesWithParent += New-Object PSObject -Property @{
            ProcessName = $process.ProcessName
            ParentProcess = (Get-Process -Id $parentProcess).ProcessName
        }
    }
}

# Filter out processes that have a known parent process
$suspiciousProcesses = $processesWithParent | Where-Object {$_.ParentProcess -notmatch 'explorer.exe|services.exe|lsass.exe|svchost.exe'}

# Look for processes that have suspicious command line arguments
$suspiciousCommandLine = $processesWithCommandLine | Where-Object {$_.CommandLine -match '-e|-ep|-ep1|-ep2|-noP|-noP1|-noP2|-sta|-enc|-encP'}

# Output the results
if ($suspiciousProcesses) {
    Write-Host "Suspicious processes with unknown parent:"
    $suspiciousProcesses | Format-Table -Property ProcessName, ParentProcess
}

if ($suspiciousCommandLine) {
    Write-Host "Suspicious processes with suspicious command line arguments:"
    $suspiciousCommandLine | Format-Table -Property ProcessName, CommandLine
}
