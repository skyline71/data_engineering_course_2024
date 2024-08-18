from config.global_config import WEATHER_API_KEY, WEATHER_API_URL
import requests
import pandas as pd


class RequestHandler:
    __url: str
    __api_key: str
    __request: str
    __results: list

    def __init__(self):
        self.__url = WEATHER_API_URL
        self.__api_key = WEATHER_API_KEY
        self.__results = []

    def send_get_request(self, cities: list, days: int):
        try:
            if type(days) is int and days > 0:
                for day in range(0, days):
                    for city in cities:
                        self.__request = f'{str(self.__url)}?key={str(self.__api_key)}&q={str(city)}&days={str(days)}'
                        r = requests.get(url=self.__request)
                        result = r.json()
                        self.__results.append(
                            {
                                'city': result.get('location').get('name'),
                                'country': result.get('location').get('country'),
                                'localtime': result.get('location').get('localtime'),
                                'current_temp_c': result.get('current').get('temp_c'),
                                'forecast_date': pd.to_datetime(
                                    result.get('forecast').get('forecastday')[day].get('date')).date(),
                                'forecast_temp_c': result.get('forecast').get('forecastday')[day].get('day').get(
                                    'maxtemp_c'),
                                'wind_speed_kph': result.get('forecast').get('forecastday')[day].get('day').get(
                                    'maxwind_kph'),
                                'condition': result.get('forecast').get('forecastday')[day].get('day').get(
                                    'condition').get('text')
                            }
                        )
                return 1
            else:
                raise ValueError
        except ValueError:
            print(f'Days of forecasting must be integer and positive')
            return None
        except Exception as e:
            print(e)
            return None

    def get_results_list(self):
        return self.__results
