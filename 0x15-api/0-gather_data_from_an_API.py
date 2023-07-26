#!/usr/bin/python3
"""
Script pulls up data from a webpage using API
"""

import requests
from sys import argv


def get_employee_todo_progress(employee_id):
    """
    This method functionality aggregates tasks performed by a given employee
    """

    base_url = "https://jsonplaceholder.typicode.com"
    user_url = f"{base_url}/users/{employee_id}"
    todos_url = f"{base_url}/todos?userId={employee_id}"

    try:
        user_response = requests.get(user_url)
        todos_response = requests.get(todos_url)

        if user_response.status_code == 200 and
        todos_response.status_code == 200:
            user_data = user_response.json()
            todos_data = todos_response.json()

            employee_name = user_data["name"]
            total_tasks = len(todos_data)
            completed_tasks = sum(1 for todo in todos_data
                                  if todo["completed"])
            print(f"Employee {employee_name} is done with tasks
                  ({completed_tasks}/{total_tasks}): ")
            for todo in todos_data:
                if todo["completed"]:
                    print(f"\t{todo['title']}")
        else:
            print("Error: Unable to fetch data. Please check the employee ID
                  and try again.")
    except requests.RequestException as e:
        print(f"Error: {e}")


if __name__ == "__main__":
    if len(argv) == 2:
        try:
            employee_id = int(argv[1])
            get_employee_todo_progress(employee_id)
        except ValueError:
            print("Error: Employee ID must be an integer.")
