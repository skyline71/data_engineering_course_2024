# Lesson 11: YAML, JSON, CSV data formats

import yaml
import json
import pandas as pd
import sys
sys.path.append('..')


class Schedule:
    __schedule: list
    __yaml_output: list
    __json_output: list
    __csv_output: pd.DataFrame

    def __init__(self):
        self.__schedule = [
            {'teacher_name': 'Ivan', 'lesson': 'Java', 'classroom': 409, 'day': 'Monday'},
            {'teacher_name': 'Eugene', 'lesson': 'Big Data', 'classroom': 101, 'day': 'Tuesday'},
            {'teacher_name': 'Mark', 'lesson': 'Business Analysis', 'classroom': 421, 'day': 'Wednesday'},
            {'teacher_name': 'John', 'lesson': 'Math', 'classroom': 203, 'day': 'Thursday'},
            {'teacher_name': 'Alexey', 'lesson': 'Machine Learning', 'classroom': 404, 'day': 'Friday'},
            {'teacher_name': 'Sam', 'lesson': 'QA Engineering', 'classroom': 310, 'day': 'Saturday'}
        ]

    def write_yaml(self, file: str):
        try:
            with open(file, 'w') as f:
                yaml.dump(self.__schedule, f)
        except Exception as e:
            print(f'File name should be string ({e})')

    def read_yaml(self, file: str):
        try:
            with open(file, 'r') as f:
                self.__yaml_output = yaml.load(f, Loader=yaml.FullLoader)
            return self.__yaml_output
        except FileNotFoundError:
            print(f'File {file} not found')
            return None

    def print_yaml_output(self):
        for day in self.__yaml_output:
            print(day)

    def write_json(self, file: str):
        try:
            with open(file, 'w') as f:
                json_object = json.dumps(self.__schedule, indent=4)
                f.write(json_object)
        except Exception as e:
            print(f'File name should be string ({e})')

    def read_json(self, file: str):
        try:
            with open(file, 'r') as f:
                self.__json_output = json.load(f)
            return self.__json_output
        except FileNotFoundError:
            print(f'File {file} not found')
            return None

    def print_json_output(self):
        for day in self.__json_output:
            print(day)

    def write_csv(self, file: str):
        try:
            df = pd.DataFrame(self.__schedule)
            df.to_csv(file, index=False)
        except Exception as e:
            print(f'File name should be string ({e})')

    def read_csv(self, file: str):
        try:
            self.__csv_output = pd.read_csv(file)
            return self.__csv_output
        except FileNotFoundError:
            print(f'File {file} not found')
            return None

    def print_csv_output(self):
        print(self.__csv_output)

    def __str__(self):
        return str(self.__schedule)


# Task 1
schedule = Schedule()
print('Task 1:')
print(schedule)
print('')

# Task 2
print('Task 2:')
schedule.write_yaml('config/yaml_data.yaml')
schedule.read_yaml('config/yaml_data.yaml')
schedule.print_yaml_output()
print('')

# Task 3
print('Task 3:')
schedule.write_json('Utils/json_data.json')
schedule.read_json('Utils/json_data.json')
schedule.print_json_output()
print('')

# Task 4
print('Task 4:')
schedule.write_csv('Utils/csv_data.csv')
schedule.read_csv('Utils/csv_data.csv')
schedule.print_csv_output()
print('')

# Task 5
print('Task 5:')
yaml_data = schedule.read_yaml('config/yaml_data.yaml')
schedule.write_json('Utils/yaml_to_json_data.json')
schedule.read_json('Utils/yaml_to_json_data.json')
schedule.print_json_output()
print('')

# Task 6
print('Task 6:')
json_data = schedule.read_json('Utils/json_data.json')
schedule.write_yaml('config/json_to_yaml_data.yaml')
schedule.read_yaml('config/json_to_yaml_data.yaml')
schedule.print_yaml_output()
print('')

# Exceptions
print('Exceptions:')
schedule.write_yaml(123)
schedule.write_json(345)
schedule.write_csv(777)
schedule.read_yaml('yaml_data.yaml')
schedule.read_json('json_data.json')
schedule.read_csv('csv_data.csv')
