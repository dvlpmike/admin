# Active Directory commands and scripts

## Add users to the ad group
The script looks through the collection of users ($Users) and adds them to the Active Directory group ($Group) if they are not already members of the group
```ps1
foreach ($User in $Users) {
    $UPN = $User.UserPrincipalName
    $ADUser = Get-ADUser -Filter "UserPrincipalName -eq '$UPN'" | Select-Object SamAccountName

    if ($ADUser -eq $null) {
        Write-Host "$UPN does not exist in AD" -ForegroundColor Red
    }
    else {
        $ExistingGroups = Get-ADPrincipalGroupMembership $ADUser.SamAccountName | Select-Object Name
        if ($ExistingGroups.Name -eq $Group) {
            Write-Host "$UPN already exists in $Group" -ForeGroundColor Yellow
        }
        else {
            # Add user to group
            Add-ADGroupMember -Identity $Group -Members $ADUser.SamAccountName -Credential $Cred
            Write-Host "Added $UPN to $Group" -ForeGroundColor Green
        }
    }
}
```
## Check the users from the file in the ad 
```ps1
$Users = Import-Csv ".\usr.txt"
foreach ($User in $Users) {
    $UPN = $User.UserPrincipalName
    $ADUser = Get-ADUser -Filter "UserPrincipalName -eq '$UPN'" | Select-Object SamAccountName, UserPrincipalName
    echo $ADUser 
}
```
