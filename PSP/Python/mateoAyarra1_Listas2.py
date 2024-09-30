#x = int(input('Dime las dimensiones:'))
x=3
m=[]
for i in range(x):
    m.append([])
    for j in range(x):
        if i==j:
            m[i].append(1)
        else:
            m[i].append(0)
for i in m:
    print(i)