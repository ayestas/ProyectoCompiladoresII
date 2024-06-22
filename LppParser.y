%define parse.error verbose
%define api.pure full

%parse-param {Parser& parser}

%code top {
#include <iostream>
#include <stdexcept>
#include "Lexer.hpp"
#include "Parser.hpp"

#define yylex(v) static_cast<int>(parser.getLexer().nextToken(v))

void yyerror(const Parser& parser, const char *msg)
{
    throw std::runtime_error("Line " + std::to_string(parser.getLexer().line()) + ":" + std::string(msg));
}

}

%code requires {
#include <string>
#include "LppAst.hpp"

class Parser; // Forward declaration

using ParserValueType = AstNode *;

#define YYSTYPE ParserValueType
#define YYSTYPE_IS_DECLARED 1

}

%token Eol
%token Inicio           "Inicio"
%token Fin              "Fin"

%token Escriba          "Escriba"
%token De               "De"
%token Funcion          "Funcion"
%token Procedimiento    "Procedimiento"
%token Final            "Final"
%token Llamar           "Llamar"
%token Lea              "Lea"
%token Retorne          "Retorne"
%token Es               "Es"
%token Registro         "Registro"
%token Archivo          "Archivo"
%token Secuencial       "Secuencial"
%token Abrir            "Abrir"
%token Como             "Como"
%token Lectura          "Lectura"
%token Escritura        "Escritura"
%token Cerrar           "Cerrar"
%token Leer             "Leer"
%token Escribir         "Escribir"

%token Si               "Si"
%token Entonces         "Entonces"
%token Sino             "Sino"

%token Para             "Para"
%token Mientras         "Mientras"
%token Haga             "Haga"
%token Repita           "Repita"
%token Hasta            "Hasta"
%token Caso             "Caso"

%token O                "(o)"
%token Y                "(y)"
%token No               "(no)"
%token Mayor            "(>)"
%token Menor            "(<)"
%token Igual            "(==)"
%token NoIgual          "(!=)"
%token MayorIgual       "(>=)"
%token MenorIgual       "(<=)"
%token Diferente        "(<>)"

%token Variable         "Variable"
%token Entero           "Entero"
%token Real             "Real"
%token Caracter         "Caracter"
%token Cadena           "Cadena"
%token Booleano         "Booleano"
%token Arreglo          "Arreglo"
%token Tipo             "Tipo"

%token Letras           "Letras"
%token Decimal          "Decimal"
%token Binario          "Binario"
%token Hexadecimal      "Hexadecimal"
%token Verdadero        "Verdadero"
%token Falso            "Falso"
%token Letra            "Letra"
%token Numero           "Numero"

%token Asignar          "<-"
%token Coma             ","
%token ParAbierto       "("
%token ParCerrado       ")"
%token BrackAbierto     "["
%token BrackCerrado     "]"
%token DosPuntos        ":"
%token SignoIgual       "="
%token PuntoComa        ";"

%token Suma             "+"
%token Resta            "-"
%token Multiplicacion   "*"
%token Division         "/"
%token Div              "div"
%token Mod              "mod"
%token Var              "var"

%%
programa: programa_cuerpo { $$ = $1; }
;

programa_cuerpo: init_declaraciones decl_Eol Inicio decl_Eol declaraciones Fin decl_Eol { parser.addStmt(new Programa($5)); }
;

init_declaraciones: /* vacio */
                  | declaraciones { $$ = $1; }

declaraciones: declaraciones declaracion { $$ = new Bloque_Declaracion($1, $2); }
             | declaracion { $$ = $1; }
;

declaracion: declaracion_escriba { $$ = $1; }
           | declaracion_variables { $$ = $1; }
           | asignacion { $$ = $1; }
           | declaracion_funcion
           | declaracion_procedimiento 
           | declaracion_llamar  
           | declaracion_para 
           | declaracion_mientras 
           | declaracion_condicional
           | arreglo_inicializar { $$ = $1; }
;

declaracion_escriba: Escriba expr decl_Eol { $$ = new Declaracion_Escriba($2); }
                   | Escriba llamada_funcion Eol { $$ = new Declaracion_Escriba($2); }
;

declaracion_variables: tipos_datos lista_variables decl_Eol { $$ = new Declaracion_Variables($1, $2); }
;

declaracion_llamar: Llamar llamada_funcion decl_Eol
;

//PROCEDIMIENTO
declaracion_procedimiento: Procedimiento encabezado_procedimiento decl_Eol init_declaraciones Inicio decl_Eol declaraciones Fin decl_Eol
;

encabezado_procedimiento: Variable ParAbierto parametros_opcional ParCerrado
                        | Variable
;

//FUNCION
declaracion_funcion: Funcion encabezado_funcion decl_Eol init_declaraciones Inicio decl_Eol cuerpo_funcion Fin decl_Eol { $$ = new Declaracion_Funcion($2, $4, $7); }
;

encabezado_funcion: Variable ParAbierto parametros_opcional ParCerrado DosPuntos tipos_datos { $$ = new  Declaracion_Funcion_Encabezado($1, $3, $6); }
                  | Variable DosPuntos tipos_datos
;

cuerpo_funcion: declaraciones Retorne expr decl_Eol { $$ = $1; }
              | declaraciones { $$ = $1; }
              | Retorne expr decl_Eol { $$ = $2; }
;

//PARAMETROS
parametros_opcional: /* vacio */
              | parametros { $$ = $1; }
;

parametros: parametros Coma parametro { $$ = new Bloque_Param($1, $3); }
          | parametro { $$ = $1; }
;

parametro: tipos_datos Variable { $$ = new Parametro_Init($1, $2); }
        | arreglo_inicializar { $$ = $1; }
        | Var tipos_datos Variable { $$ = new Parametro_Init($2, $3); }
;

//VARIABLES
asignacion: Variable Asignar expr decl_Eol { $$ = new Declaracion_Asignacion($1, $3); }
          | arreglo Asignar Decimal decl_Eol { $$ = new Declaracion_Asignacion($1, $3); }
          | arreglo Asignar Variable decl_Eol { $$ = new Declaracion_Asignacion($1, $3); }
          | arreglo Asignar arreglo decl_Eol { $$ = new Declaracion_Asignacion($1, $3); }
;

lista_variables: lista_variables Coma Variable { $$ = new Bloque_Param($1, $3); }
               | Variable { $$ = $1; }
;
//CONDICIONALES
declaracion_condicional: condicion sino_opcional fin_si
;

condicion: Si sentencias_comparacion condicional_entonces
;

sino_opcional: /* vacio */
            | Sino decl_Eol Retorne expr decl_Eol
            | Sino decl_Eol declaraciones decl_Eol
            | sino_opcional Sino Si sentencias_comparacion condicional_entonces
            | Sino Si sentencias_comparacion condicional_entonces
;

condicional_entonces: Entonces decl_Eol Retorne expr decl_Eol
                    | Entonces decl_Eol declaraciones decl_Eol
;

fin_si: Fin Si decl_Eol
;

//PARA
declaracion_para: Para para_condicion Hasta Decimal Haga decl_Eol declaraciones fin_para
                | Para para_condicion Hasta Variable Haga decl_Eol declaraciones fin_para
;

para_condicion: Variable Asignar Decimal
              | Variable Asignar Variable
;

fin_para: Fin Para decl_Eol
;

//MIENTRAS
declaracion_mientras: Mientras mientras_condicion Haga decl_Eol declaraciones fin_mientras
;

mientras_condicion: Variable MenorIgual Decimal
;

fin_mientras: Fin Mientras decl_Eol
;

//COMPARACION
sentencias_comparacion: sentencia_comparacion
                    | sentencias_comparacion comparacion sentencia_comparacion
;                 

sentencia_comparacion: expr comparacion expr
                    | ParAbierto expr comparacion expr ParCerrado
;

//ARREGLO
arreglo: Variable arreglo_brackets { $$ = new Array($1, $2); }
;

arreglo_inicializar: Var Arreglo arreglo_brackets De Entero Variable decl_Eol { $$ = new Var_Array_Init($3, $6); }
                | Arreglo arreglo_brackets De Entero Variable decl_Eol { $$ = new Var_Array_Init($2, $5); }
;

arreglo_brackets: BrackAbierto Decimal BrackCerrado { $$ = new Array_Brackets($2); }
                | BrackAbierto Variable BrackCerrado { $$ = new Array_Brackets($2); }
;

comparacion: Igual { $$ = $1; }
           | Mayor { $$ = $1; }
           | Menor { $$ = $1; }
           | MayorIgual { $$ = $1; }
           | MenorIgual { $$ = $1; }
           | NoIgual { $$ = $1; }
           | Y { $$ = $1; }
           | O { $$ = $1; }
           | No { $$ = $1; }
           | Diferente { $$ = $1; }
;

//EXPRESIONES
llamada_funcion: Variable ParAbierto argumentos_opcional ParCerrado
            | Variable
;

argumentos_opcional: argumentos
              | /* vacio */
;

argumentos: argumentos Coma expr
          | expr
;

tipos_datos: Entero { $$ = $1; }
           | Real { $$ = $1; }
           | Caracter { $$ = $1; }
           | Cadena { $$ = $1; }
           | Booleano { $$ = $1; }
           | Arreglo { $$ = $1; }
           | Tipo { $$ = $1; }
;

expr: Letras { $$ = $1; }
    | Letra { $$ = $1; }
    | Verdadero { $$ = $1; }
    | Falso { $$ = $1; }
    | aritmetica { $$ = $1; }
    | ParAbierto expr ParCerrado { $$ = $2; }
    | llamada_funcion { $$ = $1; }
    | arreglo { $$ = $1; }
;

aritmetica: aritmetica Suma aritmetica { $$ = new Operacion_Suma($1, $3); }
          | aritmetica Resta aritmetica { $$ = new Operacion_Resta($1, $3); }
          | aritmetica Multiplicacion aritmetica { $$ = new Operacion_Multiplicacion($1, $3); }
          | aritmetica Division aritmetica { $$ = new Operacion_Division($1, $3); }
          | aritmetica Div aritmetica { $$ = new Operacion_Div($1, $3); }
          | aritmetica Mod aritmetica { $$ = new Operacion_Mod($1, $3); }
          | Numero { $$ = $1; }
          | Decimal { $$ = $1; }
          | llamada_funcion { $$ = $1; }
;

decl_Eol: /* vacio */
        | Eol { $$ = new Eol_Nodo("\n"); }
;