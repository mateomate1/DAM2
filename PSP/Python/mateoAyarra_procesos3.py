'''
Realizar un programa que
Pide un texto por consola.
Si el texto es distinto de -1
Arranca 1 proceso (escritor) que añade el texto a un fichero y termina.
Cuando la escritura ha terminado lanza otro proceso (lector) que lee todo el fichero, lo saca en pantalla y termina.
Vuelve a pedir el texto y repite el ciclo hasta que el texto introducido ==  “-1”
 
El nombre del fichero lo pasará el padre a los hijos como parámetro.
 
Subir el archivo nombreApellido_procesos3.py
'''

def escritor(file, inn):
    with open(file, 'a') as w:
        w.write(inn)

def main():
    file = "mateoAyarra_procesos3.txt"
    valid = True
    while valid:
        inn = input('Introduce texto (-1 para salir):')
        



if __name__ == "__main__":
    main()