'''
Aceptar varias palabras por teclado hasta un símbolo de final (“-1”, “end”, etc.). 

Usando las funciones siguientes el programa imprimirá la frase compuesta por todas las palabras con la primera letra en mayúscula. 

Además imprimirá cuántas veces aparece en la frase cada una de las vocales.

Hacer las siguientes funciones

-Concatena dos cadenas, separando las palabras por un espacio en blanco y devuelve la cadena concatenada.
-Acepta una cadena y un carácter y devuelve el número de veces que el carácter aparece en la cadena. Si no se incluye carácter devuelve 0.
-Acepta una cadena y convierte la primera letra en mayúscula.
'''
x=''
inn=''
t=('a','e','i','o','u')

while (inn!='EOF'):
    inn=str(input('Introduce la siguiente palabra (EOF para dejar de introducir palabras):'))
    x+=inn.title()+' 'if inn!='EOF'else ''

print(x)

