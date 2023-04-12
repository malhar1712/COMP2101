# Lab 2 COMP2101 welcome script for profile
#

write-output "Welcome to planet $env:computername Overlord $env:username"
$now = get-date -format 'HH:MM tt on dddd'
write-output "It is $now."



"#CPU INFORMATION#"

function get-cpuinfo {
    $cpus = Get-CimInstance CIM_Processor
    $cpuinfo = foreach ($cpu in $cpus) {
        [PSCustomObject]@{
            Manufacturer = $cpu.Manufacturer
            Model = $cpu.Name
           }
    }
    
$cpuinfo | Format-Table 
}

get-cpuinfo

"#DISK INFORMATION#"
function get-mydisks {
    $disk = Get-PhysicalDisk | Select-Object Manufacturer, Model, SerialNumber, FirmwareRevision, Size
    $disk | Format-Table 
}
get-mydisks