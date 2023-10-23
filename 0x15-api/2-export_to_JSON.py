#!/usr/bin/python3
""" this module is for api"""
import json
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
tasks = []
for todo in feedback.json():
    if todo['userId'] == u_id:
        tasks.append({
            'task': todo['title'],
            'completed': todo['completed'],
            'username': USERNAME
        })

with open(f'{u_id}.json', 'w') as json_file:
    json.dump({f'{u_id}': tasks}, json_file)
