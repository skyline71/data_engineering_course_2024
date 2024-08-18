# Lesson 13 API requests: GET, POST

from Utils.Weather import Weather
from Utils.FileWriter import FileWriter
from Utils.FileReader import FileReader
from Utils.RequestHandler import RequestHandler

import sys
sys.path.append('..')


class WeatherApp:
    __weather: Weather

    def __init__(self):
        pass

    def run(self):
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
        if request_handler.send_get_request(yaml_output, 7) is not None:
            request_results = request_handler.get_results_list()

            csv_writer = FileWriter(request_results)
            csv_writer.write_csv('Utils/weather_forecast.csv')
            csv_reader = FileReader()
            csv_output = csv_reader.read_csv('Utils/weather_forecast.csv')
            csv_output.to_excel('Utils/weather_forecast.xlsx')
            print(csv_output)
        else:
            print('Application interrupted (Incorrect input)')
            return None


if __name__ == '__main__':
    app = WeatherApp()
    app.run()
