import ply.lex as lex

# Lista de tokens
tokens = (
    'KEYWORD', 'IDENTIFIER', 'NUMBER', 'OPERATOR', 'DELIMITER'
)

# Definición de palabras clave
keywords = {'if', 'else', 'while', 'return', 'int', 'float', 'char', 'void', 'for'}

# Expresiones regulares para tokens
t_KEYWORD = r'if|else|while|return|int|float|char|void|for'
t_IDENTIFIER = r'[a-zA-Z_][a-zA-Z0-9_]*'
t_NUMBER = r'\d+(\.\d+)?'
t_OPERATOR = r'[+\-*/=<>!]'
t_DELIMITER = r'[(){};,]'

def t_newline(t):
    r'\n+'
    t.lexer.lineno += len(t.value)

t_ignore = ' \t'

def t_error(t):
    print(f"Illegal character '{t.value[0]}' at line {t.lineno}")
    t.lexer.skip(1)

# Construcción del analizador léxico
lexer = lex.lex()

def analyze_file(filename):
    with open(filename, 'r') as f:
        data = f.read()
    lexer.input(data)
    
    counts = {"KEYWORD": 0, "IDENTIFIER": 0, "NUMBER": 0, "OPERATOR": 0, "DELIMITER": 0}
    
    for token in lexer:
        if token.type in counts:
            counts[token.type] += 1
    
    print("Token counts:")
    for token_type, count in counts.items():
        print(f"{token_type}: {count}")

# Prueba con un archivo de código fuente
if __name__ == "__main__":
    filename = input("Enter the filename: ")
    analyze_file(filename)
