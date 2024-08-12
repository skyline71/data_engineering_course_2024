# Lesson 3: Conditional operator

# Task 1
a = 5
b = 10
if a > b:
    print('a > b')
elif a == b:
    print('a == b')
else:
    print('a < b')

# Task 2
if a > 0:
    a *= 10
else:
    a /= 10
print(a)

# Task 3
a = 19
if a % 2 == 0:
    a /= 2
else:
    a *= 3
print(a)

# Task 4
if a > 10:
    if a % 3 == 0:
        print('pass')

# Task 5
x = 4
y = 6
if type(x) is int and type(y) is int:
    print(x + y)

# Task 6
l = [1,3,5,7,9]
x = int(input('input number: '))
if x in l:
    print(x, 'exists in list', l)
else:
    print(x, 'doesnt exist in', l)
