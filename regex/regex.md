# The regex patterns

## [Bash] Email addresses
```sh
grep -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b" FILE | awk '{print $1}' | sort | uniq
```

## Tools
- https://www.autoregex.xyz/
