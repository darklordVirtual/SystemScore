#!/bin/bash
# This is a interactive Bash script that can be used to gather data into the dataset from a list of systems
# so we can generate a dataset to evaluate the values in different ways.
# Set up the header for the dataset
echo "CPU Usage,Memory Usage,Disk Usage,Network Usage,Processes,Open Ports,Failed Login Attempts,Successful Login Attempts,Failed SSH Attempts,Successful SSH Attempts,Root Login Attempts,System Uptime,Label" > dataset.csv

# Prompt the user for the list of systems
echo "Enter the list of systems (separated by spaces):"
read systems

# Prompt the user for the number of records to collect from each system
echo "Enter the number of records to collect from each system:"
read num_records

# Loop through each system and collect data for the specified number of records
for system in $systems; do
  for (( i=1; i<=$num_records; i++ )); do
    # Collect the data from the system using SSH
    data=$(ssh $system "echo \$(awk '{printf(\"%.1f,%.1f,%.1f,%.1f,%d,%d,%d,%d,%d,%d,%d,%d\", \$1, \$2, \$3, \$4, \$5, \$6, \$7, \$8, \$9, \$10, \$11, \$12)}' /proc/stat /proc/meminfo /proc/diskstats /proc/net/dev /proc/loadavg /var/log/auth.log /var/log/syslog | sed 's/ /,/g')")

    # Check if the SSH command was successful
    if [ $? -ne 0 ]; then
      echo "Error: Failed to collect data from $system"
      continue
    fi

    # Append the data to the dataset file
    echo "$data,1" >> dataset.csv

    # Display a progress message
    echo "Record $i collected from $system"
  done
done

# Display a completion message
echo "Data collection completed."
