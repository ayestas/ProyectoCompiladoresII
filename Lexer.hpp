#ifndef __LEXER_HPP__
#define __LEXER_HPP__

#include <string>
#include <iosfwd>
#include <iostream>

enum class Token: int {
    Eof = 0,
    Error = 256,
    Undef = 257,
    //BLOQUES
    Inicio = 258,
    Fin = 259,
    //DECLARACIONES
    De = 260,
    Funcion = 261,
    Procedimiento = 262,
    Variable = 263,
    Final = 264,
    Llamar = 265,
    Lea = 266,
    Escriba = 267,
    Retorne = 268,
    Es = 269,
    Registro = 270,
    Archivo = 271,
    Secuencial = 272,
    Abrir = 273,
    Como = 274,
    Lectura = 275,
    Escritura = 276,
    Cerrar = 277,
    Leer = 278,
    Escribir = 279,
    //CONDICIONALES
    Si = 280,
    Entonces = 281,
    Sino = 282,
    FinSi = 283,
    //BUCLES
    Para = 284,
    Mientras = 285,
    Haga = 286,
    Repita = 287,
    Hasta = 288,
    Caso = 289,
    //COMPARACION
    O = 290,
    Y = 291,
    NO = 292,
    Mayor = 293,
    Menor = 294,
    //TIPOS DE DATOS
    Entero = 295,
    Real = 296,
    Cadena = 297,
    Booleano = 298,
    Caracter = 299,
    Arreglo = 300,
    Tipo = 301,
    //DATOS
    Letras = 302,
    Decimal = 303,
    Binario = 304,
    Hexadecimal = 305,
    Verdadero = 306,
    Falso = 307,
    Letra = 308,
    Digito = 309,
    //SIMBOLOS
    Asignar = 310,
    Coma = 311,
    ParAbierto = 312,
    ParCerrado = 313,
    BrackAbierto = 314,
    BrackCerrado = 315,
    DosPuntos = 316,
    Igual = 317,
    //OPERADORES
    Suma = 318,
    Resta = 319,
    Multiplicacion = 320,
    Division = 321,
    Div = 322,
    Mod = 323
};

class Lexer
{
public:
    using yyscan_t = void*;
    using BisonValueType = int;

public:
    Lexer(std::istream& _in);
    ~Lexer();

    Token nextToken(BisonValueType *lval)
    { return nextTokenHelper(yyscanner, lval); }

    std::string text() const;

    static const char *tokenString(Token tk);

private:    
    Token nextTokenHelper(yyscan_t yyscanner, BisonValueType *lval);

private:
    std::istream& in;
    yyscan_t yyscanner;

};

#endif