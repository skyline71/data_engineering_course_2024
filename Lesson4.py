# Lesson 4: Iterators

from random import randint

# Task 1
l1 = [_ for _ in range(5)]
for i in range(len(l1)):
    print(l1[i])
print('')

# Task 2
alph = 'qwertyuiopasdfghjklzxcvbnm'
l2 = [''.join([str(alph[randint(1, len(alph) - 1)]) for _ in range(randint(1, 30))]) for i in range(5)]
for i in range(len(l2)):
    if len(l2[i]) > 5:
        print(f'{l2[i]} with len {len(l2[i])}')
print('')

# Task 3
l3 = [[randint(1, 10) for _ in range(5)] for _ in range(5)]
print(l3)
for i in range(len(l3)):
    for j in range(len(l3[i])):
        print(f'l3[{i}][{j}] = {l3[i][j]}', end='\t')
    print('')
print('')

# Task 4
keys = [f'key {_}' for _ in range(5)]
vals = [randint(1, 10) for _ in range(5)]
d = {}
for i in range(5):
    d[keys[i]] = vals[i]
print(d)
for key in d.keys():
    print(f'dict d val = {d.get(key)} by key {key}')

# Task 5
for _ in range(1, 101):
    print(_)
i = 1
while i < 101:
    print(i)
    i += 1
print('')

# Task 6
d1 = {'key 1': 1, 'key 2': 2, 'key 3': 3}
d2 = {'key 9': 4, 'key 8': 5, 'key 7': 6}
d3 = {}
tmp = d1.copy()
keys = list(reversed([d1.popitem()[0] for _ in range(3)]))
d1 = tmp
i = 0
for x in d2:
    d3[x] = f'{d2[x]} + {d1[keys[i]]}'
    i += 1
print(d3)
