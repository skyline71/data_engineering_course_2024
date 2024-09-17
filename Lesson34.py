# Lesson 34: SQLAlchemy ORM

import requests
import pandas as pd
from Utils.Weather import Weather
from Utils.FileWriter import FileWriter
from Utils.FileReader import FileReader
from Utils.RequestHandler import RequestHandler
from Utils.DatabaseSender import DatabaseSender
from datetime import datetime, timedelta
from config.global_config import CURRENCY_API_KEY, CURRENCY_API_URL

import sys
sys.path.append('..')


class CurrencyParser:
    __url = CURRENCY_API_URL
    __key = CURRENCY_API_KEY
    __currencies = 'USD,RUB,EUR'
    __rates = list()

    def __init__(self):
        pass

    def parse_csv(self):
        try:
            for i in range(31):
                currency_date = str(datetime.now().date() - timedelta(days=i))
                api_request = (f'{self.__url}?access_key={self.__key}&currencies={self.__currencies}&'
                               f'start_date={currency_date}&end_date={currency_date}')
                r = requests.get(url=api_request)
                result = r.json()
                if result.get('quotes') is not None:
                    self.__rates.append({
                        'date': currency_date,
                        'currency': 'RUB',
                        'rate_to_USD': result.get('quotes').get('USDRUB').get('start_rate')
                    })
                    self.__rates.append({
                        'date': currency_date,
                        'currency': 'EUR',
                        'rate_to_USD': result.get('quotes').get('USDEUR').get('start_rate')
                    })

            date_now = datetime.now().replace(microsecond=0)
            date_str = date_now.strftime(format='%Y-%m-%d %H-%M-%S')

            df = pd.DataFrame(self.__rates)
            df = df.sort_values('date')
            df.to_csv(f'Utils/C_{str(date_str)}.csv', index=False)

            data_output = pd.read_csv(f'Utils/C_{str(date_str)}.csv')
            print(data_output, end='\n')
            return data_output
        except Exception as e:
            print(f'Application interrupted ({e})')
            return None


class WeatherParser:
    __weather: Weather

    def __init__(self):
        pass

    def parse_csv(self):
        try:
            self.__weather = Weather()
            self.__weather.add_city('Lisbon')
            self.__weather.add_city('Chicago')
            self.__weather.add_city('Budapest')
            self.__weather.add_city('Stockholm')
            self.__weather.add_city('Tokyo')
            self.__weather.add_city('Moscow')
            self.__weather.add_city('Kazan')
            self.__weather.add_city('Omsk')
            cities = self.__weather.get_cities_list()

            yaml_writer = FileWriter(cities)
            yaml_writer.write_yaml('config/cities.yaml')
            yaml_reader = FileReader()
            yaml_output = yaml_reader.read_yaml('config/cities.yaml')

            request_handler = RequestHandler()
            if request_handler.send_get_request(yaml_output, 2) is not None:
                request_results = request_handler.get_results_list()
                csv_writer = FileWriter(request_results)
                csv_writer.sort_values('city')

                date_now = datetime.now().replace(microsecond=0)
                date_str = date_now.strftime(format='%Y-%m-%d_%H-%M-%S')
                csv_writer.write_csv(f'Utils/W_{str(date_str)}.csv')

                csv_reader = FileReader()
                csv_output = csv_reader.read_csv(f'Utils/W_{str(date_str)}.csv')
                print(csv_output, end='\n')
                return csv_output
            else:
                raise ValueError
        except ValueError:
            print('Application interrupted (Incorrect input)')
            return None
        except Exception as e:
            print(f'Application interrupted ({e})')
            return None


if __name__ == '__main__':
    app1 = CurrencyParser()
    app2 = WeatherParser()

    data1 = app1.parse_csv()
    data2 = app2.parse_csv()

    db_sender = DatabaseSender()

    db_sender.set_currency_data(data1)
    db_sender.set_weather_data(data2)
    db_sender.commit_currency_data()
    db_sender.commit_weather_data()
