%define parse.error verbose
%define api.pure full

%parse-param {Lexer& lexer}
%parse-param {int& value}

%code top {
#include <iostream>
#include <stdexcept>
#include "LexerImpl.hpp"
#include "Lexer.hpp"

#define yylex(v) static_cast<int>(lexer.nextToken(v))

void yyerror(const Lexer& lexer, int& value, const char *msg)
{
    throw std::runtime_error(msg);
}

}

%code requires {
#include "Lexer.hpp"
}

%token Inicio           "Inicio"
%token Fin              "Fin"

%token De               "De"
%token Funcion          "Funcion"
%token Procedimiento    "Procedimiento"
%token Variable         "var"
%token Final            "Final"
%token Llamar           "Llamar"
%token Lea              "Lea"
%token Escriba          "Escriba"
%token Retorne          "retorne"
%token Es               "es"
%token Registro         "Registro"
%token Archivo          "Archivo"
%token Secuencial       "Secuencial"
%token Abrir            "abrir"
%token Como             "como"
%token Lectura          "Lectura"
%token Escritura        "Escritura"
%token Cerrar           "Cerrar"
%token Leer             "Leer"
%token Escribir         "Escribir"

%token Si               "Si"
%token Entonces         "entonces"
%token Sino             "Sino"
%token FinSi            "FinSi"

%token Para             "Para"
%token Mientras         "Mientras"
%token Haga             "Haga"
%token Repita           "Repita"
%token Hasta            "Hasta"
%token Caso             "caso"

%token Y                "y"
%token O                "o"
%token No               "no"
%token Mayor            "Mayor"
%token Menor            "Menor"

%token Entero           "Entero"
%token Real             "Real"
%token Cadena           "Cadena"
%token Booleano         "Booleano"
%token Caracter         "Caracter"
%token Arreglo          "Arreglo"
%token Tipo             "Tipo"

%token Letras           "letras"
%token Decimal          "dec"
%token Binario          "bin"
%token Hexadecimal      "hex"
%token Verdadero        "verdadero"
%token Falso            "falso"
%token Letra            "letra"
%token Digito           "digito"

%token Asignar          "<-"
%token Coma             ","
%token ParAbierto       "("
%token ParCerrado       ")"
%token BrackAbierto     "["
%token BrackCerrado     "]"
%token DosPuntos        ":"
%token Igual            "="

%token Suma             "+"
%token Resta            "-"
%token Multiplicacion   "*"
%token Division         "/"
%token Div              "div"
%token Mod              "mod"

%%

programa: Inicio declaraciones Fin
        | declaraciones Inicio declaraciones Fin
        ;

declaraciones: declaraciones declaracion
             | declaracion
             ;

declaracion: tipo_declaracion lista_variables
           | asignacion
           | declaracion_escriba
           | condicional
           | definicion_funcion
;

definicion_funcion: Funcion encabezado_funcion Inicio declaraciones Retorne expr Fin
                | Funcion encabezado_funcion  declaracion Inicio declaraciones Retorne expr Fin
;

encabezado_funcion: Variable ParAbierto parametros_opt ParCerrado DosPuntos tipo_declaracion
                  ;

parametros_opt: parametros
              | /* empty */
              ;

parametros: parametros Coma parametro
          | parametro
          ;

parametro: tipo_declaracion Variable
         ;

tipo_declaracion: Entero
                | Real
                | Cadena
                | Booleano
                | Caracter
;

lista_variables: lista_variables Coma Variable
               | Variable
               ;

asignacion: Variable Asignar expr
          ;

declaracion_escriba: Escriba Variable
                    | Escriba Letras
                    | Escriba Letra
                   ;

condicional: Si sentencias_comparacion Entonces declaraciones clausulas_sino_opt FinSi
            | Si sentencias_comparacion Entonces Retorne expr clausulas_sino_opt
           ;

clausulas_sino_opt: /* empty */
                  | clausulas_sino Retorne expr
                  | clausulas_sino
                  ;

clausulas_sino: clausulas_sino Sino Si sentencias_comparacion Entonces declaraciones
              | clausulas_sino Sino Si sentencias_comparacion Entonces
              | Sino declaraciones
              | Sino
              ;

sentencias_comparacion: sentencia_comparacion
                    | sentencias_comparacion comparacion sentencia_comparacion

sentencia_comparacion: expr comparacion expr
                    | ParAbierto expr comparacion expr ParCerrado
                    ;

comparacion: Igual
           | Mayor
           | Menor
           | Y
           | O
           | No
           ;

expr: expr Suma term
    | expr Resta term
    | term
    ;

term: term Multiplicacion factor
    | term Division factor
    | factor
    ;

factor: Variable
      | Decimal
      | Letras
      | Letra
      | Verdadero
      | Falso
      | ParAbierto expr ParCerrado
      | llamada_funcion
      ;

llamada_funcion: Variable ParAbierto argumentos_opt ParCerrado
               ;

argumentos_opt: argumentos
              | /* empty */
              ;

argumentos: argumentos Coma expr
          | expr
          ;

%%