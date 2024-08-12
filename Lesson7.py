# Lesson 7: Public, private access

class Human:
    def __init__(self, name='Human', age=18, sex='M'):
        self.__name = name
        self.__age = age
        self.__sex = sex

    def set_name(self, name: str):
        self.__name = name

    def set_age(self, age: int):
        self.__age = age

    def set_sex(self, sex: str):
        self.__sex = sex

    def get_name(self):
        return self.__name

    def get_age(self):
        return self.__age

    def get_sex(self):
        return self.__sex

    def get_info(self):
        return f'Person Name: {self.get_name()}, Age: {self.get_age()}, Sex: {self.get_sex()}'


class Child(Human):
    def __init__(self, name='Child', age=7, sex='M', habit='Study'):
        super().__init__(name, age, sex)
        self.__habit = habit

    def set_habit(self, habit: str):
        self.__habit = habit

    def get_habit(self):
        return self.__habit

    def get_info(self):
        info = super().get_info()
        return f'{info}, habit: {self.__habit}'

# Task 1
person1 = Human('Oleg', 18, 'M')
print(person1.get_info())
person1.set_age(20)
person1.set_name('Vasya')
print(person1.get_info())
print('')

# Task 2
person2 = Child('Sasha', 10, 'F')
print(person2.get_info())
person2.set_habit('Volley')
print(person2.get_info())
print('')

class Bus:
    def __init__(self, persons: list):
        self.__persons = persons
        self.__coords = {}

        self.__set_coords()

    def __set_coords(self):
        for person in self.__persons:
            self.__coords[person] = [0, 0]

    def add_person(self, person: str):
        self.__persons.append(person)

    def remove_person(self, person: str):
        self.__persons.remove(person)

    def get_persons(self):
        for person in self.__persons:
            print(f'Person: {person}, Place: {self.__coords[person]}', end='\n')

    def change_coords(self, person, x, y):
        if person not in self.__persons:
            print(f'Person {person} doesnt exist')
        else:
            self.__coords[person] = [x, y]

    def change_all(self, x, y):
        for p in self.__persons:
            self.__coords[p] = [x, y]



# Task 3
bus1 = Bus(['person1', 'person2', 'person3'])
bus1.get_persons()
print('')

# Task 4
bus1.change_coords('person1', 5, 3)
bus1.change_coords('person2', 3, 2)
bus1.change_coords('person3', 1, 5)
bus1.change_coords('person4', 2, 2)
bus1.get_persons()
print('')
bus1.change_all(1, 1)
bus1.get_persons()

