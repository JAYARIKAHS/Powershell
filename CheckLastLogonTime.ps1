# ------------------------------------------
# GET LAST LOGON TIME FROM LIST OF USERNAMES
# ------------------------------------------
# <file_name>.txt should contain AD User IDs on each line

$USERS = Get-Content "C:\Temp\<file_name>.txt"
 
foreach ($USER in $USERS)
{
	$GETUSER = Get-ADUser -Identity $USER -Properties "lastLogonTimestamp"
	$LASTLOGON = [DateTime]::FromFileTime($GETUSER.lastLogonTimestamp)
	$GETUSER | Select-Object Name, @{name="LastLogon";expression={$LASTLOGON}}
}



# ----------------------------------------------
# GET LAST LOGON TIME FROM LIST OF DISPLAY NAMES
# ----------------------------------------------
# <file_name>.txt should contain name of users on each line

$USERS = Get-Content "C:\Temp\<file_name>.txt"
 
foreach ($USER in $USERS)
{
	$GETUSER = Get-ADUser -Filter {Name -like $name} -Properties "lastLogonTimestamp"
	$LASTLOGON = [DateTime]::FromFileTime($GETUSER.lastLogonTimestamp)
	$GETUSER | Select-Object Name, @{name="LastLogon";expression={$LASTLOGON}}
}
