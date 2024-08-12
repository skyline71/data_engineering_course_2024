# Lesson 6: Classes

class Human:
    def __init__(self, name='Human', age='18', sex='M'):
        self.name = name
        self.age = age
        self.sex = sex

    def get_name(self):
        return self.name

    def get_age(self):
        return self.age

    def get_sex(self):
        return self.sex

    def get_info(self):
        return f'Person Name: {self.get_name()}, Age: {self.get_age()}, Sex: {self.get_sex()}'


class Child(Human):
    def __init__(self, name='Child', age='7', sex='M', habit='Study'):
        super().__init__(name, age, sex)
        self.habit = habit

    def get_info(self):
        info = super().get_info()
        return f'{info}, habit: {self.habit}'

# Task 1
person1 = Human('Oleg', 18, 'M')
print(person1.get_info())
print('')

# Task 2
person2 = Child('Sasha', 10, 'F')
print(person2.get_info())
print('')

class Bus:
    def __init__(self, persons: list):
        self.persons = persons
        self.coords = {}

        self.__set_coords()

    def __set_coords(self):
        for person in self.persons:
            self.coords[person] = [0, 0]

    def add_person(self, person: str):
        self.persons.append(person)

    def remove_person(self, person: str):
        self.persons.remove(person)

    def get_persons(self):
        for person in self.persons:
            print(f'Person: {person}, Place: {self.coords[person]}', end='\n')

    def change_coords(self, person, x, y):
        if person not in self.persons:
            print(f'Person {person} doesnt exist')
        else:
            self.coords[person] = [x, y]

    def change_all(self, x, y):
        for p in self.persons:
            self.coords[p] = [x, y]



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

