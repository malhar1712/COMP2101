"#Network Adapter Information"

Get-CimInstance Win32_NetworkAdapterConfiguration |
Where-Object {$_.IPEnabled} |
Select-Object Description, Index, IPAddress, IPSubnet, DNSDomain, DNSServerSearchOrder |
Format-Table -AutoSize
