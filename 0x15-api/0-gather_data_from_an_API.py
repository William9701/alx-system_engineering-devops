#!/usr/bin/python3
""" this module is for api"""
import requests
import sys

if len(sys.argv) != 2:
    print("Usage: python script.py <employee_id>")
    sys.exit(1)

u_id = int(sys.argv[1])
EMPLOYEE_NAME = ''
response = requests.get('https://jsonplaceholder.typicode.com/users')
for loop_1 in response.json():
    if loop_1['id'] == u_id:
        EMPLOYEE_NAME = (loop_1['name'])
        break

feedback = requests.get('https://jsonplaceholder.typicode.com/todos')
count = 0
for loop_1 in feedback.json():
    if loop_1['userId'] == u_id and loop_1['completed'] is False:
        count += 1

count_2 = 0
for loop_1 in feedback.json():
    if loop_1['userId'] == u_id and loop_1['completed'] is True:
        count_2 += 1

print(f'Employee {EMPLOYEE_NAME} is done with tasks('
      f'{count_2}/{count + count_2}):')
for loop_1 in feedback.json():
    if loop_1['userId'] == u_id and loop_1['completed'] is True:
        print('\t' + loop_1["title"])
