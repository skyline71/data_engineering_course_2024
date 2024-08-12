# Lesson 2: Collections, dictionaries

from random import randint

# Task 1
l1 = [1, 2, 3]
l2 = [9, 8, 7]
l3 = l1 + l2
l3 = l3 * 2
l3.sort()
l3 = list(set(l3))
print(l3)
print('')

# Task 2
d1 = dict()
for i in range(len(l3)):
    d1['Item ' + str(i)] = i
print(d1)

d2 = dict()
for i in range(len(l1)):
    d2['Item ' + str(i)] = list([randint(1, 10) for _ in range(3)])
print(d2)

d3 = dict()
for i in range(len(l1)):
    d3['Item ' + str(i)] = dict(d2)
print(d3)

# Task 3
print('')
print(d1.get('Item 1'))
print(d2.get('Item 0'))
print(d3.get('Item 2'))
print('')

# Task 4
print(d3.get('Item 0').get('Item 2'))
print('')

# Task 5
l1 = list(d1.keys())
l2 = list(d2.values())
print(l1, l2, sep='\n')
print('')

# Task 6
print(d2)
d2['Item 2'] = None
print(d2)