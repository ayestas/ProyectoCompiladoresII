#include <unordered_map>
#include "Parser.hpp"

int Parser::parse()
{
    return yyparse(*this);
}