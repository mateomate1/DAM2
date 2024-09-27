import random

numeros = []
maxnum = 0
media = 0
sublista1 = []
sublista2 = []

for i in range(20):
    numeros.append(random.randint(1,100))

numeros.sort()
maxnum=numeros[-1]
for i in range(numeros):
    media+=i
media/=len(numeros)
numeros.insert(5,'hola')

