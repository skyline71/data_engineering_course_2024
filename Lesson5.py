# Lesson 5: Functions

# Task 1
def f1():
    print(f'hello, its {f1.__name__}\n')
f1()

# Task 2
def f2(x):
    print(f'hello, its {f1.__name__} and var {x}\n', end='')
f2(3)
print('')

# Task 3
def f3(x, y, z):
    print(f'hello, its {f1.__name__} and vars {x, y, z}\n')
f3(10, 5 , 26)

# Task 4
def f4(x, y, z=0):
    print(f'hello, its {f1.__name__} and vars {x, y, z}\n')
f4(10, 5)

# Task 5
for i in range(3):
    f2(i)
print('')

# Task 6
def f5(x: list):
    return sum(x)
print(f5([1,2,3,4,5]))
print('')

# Task 7
def f6(x: list):
    print(f5(x))
f6([100,24,5])
print('')

# Task 8
def bubble_sort(list):
    for i in range(len(list)):
        for j in range(i, len(list) - 1):
            if list[i] > list[j]:
                tmp = list[i]
                list[i] = list[j]
                list[j] = tmp
    return list
print(bubble_sort([5,3,6,1,7,3,8,9,3,2,93]))


