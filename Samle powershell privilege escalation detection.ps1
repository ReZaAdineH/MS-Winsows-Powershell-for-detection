#Check for privileged accounts
$users = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$admin_groups = [System.Security.Principal.WindowsBuiltInRole]::Administrator
$admin_users = New-Object System.Security.Principal.WindowsPrincipal($users)
$admin_users.IsInRole($admin_groups)

#Check for weak permissions on files and folders
Get-ChildItem -Path C:\ -Recurse | Where-Object {$_.PSIsContainer -eq $True} | Get-Acl | Where-Object {$_.AccessToString -like "*Everyone*" -and $_.AccessToString -notlike "*FullControl*"} | Select-Object Path,AccessToString

#Check for unquoted service paths
Get-WmiObject -Class Win32_Service | Where-Object {$_.PathName -notlike '"*'} | Select-Object Name,PathName

#Check for vulnerable software
Get-WmiObject -Class Win32_Product | Select-Object Name, Version

#Check for autologin credentials
(Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\Currentversion\Winlogon\" -ErrorAction SilentlyContinue).GetValue("DefaultUserName")
(Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\Currentversion\Winlogon\" -ErrorAction SilentlyContinue).GetValue("DefaultPassword")
