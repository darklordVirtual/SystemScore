#!/bin/bash
# A bash script to gather data with interactive menu for users to give login information
#
# Define the list of systems to collect data from
systems=("system1" "system2" "system3" "system4" "system5")

# Loop through each system and collect data
for system in "${systems[@]}"
do
    echo "Collecting data from $system"
    
    # Prompt the user for their username and password
    read -p "Enter your username for $system: " username
    read -s -p "Enter your password for $system: " password
    echo ""
    
    # Use SSH to connect to the system and collect data
    sshpass -p "$password" ssh "$username"@"$system" "top -b -n1 | awk '{print \$1,\$2,\$3,\$4,\$5,\$6,\$7,\$8,\$9,\$10,\$11,\$12}' > $system.txt"
    sshpass -p "$password" ssh "$username"@"$system" "ps aux | wc -l > $system-processes.txt"
    sshpass -p "$password" ssh "$username"@"$system" "sudo ss -lntp | grep LISTEN | wc -l > $system-ports.txt"
    sshpass -p "$password" ssh "$username"@"$system" "sudo grep 'Failed password' /var/log/auth.log | wc -l > $system-failed-login.txt"
    sshpass -p "$password" ssh "$username"@"$system" "sudo grep 'Accepted password' /var/log/auth.log | wc -l > $system-successful-login.txt"
    sshpass -p "$password" ssh "$username"@"$system" "sudo grep 'Failed password' /var/log/auth.log | grep sshd | wc -l > $system-failed-ssh.txt"
    sshpass -p "$password" ssh "$username"@"$system" "sudo grep 'Accepted publickey' /var/log/auth.log | grep sshd | wc -l > $system-successful-ssh.txt"
    sshpass -p "$password" ssh "$username"@"$system" "sudo grep 'Accepted password' /var/log/auth.log | grep root | wc -l > $system-root-login.txt"
    sshpass -p "$password" ssh "$username"@"$system" "uptime -s > $system-uptime.txt"
    
    echo "Data collected from $system"
done
