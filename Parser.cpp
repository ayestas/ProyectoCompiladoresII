#include "Parser.hpp"
#include "ParserImpl.hpp"

int Parser::parse()
{
    return yyparse(lexer, value);
}