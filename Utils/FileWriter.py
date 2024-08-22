import yaml
import json
import pandas as pd

import sys
sys.path.append('..')


class FileWriter:
    __cities: list
    __df: pd.DataFrame

    def __init__(self, cities: list):
        self.__cities = cities
        self.__df = pd.DataFrame(self.__cities)

    def add_cities(self, cities: list):
        self.__cities.extend(cities)

    def write_yaml(self, file: str):
        try:
            with open(file, 'w') as f:
                yaml.dump(self.__cities, f)
        except Exception as e:
            print(f'File name should be string ({e})')
            return None

    def write_json(self, file: str):
        try:
            with open(file, 'w') as f:
                json_object = json.dumps(self.__cities)
                f.write(json_object)
        except Exception as e:
            print(f'File name should be string ({e})')
            return None

    def write_csv(self, file: str):
        try:
            self.__df.to_csv(file, index=False)
        except Exception as e:
            print(f'File name should be string ({e})')
            return None

    def sort_values(self, column: str):
        try:
            if type(column) is str:
                self.__df = self.__df.sort_values(column)
            else:
                raise ValueError
        except ValueError:
            print(f'Column name should be string')
            return None
        except Exception as e:
            print(f'Column {str(column)} does not exist ({e})')
            return None
