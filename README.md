# SystemScore

A scoring tool to present visually different health and security information from linux systems

This repository contains a bash script and a Python code for collecting and analyzing data from Linux systems. The bash script is used to collect data from a list of systems and store the data in a dataset. The Python code is used to analyze the dataset and generate scores for each system based on health and security metrics.

BASH SCRIPT

The bash script collect_data.sh is used to collect data from a list of Linux systems. The script prompts the user for their username and password for each system and uses SSH to connect to the system and collect data. The collected data includes system resources usage, number of processes, number of open ports, number of failed and successful login attempts, number of failed and successful ssh login attempts, root login attempts and system uptime. The collected data is stored in text files with names that include the name of the system.

To use the script, simply run it in a terminal and follow the prompts. The script will loop through the list of systems and prompt the user for their username and password for each system. The collected data will be stored in text files with names that include the name of the system.

PYTHON CODE

The Python code generate_scores.py is used to analyze the dataset generated by the bash script and generate scores for each system based on health and security metrics. The code reads the data from the text files generated by the bash script and calculates scores for each system based on the metrics.

The metrics used to calculate the scores include CPU usage, memory usage, number of processes, number of open ports, number of failed and successful login attempts, number of failed and successful ssh login attempts, root login attempts and system uptime. Each metric is assigned a weight based on its importance and the scores are calculated based on the weighted sum of the metrics.

To use the code, simply run it in a Python environment and follow the prompts. The code will read the data from the text files and generate scores for each system. The scores will be displayed in a table and a graphical gauge. The table will show the scores for each metric and the overall score for each system. The graphical gauge will show the overall score for each system in a visual manner.

FUNCTIONS

The bash script and Python code use the following functions:

sshpass - A command line tool used to securely connect to remote systems and execute commands. The tool is used in the bash script to connect to the systems and collect data.

os - A Python module used to access the operating system functionalities. The module is used in the Python code to read the data from the text files and generate scores for each system.

pandas - A Python library used for data manipulation and analysis. The library is used in the Python code to read the data from the text files and generate scores for each system.

matplotlib - A Python library used for data visualization. The library is used in the Python code to display the scores in a graphical gauge.