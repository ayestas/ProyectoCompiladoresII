%option case-insensitive
%option noyywrap
%option reentrant
%option yylineno
%option extra-type = "std::istream *"

%{
#include <iostream>
#include <cstdlib>
#include "Lexer.hpp"
#include "LppAst.hpp"

#define YY_DECL Token Lexer::nextTokenHelper(yyscan_t yyscanner, ParserValueType *lval)
#define yyterminate() return Token::Eof

#define YY_INPUT(buf, result, max_size) \
    { \
        auto *in = yyget_extra(yyscanner); \
        in->read(buf, max_size); \
        result = in->gcount(); \
    }

void printToken(Token token, const char* text)
{
    //std::cout << "[" << Lexer::tokenString(token) << "] " << text << std::endl;
}
%}

%x comment

%%

\n { *lval = new Eol_Nodo("\n"); return Token::Eol; }

"Inicio"            { printToken(Token::Inicio, yytext); return Token::Inicio; }
"Fin"               { printToken(Token::Fin, yytext); return Token::Fin; }

"Escriba"           { printToken(Token::Escriba, yytext); return Token::Escriba; }
"De"                { printToken(Token::De, yytext); return Token::De; }
"Funcion"           { printToken(Token::Funcion, yytext); return Token::Funcion; }
"Procedimiento"     { printToken(Token::Procedimiento, yytext); return Token::Procedimiento; }
"Final"             { printToken(Token::Final, yytext); return Token::Final; }
"Llamar"            { printToken(Token::Llamar, yytext); return Token::Llamar; }
"Lea"               { printToken(Token::Lea, yytext); return Token::Lea; }  
"Retorne"           { printToken(Token::Retorne, yytext); return Token::Retorne; }
"Es"                { printToken(Token::Es, yytext); return Token::Es; }
"Registro"          { printToken(Token::Registro, yytext); return Token::Registro; }
"Archivo"           { printToken(Token::Archivo, yytext); return Token::Archivo; }
"Secuencial"        { printToken(Token::Secuencial, yytext); return Token::Secuencial; }
"Abrir"             { printToken(Token::Abrir, yytext); return Token::Abrir; }
"Como"              { printToken(Token::Como, yytext); return Token::Como; }
"Lectura"           { printToken(Token::Lectura, yytext); return Token::Lectura; }
"Escritura"         { printToken(Token::Escritura, yytext); return Token::Escritura; }
"Cerrar"            { printToken(Token::Cerrar, yytext); return Token::Cerrar; }
"Leer"              { printToken(Token::Leer, yytext); return Token::Leer; }
"Escribir"          { printToken(Token::Escribir, yytext); return Token::Escribir; }

"Si"                { printToken(Token::Si, yytext); return Token::Si; }
"Entonces"          { printToken(Token::Entonces, yytext); return Token::Entonces; }
"Sino"              { printToken(Token::Sino, yytext); return Token::Sino; }

"Para"              { printToken(Token::Para, yytext); return Token::Para; }
"Mientras"          { printToken(Token::Mientras, yytext); return Token::Mientras; }
"Haga"              { printToken(Token::Haga, yytext); return Token::Haga; }
"Repita"            { printToken(Token::Repita, yytext); return Token::Repita; }
"Hasta"             { printToken(Token::Hasta, yytext); return Token::Hasta; }
"Caso"              { printToken(Token::Caso, yytext); return Token::Caso; }

"O"                 { printToken(Token::O, yytext); return Token::O; }
"Y"                 { printToken(Token::Y, yytext); return Token::Y; }
"No"                { printToken(Token::No, yytext); return Token::No; }
">"                 { printToken(Token::Mayor, yytext); return Token::Mayor; }
"<"                 { printToken(Token::Menor, yytext); return Token::Menor; }
"=="                { printToken(Token::Igual, yytext); return Token::Igual; }
"!="                { printToken(Token::NoIgual, yytext); return Token::NoIgual; }
">="                { printToken(Token::MayorIgual, yytext); return Token::MayorIgual; }
"<="                { printToken(Token::MenorIgual, yytext); return Token::MenorIgual; }
"<>"                { printToken(Token::Diferente, yytext); return Token::Diferente; }

"Entero"            { *lval = new Entero_Nodo(std::string(yytext)); printToken(Token::Entero, yytext); return Token::Entero; }
"Real"              { *lval = new Real_Nodo(std::string(yytext)); printToken(Token::Real, yytext); return Token::Real; }
"Caracter"          { *lval = new Caracter_Nodo(std::string(yytext)); printToken(Token::Caracter, yytext); return Token::Caracter; }
"Cadena"            { *lval = new Cadena_Nodo(std::string(yytext)); printToken(Token::Cadena, yytext); return Token::Cadena; }
"Booleano"          { *lval = new Booleano_Nodo(std::string(yytext)); printToken(Token::Booleano, yytext); return Token::Booleano; }
"Arreglo"           { *lval = new Arreglo_Nodo(std::string(yytext)); printToken(Token::Arreglo, yytext); return Token::Arreglo; }
"Tipo"              { *lval = new Tipo_Nodo(std::string(yytext)); printToken(Token::Tipo, yytext); return Token::Tipo; }

"Verdadero"         { *lval = new Verdadero_Nodo("Verdadero"); printToken(Token::Verdadero, yytext); return Token::Verdadero; }
"Falso"             { *lval = new Falso_Nodo("Falso"); printToken(Token::Falso, yytext); return Token::Falso; }


"<-"                { printToken(Token::Asignar, yytext); return Token::Asignar; }

","                 { printToken(Token::Coma, yytext); return Token::Coma; }
"("                 { printToken(Token::ParAbierto, yytext); return Token::ParAbierto; }
")"                 { printToken(Token::ParCerrado, yytext); return Token::ParCerrado; }
"["                 { printToken(Token::BrackAbierto, yytext); return Token::BrackAbierto; }
"]"                 { printToken(Token::BrackCerrado, yytext); return Token::BrackCerrado; }
":"                 { printToken(Token::DosPuntos, yytext); return Token::DosPuntos; }
"="                 { printToken(Token::Igual, yytext); return Token::Igual; }
";"                 { printToken(Token::PuntoComa, yytext); return Token::PuntoComa; }

"+"                 { printToken(Token::Suma, yytext); return Token::Suma; }
"-"                 { printToken(Token::Resta, yytext); return Token::Resta; }
"*"                 { printToken(Token::Multiplicacion, yytext); return Token::Multiplicacion; }
"/"                 { printToken(Token::Division, yytext); return Token::Division; }
"Div"               { printToken(Token::Div, yytext); return Token::Div; }
"Mod"               { printToken(Token::Mod, yytext); return Token::Mod; }
"Var"               { *lval = new Var_Nodo(std::string(yytext)); printToken(Token::Var, yytext); return Token::Var; }

[a-zA-Z_][0-9a-zA-Z_]*  { *lval = new Variable_Nodo(std::string(yytext)); printToken(Token::Variable, yytext); return Token::Variable; }
\"[^\"]*\"              { *lval = new Letras_Nodo(std::string(yytext)); printToken(Token::Letras, yytext); return Token::Letras; }
[0-9]+(\.[0-9]+)?       { *lval = new Decimal_Nodo(std::atof(yytext)); printToken(Token::Decimal, yytext); return Token::Decimal; }

[0bB][0-1]+             { *lval = new Binario_Nodo(std::string(yytext)); printToken(Token::Binario, yytext); return Token::Binario; }
[0xX][0-9a-fA-F]+       { *lval = new Hexadecimal_Nodo(std::string(yytext)); printToken(Token::Hexadecimal, yytext); return Token::Hexadecimal; }
\'[^\']\'                { *lval = new Letra_Nodo(std::string(yytext)); printToken(Token::Letra, yytext); return Token::Letra; }
[0-9]+                  { *lval = new Numero_Nodo(std::atoi(yytext)); printToken(Token::Numero, yytext); return Token::Numero; }

"//"[^\n]*\n { }
"/*" { BEGIN(comment); }

<comment>"*/" { BEGIN(INITIAL); }
<comment>.|\n { /* Nothing */ }
<comment><<EOF>> { std::cerr << "Advertencia: Bloque de comentario sin cerrar.\n"; }

[ \t\n]+ { }
. { fprintf(stderr, "Simbolo Invalido en la línea %d: %s\n", yylineno, yytext); exit(1); }

%%