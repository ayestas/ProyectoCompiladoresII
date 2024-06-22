#include <fstream>
#include "Lexer.hpp"
#include "LexerImpl.hpp"

Lexer::Lexer(std::istream& _in, std::ostream& _out)
  : in(_in), out(_out)
{
    yylex_init_extra(&in, &yyscanner);
}

Lexer::~Lexer()
{
    yylex_destroy(yyscanner);
}

std::string Lexer::text() const
{
    return std::string(yyget_text(yyscanner));
}

long Lexer::line() const
{
    return yyget_lineno(yyscanner);
}

const char *Lexer::tokenString(Token tk) 
{
    switch (tk)
    {
        case Token::Eol:
            return "EOL";
        case Token::Inicio: 
            return "TK_I";
        case Token::Fin: 
            return "TK_Fin";
        //DECLARACIONES
        case Token::Escriba:
            return "TK_Escriba";
        case Token::De:
            return "TK_De";
        case Token::Funcion:
            return "TK_Func";
        case Token::Procedimiento:
            return "TK_Proc";
        case Token::Final:
            return "TK_Final";
        case Token::Llamar:
            return "TK_Llamar";
        case Token::Lea:
            return "TK_Lea";
        case Token::Retorne:
            return "TK_Retorne";
        case Token::Es:
            return "TK_Es";
        case Token::Registro:
            return "TK_Reg";
        case Token::Archivo:    
            return "TK_Arch";
        case Token::Secuencial:
            return "TK_Sec";
        case Token::Abrir:
            return "TK_Abrir";
        case Token::Como:
            return "TK_Como";
        case Token::Lectura:
            return "TK_Lectura";
        case Token::Escritura:
            return "TK_Escritura";
        case Token::Cerrar:
            return "TK_Cerrar";
        case Token::Leer:
            return "TK_Leer";
        case Token::Escribir:
            return "TK_Escribir";
        //CONDICIONALES
        case Token::Si:
            return "TK_Si";
        case Token::Entonces:
            return "TK_Entonces";
        case Token::Sino:
            return "TK_Sino";
        //CICLOS
        case Token::Para:
            return "TK_Para";
        case Token::Mientras:
            return "TK_Mientras";
        case Token::Haga:
            return "TK_Haga";
        case Token::Repita:
            return "TK_Repita";
        case Token::Hasta:
            return "TK_Hasta";
        case Token::Caso:
            return "TK_Caso";
        //COMPARACION
        case Token::O:
            return "TK_O";
        case Token::Y:
            return "TK_Y";
        case Token::No:
            return "TK_No";
        case Token::Mayor:
            return "TK_Mayor";
        case Token::Menor:
            return "TK_Menor";
        case Token::Igual:
            return "TK_Igual";
        case Token::NoIgual:
            return "TK_NoIgual";
        case Token::MayorIgual:
            return "TK_MayorIgual";
        case Token::MenorIgual:
            return "TK_MenorIgual";
        case Token::Diferente:
            return "TK_Diferente";
        //TIPOS DE DATOS
        case Token::Variable:
            return "TK_Variable";
        case Token::Entero:
            return "TK_Ent";
        case Token::Real:
            return "TK_Real";
        case Token::Caracter:
            return "TK_Char";
        case Token::Cadena:
            return "TK_Cadena";
        case Token::Booleano:
            return "TK_Bool";
        case Token::Arreglo:
            return "TK_Arreglo";
        case Token::Tipo:
            return "TK_Tipo";
        //DATOS
        case Token::Letras:
            return "tk_ltrs";
        case Token::Decimal:
            return "tk_dec";
        case Token::Binario:
            return "tk_bin";
        case Token::Hexadecimal:
            return "tk_hex";
        case Token::Verdadero:
            return "tk_true";
        case Token::Falso:
            return "tk_false";
        case Token::Letra:
            return "tk_ltr";
        case Token::Numero:
            return "tk_dgt";
        //SIMBOLOS
        case Token::Asignar:
            return "tk_Asignar";
        case Token::Coma:
            return "tk_Coma";
        case Token::ParAbierto:
            return "tk_ParAbierto";
        case Token::ParCerrado:
            return "tk_ParCerrado";
        case Token::BrackAbierto:  
            return "tk_BrackAbierto";
        case Token::BrackCerrado:
            return "tk_BrackCerrado";
        case Token::DosPuntos:
            return "tk_DosPuntos";
        case Token::SignoIgual:
            return "tk_SignoIgual";
        case Token::PuntoComa:
            return "tk_PuntoComa";
        //OPERANDOS
        case Token::Suma:
            return "tk_Suma";
        case Token::Resta:
            return "tk_Resta";
        case Token::Multiplicacion:
            return "tk_Multi";
        case Token::Division:
            return "tk_Division";
        case Token::Mod:
            return "tk_Mod";
        case Token::Div:
            return "tk_Div";
        case Token::Var:
            return "tk_Var";
        default:
            return "Unknown";
    }
}