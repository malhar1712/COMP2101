#sysinfo.sh script to show some system information

#script command to get FQDN 
echo FQDN:
hostname -f

#script command to get OperatingSystem
echo System INFO:
hostnamectl| grep System

#script command to get IP Address
echo IP Address:
hostname -i

#script command to get avilable space in root file system
echo Availabe space:
df -h | grep File
df -h | grep /dev/sda3

