import yaml
import json
import pandas as pd


class FileWriter:
    __cities: list

    def __init__(self, cities: list):
        self.__cities = cities

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
            df = pd.DataFrame(self.__cities)
            df.to_csv(file, index=False)
        except Exception as e:
            print(f'File name should be string ({e})')
            return None
