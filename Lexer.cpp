#include <fstream>
#include "Lexer.hpp"
#include "LexerImpl.hpp"

Lexer::Lexer(std::istream& _in)
  : in(_in)
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

const char *Lexer::tokenString(Token tk)
{
    switch (tk)
    {
        //BLOQUES
        case Token::Inicio: 
            return "TK_I";
        case Token::Fin: 
            return "TK_Fin";

        //DECLARACIONES
        case Token::De: 
            return "TK_De";
        case Token::Funcion:
            return "TK_Fun";
        case Token::Procedimiento:
            return "TK_Pro";
        case Token::Variable:
            return "var";
        case Token::Final:
            return "Fnl";
        case Token::Llamar:
            return "TK_Lla";
        case Token::Lea:
            return "TK_Lea";
        case Token::Escriba: 
            return "TK_Esc";
        case Token::Retorne:
            return "TK_Ret";
        case Token::Es:
            return "TK_Es";
        case Token::Registro:
            return "TK_Reg";
        case Token::Archivo:
            return "TK_Ach";
        case Token::Secuencial:
            return "TK_Sec";
        case Token::Abrir:
            return "TK_Abr";
        case Token::Como:
            return "TK_Como";
        case Token::Lectura:
            return "TK_Lec";
        case Token::Escritura:
            return "TK_Ect";
        case Token::Cerrar:
            return "TK_Crr";
        case Token::Leer:
            return "TK_Leer";
        case Token::Escribir:
            return "TK_Ecb";

        //CONDICIONALES
        case Token::Si:
            return "TK_Si";
        case Token::Entonces:
            return "TK_Ent";
        case Token::Sino:
            return "TK_Sin";
        case Token::FinSi:
            return "TK_FinSi";

        //BUCLES
        case Token::Para:
            return "TK_Par";
        case Token::Mientras:
            return "TK_Mie";
        case Token::Haga:
            return "TK_Hag";
        case Token::Repita:
            return "TK_Rep";
        case Token::Hasta:
            return "TK_Has";
        case Token::Caso:
            return "TK_Caso";
        
        //COMPARACION
        case Token::O:
            return "TK_O";
        case Token::Y:
            return "TK_Y";
        case Token::NO:
            return "TK_No";
        case Token::Mayor:
            return "TK_Myr";
        case Token::Menor:
            return "TK_Mnr";

        //TIPOS DE DATOS
        case Token::Entero:
            return "TK_Entr";
        case Token::Real:
            return "TK_Real";
        case Token::Cadena: 
            return "TK_Cadn";
        case Token::Booleano:
            return "TK_Bool";
        case Token::Caracter:
            return "TK_Char";
        case Token::Arreglo:
            return "TK_Arr";
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
            return "tk_v";
        case Token::Falso:
            return "tk_f";
        case Token::Letra:
            return "tk_ltr";
        case Token::Digito:
            return "tk_dig";

        //SIMBOLOS
        case Token::Asignar:
            return "tk_asg";
        case Token::Coma:
            return "tk_coma";
        case Token::ParAbierto:
            return "tk_parA";
        case Token::ParCerrado:
            return "tk_parC";
        case Token::BrackAbierto:
            return "tk_brkA";
        case Token::BrackCerrado:
            return "tk_brkC";
        case Token::DosPuntos:
            return "tk_dpts";
        case Token::Igual:
            return "tk_igl";
        
        //OPERADORES
        case Token::Suma:
            return "tk_sum";
        case Token::Resta:
            return "tk_rst";
        case Token::Multiplicacion:
            return "tk_mul";
        case Token::Division:
            return "tk_div";
        case Token::Div:
            return "tk_DIV";
        case Token::Mod:
            return "tk_MOD";
        default:
            return "Unknown";
    }
}
