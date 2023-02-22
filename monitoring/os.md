# Monitoring

## [Windows] Check that the hosts are available
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

## Monitor system resources such as CPU usage, memory usage, disk usage, and network traffic
Python script for monitor system resources such as CPU usage, memory usage, disk usage, and network traffic. The script uses the [psutil](https://pypi.org/project/psutil/) python library.
```py
import psutil
import time

def bytes_to_megabytes(bytes):
    megabytes = bytes / (1024 * 1024)
    return megabytes

def monitor_resources():
    while True:
        cpu_usage = psutil.cpu_percent()
        memory_usage = psutil.virtual_memory().percent
        disk_usage = psutil.disk_usage('/').percent
        network_io_counters = psutil.net_io_counters()
        bytes_sent = bytes_to_megabytes(network_io_counters.bytes_sent)
        bytes_recv = bytes_to_megabytes(network_io_counters.bytes_recv)
        print(f"CPU usage: {cpu_usage}%")
        print(f"Memory usage: {memory_usage}%")
        print(f"Disk usage: {disk_usage}%")
        print(f"Network traffic: {bytes_sent:.2f} MB sent, {bytes_recv:.2f} MB received")
        time.sleep(5)

monitor_resources()
```
