# Monitoring

## Check that the hosts are available
```ps1
$hosts = Get-Content "hosts.txt"
foreach ($name in $hosts){
    if (Test-Connection -ComputerName $name -Count 1 -ErrorAction SilentlyContinue){
        Write-Host "$name, up"
    }
        else {
        Write-Host "$name, down"
    }
}
```
