import pandas as pd
from pygal.style import LightStyle
import pygal

#  This python code makes graphical gauges to the HTML result page to display the scores in a visual way
#
# Read the dataset
dataset = pd.read_csv('dataset.csv')

# Calculate the scores of every system
scores = []
for system in dataset['System'].unique():
    system_data = dataset.loc[dataset['System'] == system]
    cpu_score = (system_data['CPU Usage'].mean() / 100) * 100
    memory_score = (system_data['Memory Usage'].mean() / 8192) * 100
    disk_score = (system_data['Disk Usage'].mean() / 4096) * 100
    network_score = (system_data['Network Usage'].mean() / 1000) * 100
    process_score = (system_data['Processes'].mean() / 1000) * 100
    open_ports_score = (system_data['Open Ports'].mean() / 100) * 100
    failed_login_score = (system_data['Failed Login Attempts'].mean() / 10) * 100
    successful_login_score = (system_data['Successful Login Attempts'].mean() / 10) * 100
    failed_ssh_score = (system_data['Failed SSH Attempts'].mean() / 10) * 100
    successful_ssh_score = (system_data['Successful SSH Attempts'].mean() / 10) * 100
    root_login_score = (system_data['Root Login Attempts'].mean() / 10) * 100
    uptime_score = (system_data['System Uptime'].mean() / 3600) * 100
    score = (cpu_score + memory_score + disk_score + network_score + process_score + open_ports_score + failed_login_score + successful_login_score + failed_ssh_score + successful_ssh_score + root_login_score + uptime_score) / 12
    scores.append((system, score))

# Sort the scores in descending order
scores = sorted(scores, key=lambda x: x[1], reverse=True)

# Generate the HTML page with graphical gauges
html = "<html><body><h1>System Scores</h1>"
for score in scores:
    gauge = pygal.SolidGauge(inner_radius=0.70, style=LightStyle, show_legend=False)
    gauge.add('Score', [{'value': score[1], 'max_value': 100}])
    html += f"<h2>{score[0]}</h2>{gauge.render()}"
html += "</body></html>"

# Write the HTML page to a file
with open('scores.html', 'w') as f:
    f.write(html)
