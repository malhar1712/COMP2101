Function PwshellLab1
{

echo hello world!

}

Function PwshellLab2
{

# Lab 2 COMP2101 welcome script for profile
#

write-output "Welcome to planet $env:computername Overlord $env:username"
$now = get-date -format 'HH:MM tt on dddd'
write-output "It is $now."



"#CPU INFORMATION#"

function cpuinformation {
    $cpus = Get-CimInstance CIM_Processor
    $cpuinfo = foreach ($cpu in $cpus) {
        [PSCustomObject]@{
            Manufacturer = $cpu.Manufacturer
            Model = $cpu.Name
            "Current Speed" = "{0:F2} GHz" -f ($cpu.CurrentClockSpeed / 1e3)
            "Max Speed" = "{0:F2} GHz" -f ($cpu.MaxClockSpeed / 1e3)
            Cores = $cpu.NumberOfCores
        }
    }
    
$cpuinfo | Format-Table 
}

cpuinformation

"#DISK INFORMATION#"
function disk {
    $disk = Get-PhysicalDisk | Select-Object Manufacturer, Model, SerialNumber, FirmwareRevision, MediaType, Size
    $disk | Format-Table 
}
get-disk


}

Function PwshellLab3
{

"#Network Adapter Information"

Get-CimInstance Win32_NetworkAdapterConfiguration |
Where-Object {$_.IPEnabled} |
Select-Object Description, Index, IPAddress, IPSubnet, DNSDomain, DNSServerSearchOrder |
Format-Table 

}

Function PwshellLab4
{




}