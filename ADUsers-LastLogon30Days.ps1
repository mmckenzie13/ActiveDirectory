# Set Variables and Days for Stale
$InactiveDays = 30
$Days = (Get-Date).Adddays(-($InactiveDays))

# Need to Update SearchBase for your domain. Update your Output location if needed. 
# Will grab Name, UPN, and Date
Get-ADUser -Filter {LastLogonTimeStamp -lt $Days -and enabled -eq $true} -SearchBase 'DC=Company,DC=LOCAL' -Properties LastLogonTimeStamp | select-object Name,UserPrincipalName,@{Name="Date"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp).ToString('MM-dd-yyyy')}} | export-csv C:\inactive_Users.csv -notypeinformation
