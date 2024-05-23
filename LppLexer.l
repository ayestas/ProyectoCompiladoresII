%option case-insensitive
%option noyywrap
%option reentrant
%option yylineno
%option extra-type = "std::istream *"

%{
#include <iostream>
#include <cstdlib>
#include "Lexer.hpp"

#define YY_DECL Token Lexer::nextTokenHelper(yyscan_t yyscanner, Lexer::BisonValueType *lval)
#define yyterminate() return Token::Eof

#define YY_INPUT(buf, result, max_size) \
    { \
        auto *in = yyget_extra(yyscanner); \
        in->read(buf, max_size); \
        result = in->gcount(); \
    }

void printToken(Token token, const char* text)
{
    std::cout << "[" << Lexer::tokenString(token) << "] " << text << std::endl;
}
%}

%x ESCRIBA
%x comment

%%

"inicio"            { printToken(Token::Inicio, yytext); return Token::Inicio; }
"fin"               { printToken(Token::Fin, yytext); return Token::Fin; }
"finsi"             { printToken(Token::FinSi, yytext); return Token::FinSi; }

"De"                { printToken(Token::De, yytext); return Token::De; }
"Funcion"           { printToken(Token::Funcion, yytext); return Token::Funcion; }
"Procedimiento"     { printToken(Token::Procedimiento, yytext); return Token::Procedimiento; }
"Escriba"           { BEGIN ESCRIBA; printToken(Token::Escriba, yytext); return Token::Escriba; }
"Mientras"          { printToken(Token::Mientras, yytext); return Token::Mientras; }
"Haga"              { printToken(Token::Haga, yytext); return Token::Haga; }
"Para"              { printToken(Token::Para, yytext); return Token::Para; }
"Hasta"             { printToken(Token::Hasta, yytext); return Token::Hasta; }

"Si"                { printToken(Token::Si, yytext); return Token::Si; }
"Entonces"          { printToken(Token::Entonces, yytext); return Token::Entonces; }
"Sino"              { printToken(Token::Sino, yytext); return Token::Sino; }

"Repita"            { printToken(Token::Repita, yytext); return Token::Repita; }
"Llamar"            { printToken(Token::Llamar, yytext); return Token::Llamar; }
"Retorne"           { printToken(Token::Retorne, yytext); return Token::Retorne; }

"O"                 { printToken(Token::O, yytext); return Token::O; }
"Y"                 { printToken(Token::Y, yytext); return Token::Y; }
"No"                { printToken(Token::NO, yytext); return Token::NO; }
">"                 { printToken(Token::Mayor, yytext); return Token::Mayor; }
"<"                 { printToken(Token::Menor, yytext); return Token::Menor; }

"Entero"            { printToken(Token::Entero, yytext); return Token::Entero; }
"Cadena"            { printToken(Token::Cadena, yytext); return Token::Cadena; }
"Booleano"          { printToken(Token::Booleano, yytext); return Token::Booleano; }
"Caracter"          { printToken(Token::Caracter, yytext); return Token::Caracter; }
"Arreglo"           { printToken(Token::Arreglo, yytext); return Token::Arreglo; }

"Verdadero"         { printToken(Token::Verdadero, yytext); return Token::Verdadero; }
"Falso"             { printToken(Token::Falso, yytext); return Token::Falso; }

"<-"                { printToken(Token::Asignar, yytext); return Token::Asignar; }
","                 { printToken(Token::Coma, yytext); return Token::Coma; }
":"                 { printToken(Token::DosPuntos, yytext); return Token::DosPuntos; }

"+"                 { printToken(Token::Suma, yytext); return Token::Suma; }
"-"                 { printToken(Token::Resta, yytext); return Token::Resta; }
"*"                 { printToken(Token::Multiplicacion, yytext); return Token::Multiplicacion; }
"/"                 { printToken(Token::Division, yytext); return Token::Division; }
"("                 { printToken(Token::ParAbierto, yytext); return Token::ParAbierto; }
")"                 { printToken(Token::ParCerrado, yytext); return Token::ParCerrado; }
"["                 { printToken(Token::BrackAbierto, yytext); return Token::BrackAbierto; }
"]"                 { printToken(Token::BrackCerrado, yytext); return Token::BrackCerrado; }
"="                 { printToken(Token::Igual, yytext); return Token::Igual; }
"Var"               { printToken(Token::Var, yytext); return Token::Var; }
"<="               { printToken(Token::AsignarWhile, yytext); return Token::AsignarWhile; }

[a-zA-Z_][0-9a-zA-Z_]*  { printToken(Token::Variable, yytext); return Token::Variable; }  // Este patrón debe venir después de "FinSi"
\"[^\"]*\"              { printToken(Token::Letras, yytext); return Token::Letras; }
[0-9]+                  { printToken(Token::Decimal, yytext); return Token::Decimal; }
\'[^\']\'               { printToken(Token::Letra, yytext); return Token::Letra; }

"//"[^\n]*\n { }
"/*" { BEGIN(comment); }

<ESCRIBA>[ \t]*[a-zA-Z_][0-9a-zA-Z_]*[ \t]* { BEGIN INITIAL; printToken(Token::Variable, yytext); return Token::Variable; }
<ESCRIBA>\"[^\"]*\"                         { BEGIN INITIAL; printToken(Token::Letras, yytext); return Token::Letras; }
<ESCRIBA>\'[^\']\'                          { BEGIN INITIAL; printToken(Token::Letra, yytext); return Token::Letra; }

<comment>"*/" { BEGIN(INITIAL); }
<comment>.|\n { /* Nothing */ }
<comment><<EOF>> { std::cerr << "Advertencia: Bloque de comentario sin cerrar.\n";  }

[ \t\n]+        { }
.               { fprintf(stderr, "Simbolo Invalido: %s\n", yytext); exit(1); }

%%