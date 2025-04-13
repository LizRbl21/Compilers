import subprocess

def ejecutar_lexer(archivo):
    proceso = subprocess.run(["./lexer_avanzado.exe"], input=open(archivo, "rb").read(), capture_output=True, text=True)
    tokens = proceso.stdout.splitlines()
    
    conteo = {
        "KEYWORD": 0,
        "ID": 0,
        "NUMBER": 0,
        "OPERATOR": 0,
        "DELIMITER": 0
    }
    
    for token in tokens:
        tipo = token.split()[0]
        if tipo in conteo:
            conteo[tipo] += 1
    
    print("Conteo de tokens:")
    for tipo, cantidad in conteo.items():
        print(f"{tipo}: {cantidad}")

# Ejecutar el análisis
ejecutar_lexer("input.txt")
