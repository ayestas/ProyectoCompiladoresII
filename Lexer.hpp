#ifndef __LEXER_HPP__
#define __LEXER_HPP__

#include <string>
#include <iosfwd>
#include "ParserImpl.hpp"

enum class Token: int 
{
    Eof = 0,
    Error = 256,
    Undef = 257,
    //BLOQUES
    Eol = 258,
    Inicio = 259,
    Fin = 260,
    //DECLARACIONES
    Escriba = 261,
    De = 262,
    Funcion = 263,
    Procedimiento = 264,
    Final = 265,
    Llamar = 266,
    Lea = 267,
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
    //CICLOS
    Para = 283,
    Mientras = 284,
    Haga = 285,
    Repita = 286,
    Hasta = 287,
    Caso = 288,
    //COMPARACION
    O = 289,
    Y = 290,
    No = 291,
    Mayor = 292,
    Menor = 293,
    Igual = 294,
    NoIgual = 295,
    MayorIgual = 296,
    MenorIgual = 297,
    Diferente = 298,
    //TIPOS DE DATOS
    Variable = 299,
    Entero = 300,
    Real = 301,
    Caracter = 302,
    Cadena = 303,
    Booleano = 304,
    Arreglo = 305,
    Tipo = 306,
    //DATOS
    Letras = 307,
    Decimal = 308,
    Binario = 309,
    Hexadecimal = 310,
    Verdadero = 311,
    Falso = 312,
    Letra = 313,
    Numero = 314,
    //SIMBOLOS
    Asignar = 315,
    Coma = 316,
    ParAbierto = 317,
    ParCerrado = 318,
    BrackAbierto = 319,
    BrackCerrado = 320,
    DosPuntos = 321,
    SignoIgual = 322,
    PuntoComa = 323,
    //OPERANDOS
    Suma = 324,
    Resta = 325,
    Multiplicacion = 326,
    Division = 327,
    Mod = 328,
    Div = 329,
    Var = 330,
};

class Lexer
{
public:
    using yyscan_t = void*;

public:
    Lexer(std::istream& _in, std::ostream& _out);
    ~Lexer();

    Token nextToken(ParserValueType *lval)
    { return nextTokenHelper(yyscanner, lval); }

    std::string text() const;

    long line() const;

    static const char *tokenString(Token tk);

private:
    Token nextTokenHelper(yyscan_t yyscanner, ParserValueType *lval);

private:
    std::istream& in;
    std::ostream& out;
    yyscan_t yyscanner;

};

#endif