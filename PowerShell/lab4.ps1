"###SystemReport for this PC###"

function hardware
{
"#system hardware description#"
Get-WmiObject -Class Win32_ComputerSystem | Select-Object Model, Manufacturer, SystemType, TotalPhysicalMemory
}

function operatingsystem 
{
 "##the operating system name and version number##"
Get-WmiObject -Class Win32_OperatingSystem | Select-Object Caption, Version
}


function processor  
{
"###processor description### "
Get-wmiObject -Class win32_Processor | format-table -property Name, MaxClockSpeed, NumberOfCores, L1CacheSize, L2CacheSize, L3CacheSize
}


function ram {
    $totalRam = 0
    $sysRam = Get-WmiObject win32_physicalmemory 
    
    foreach ($ram in $sysRam) {
        $ramSize = [int]($ram.Capacity / 1gb)
        $totalRam += $ramSize
        
        $ramInfo = [PSCustomObject]@{
            Vendor = $ram.Manufacturer
            Description = $ram.Description
            Size_GB = $ramSize
            BankLabel = $ram.BankLabel
            Slot = $ram.DeviceLocator
        }
        
        Write-Output $ramInfo
    }
    
    Write-Output "Total RAM (GB) = $totalRam"
}


function drive {
"Physical drive summary"
return Get-CimInstance -Class Win32_PhysicalMemory | Select-Object -Property BankLabel, DeviceLocator, Manufacturer, Capacity
}

function adapter 
{

"###summary of the NetworkAdapter Configuration##"
Get-CimInstance Win32_NetworkAdapterConfiguration |
Where-Object {$_.IPEnabled} |
Select-Object Description, Index, IPAddress, IPSubnet, DNSDomain, DNSServerSearchOrder |
Format-Table -AutoSize
}



function videoC {
"###summary of the VideoController##"
Get-WmiObject win32_videocontroller | Format-List name, description, videomodedescription
}


hardware
operatingsystem
processor
ram 
drive
adapter
videoC
