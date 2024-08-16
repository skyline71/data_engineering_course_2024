from config.global_config import WEATHER_API_KEY
import requests
import pandas as pd


class RequestHandler:
    __url: str
    __api_key: str
    __request: str
    __results: list

    def __init__(self):
        self.__url = 'http://api.weatherapi.com/v1'
        self.__api_key = WEATHER_API_KEY
        self.__results = []

    def send_get_request(self, cities: list, days: int):
        for city in cities:
            self.__request = (f'http://api.weatherapi.com/v1/forecast.json?key={self.__api_key}'
                              f'&q={city}&days={days}')
            r = requests.get(url=self.__request)
            result = r.json()
            self.__results.append(
                {
                    'city': result.get('location').get('name'),
                    'country': result.get('location').get('country'),
                    'localtime': result.get('location').get('localtime'),
                    'current_temp_c': result.get('current').get('temp_c'),
                    'forecast_date': pd.to_datetime(
                                     result.get('forecast').get('forecastday')[days - 1].get('date')).date(),
                    'forecast_temp_c': result.get('forecast').get('forecastday')[days - 1].get('day').get('avgtemp_c')
                }
            )

    def get_results_list(self):
        return self.__results
