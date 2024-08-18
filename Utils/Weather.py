class Weather:
    __cities: list

    def __init__(self):
        self.__cities = []

    def add_city(self, city_name: str):
        try:
            if type(city_name) is str:
                self.__cities.append(city_name)
            else:
                raise TypeError
        except TypeError:
            print('City name must be string')
            return None

    def remove_city(self, city_name: str):
        try:
            if type(city_name) is str:
                self.__cities.remove(city_name)
            else:
                raise TypeError
        except TypeError:
            print('City name must be string')
            return None

    def get_cities_list(self):
        return self.__cities

    def __str__(self):
        return str(self.__cities)
