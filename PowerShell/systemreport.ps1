Param(

   [switch]$disks,
   [switch]$network,
   [switch]$system

)


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

function videocard {
"###summary of the VideoController##"
Get-WmiObject win32_videocontroller | Format-List name, description, videomodedescription
}
 

function adapter 
{

"###summary of the NetworkAdapter Configuration##"
Get-CimInstance Win32_NetworkAdapterConfiguration |
Where-Object {$_.IPEnabled} |
Select-Object Description, Index, IPAddress, IPSubnet, DNSDomain, DNSServerSearchOrder |
Format-Table -AutoSize
}




function d-drive 
{
"Physical drive summary"
return Get-CimInstance -Class Win32_PhysicalMemory | Select-Object -Property BankLabel, DeviceLocator, Manufacturer, Capacity
}

if ($system -eq $true)
{
operatingsystem
processor
ram
videocard
}

elseif ($network -eq $true)
{
adapter
}

elseif ($disks -eq $true)
{

d-drive
}

else
{
operatingsystem
processor
ram
videocard
adapter
d-drive
}
