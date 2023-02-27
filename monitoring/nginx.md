# Nginx logs (CLF format)

## [Python] Search diffrent IP addresses in log file
```py
import re

# Open the log file
with open('path/to/logfile', 'r') as log_file:
    log_contents = log_file.read()

# Regex to match an IP address
ip_pattern = r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}'

ip_addresses = re.findall(ip_pattern, log_contents)

# Remove duplicates
uniq_ip = list(set(ip_addresses))

# Print results
print(uniq_ip)
```
