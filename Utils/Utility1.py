class Human:
    __name: str
    __age: int
    __location: str

    def __init__(self, name='Evgeniy Prigozhin', age=62):
        self.__name = name
        self.__age = age
        self.__location = 'Bahmut'

    def set_name(self, name: str):
        self.__name = name

    def set_age(self, age: int):
        self.__age = age

    def set_location(self, location: str):
        self.__location = location

    def get_name(self):
        return self.__name

    def get_age(self):
        return self.__age

    def get_location(self):
        return self.__location

    def get_info(self):
        return f'Name: {self.get_name()}, Age: {self.get_age()}, Location: {self.get_location()}'


class Roth:
    __soldiers: list
    __roth_name: str

    def __init__(self, roth_name: str, soldiers: list):
        self.__soldiers = soldiers
        self.__roth_name = roth_name

    def add_soldier(self, soldiers: list):
        try:
            self.__soldiers.extend(soldiers)
        except Exception as e:
            print(e)

    def remove_soldier(self, soldier):
        try:
            self.__soldiers.remove(soldier)
        except Exception as e:
            print(e)

    def set_new_location(self, new_location):
        for soldier in self.__soldiers:
            soldier.set_location(new_location)

    def set_roth_name(self, roth_name: str):
        self.__roth_name = roth_name

    def get_roth_name(self):
        return self.__roth_name

    def get_soldiers_list(self):
        return self.__soldiers

    def print_roth(self):
        for soldier in self.__soldiers:
            print(soldier.get_info())


class Regiment:
    __roths: list

    def __init__(self, roths: list):
        self.__roths = roths

    def add_roth(self, roths: list):
        try:
            self.__roths.extend(roths)
        except Exception as e:
            print(e)

    def remove_soldier(self, roth, soldier):
        try:
            roth.remove_soldier(soldier)
        except Exception as e:
            print(e)

    def get_roths_list(self):
        return self.__roths

    def print_regiment(self):
        for roth in self.__roths:
            print(f'{roth.get_roth_name()}:')
            roth.print_roth()
            print('')
