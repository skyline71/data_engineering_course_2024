import yaml
import json
import pandas as pd

import sys
sys.path.append('..')


class FileReader:
    __yaml_output: list
    __json_output: list
    __csv_output: pd.DataFrame

    def __init__(self):
        pd.set_option('display.max_columns', None)
        pd.set_option('display.max_rows', None)
        pd.set_option('display.width', 2000)

    def read_yaml(self, file: str):
        try:
            with open(file, 'r') as f:
                self.__yaml_output = yaml.load(f, Loader=yaml.FullLoader)
            return self.__yaml_output
        except Exception as e:
            print(f'File {file} not found ({e})')
            return None

    def read_json(self, file: str):
        try:
            with open(file, 'r') as f:
                self.__json_output = json.load(f)
            return self.__json_output
        except Exception as e:
            print(f'File {file} not found ({e})')
            return None

    def read_csv(self, file: str):
        try:
            self.__csv_output = pd.read_csv(file)
            return self.__csv_output
        except Exception as e:
            print(f'File {file} not found ({e})')
            return None
