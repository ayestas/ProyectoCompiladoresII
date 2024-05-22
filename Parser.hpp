#ifndef __PARSER_HPP__
#define __PARSER_HPP__

#include "Lexer.hpp"
#include "LexerImpl.hpp"

class Parser
{
public:
    Parser(Lexer& lexer)
      : lexer(lexer)
    {}

    int parse();

    int getValue() const
    { return value; }

private:
    int value;
    Lexer& lexer;
};


#endif