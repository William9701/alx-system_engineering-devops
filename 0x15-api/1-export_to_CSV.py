#!/usr/bin/python3
""" this module is for api"""
import csv
import requests
import sys

if len(sys.argv) != 2:
    print("Usage: python script.py <employee_id>")
    sys.exit(1)

u_id = int(sys.argv[1])
USERNAME = ''
response = requests.get('https://jsonplaceholder.typicode.com/users')
for loop_1 in response.json():
    if loop_1['id'] == u_id:
        USERNAME = (loop_1['username'])
        break

feedback = requests.get('https://jsonplaceholder.typicode.com/todos')

with open(f'{u_id}.csv', 'w', newline='') as csv_file:
    fieldnames = ['USER_ID', 'USERNAME', 'TASK_COMPLETED_STATUS', 'TASK_TITLE']
    writer = csv.DictWriter(csv_file, fieldnames=fieldnames)
    writer = csv.DictWriter(csv_file, fieldnames=fieldnames, quotechar='"',
                            quoting=csv.QUOTE_ALL)

    for todo in feedback.json():
        if todo['userId'] == u_id:
            writer.writerow({
                'USER_ID': int(todo['userId']),
                'USERNAME': USERNAME,
                'TASK_COMPLETED_STATUS': todo['completed'],
                'TASK_TITLE': todo['title']
            })
