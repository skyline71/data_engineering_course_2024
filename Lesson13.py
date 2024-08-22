# Lesson 13 API requests: GET, POST

from Utils.Weather import Weather
from Utils.FileWriter import FileWriter
from Utils.FileReader import FileReader
from Utils.RequestHandler import RequestHandler
from datetime import datetime

import sys
sys.path.append('..')


class WeatherApp:
    __weather: Weather

    def __init__(self):
        pass

    def run(self):
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
                date_str = date_now.strftime(format='%Y-%m-%d %H-%M-%S')
                csv_writer.write_csv(f'Utils/{str(date_str)}.csv')

                csv_reader = FileReader()
                csv_output = csv_reader.read_csv(f'Utils/{str(date_str)}.csv')
                # csv_output.to_excel('Utils/weather_forecast.xlsx')
                print(csv_output)
            else:
                raise ValueError
        except ValueError:
            print('Application interrupted (Incorrect input)')
            return None
        except Exception as e:
            print(f'Application interrupted ({e})')
            return None


if __name__ == '__main__':
    app = WeatherApp()
    app.run()
