# Lesson 8: Exceptions

import datetime

# Task 3 from Lesson 7
class Human:
    __name: str
    __location: str

    def __init__(self, name='Ivan'):
        self.__name = name
        self.__location = 'Moscow'

    def set_name(self, name: str):
        self.__name = name

    def set_location(self, location: str):
        self.__location = location

    def get_name(self):
        return self.__name

    def get_location(self):
        return self.__location

    def get_info(self):
        return f'Name: {self.get_name()}, Location: {self.get_location()}'


class Child(Human):
    __age: int

    def __init__(self, name='Ivan', age=7):
        super().__init__(name)
        self.__age = age

    def set_age(self, age):
        self.__age = age

    def get_age(self):
        return self.__age

    def get_info(self):
        return f'Name: {self.get_name()}, Age: {self.get_age()}, Location: {self.get_location()}'


class Bus:
    __children: list

    def __init__(self, children: list):
        self.__children = children

    def add_children(self, children: list):
        self.__children.extend(children)

    def remove_children(self, children: list):
        for child in children:
            if child in self.__children:
                self.__children.remove(child)
            else:
                print(f'Child {child.get_name()} doesnt exist')

    def set_new_location(self, new_location):
        for child in self.__children:
            child.set_location(new_location)

    def print_all_children_locations(self):
        for child in self.__children:
            print(f'Child Name: {child.get_name()}, Location: {child.get_location()}')


child1 = Child('Kolyan')
child2 = Child('Antoha')
child3 = Child('Vovan')

bus = Bus([child1, child2])
bus.print_all_children_locations()
print('')

bus.add_children([child3])
bus.print_all_children_locations()
print('')

bus.set_new_location('Perm')
bus.print_all_children_locations()
print('')

# Task 1
class MilitirizedHuman:
    __name: str
    __age: int
    __location: str

    def __init__(self, name='Evgeniy Prigozhin', age=62, dob=datetime.datetime.now(datetime.UTC)):
        self.__name = name
        self.__age = age
        self.__location = 'Bahmut'
        self.__dob = dob

    def set_name(self, name: str):
        self.__name = name

    def set_age(self, age: int):
        self.__age = age

    def set_location(self, location: str):
        self.__location = location

    def set_dob(self, dob):
        self.__dob = dob

    def get_name(self):
        return self.__name

    def get_age(self):
        return self.__age

    def get_location(self):
        return self.__location

    def get_dob(self):
        return self.__dob

    def get_info(self):
        return (f'Name: {self.get_name()}, Age: {self.get_age()}, Date of birth: {self.get_dob()}, '
                f'Location: {self.get_location()}')


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


meat1 = MilitirizedHuman()
meat2 = MilitirizedHuman('Stas', 34)
meat3 = MilitirizedHuman('Volodimir', 46)
meat4 = MilitirizedHuman('Peter', 58)
meat5 = MilitirizedHuman('Joe', 81)
meat6 = MilitirizedHuman('Vadim', 61)
meat1.set_dob(datetime.date(1961, 6, 1))
meat2.set_dob(datetime.date(1989, 10, 14))
meat3.set_dob(datetime.date(1978, 1, 25))
meat4.set_dob(datetime.date(1965, 9, 26))
meat5.set_dob(datetime.date(1942, 11, 20))
meat6.set_dob(datetime.date(1963, 5, 30))

roth1 = Roth('Azov stal', [meat1, meat2, meat3])
roth2 = Roth('Russian piece', [meat4, meat5, meat6])

regiment = Regiment([roth1, roth2])
regiment.print_regiment()

# Task 2
roth2.remove_soldier(meat2) # Exception
print('')
roth1.remove_soldier(meat2)
regiment.print_regiment()

regiment.remove_soldier(roth1, meat5) # Exception
print('')
regiment.remove_soldier(roth2, meat5)
regiment.print_regiment()
