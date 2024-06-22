#ifndef __PARSER_HPP__
#define __PARSER_HPP__

#include <vector>
#include "ParserImpl.hpp"
#include "Lexer.hpp"
#include "LppAst.hpp"

class Parser
{
public:
    Parser(Lexer& lexer)
      : lexer(lexer)
    {}

    int parse();

    void addStmt(AstNode *stmt)
    { stmts.push_back(stmt); }

    const std::vector<AstNode *>& getStmts() const
    { return stmts; }

    Lexer& getLexer()
    { return lexer; }

    const Lexer& getLexer() const
    { return lexer; }

private:
    std::vector<AstNode *> stmts;
    Lexer& lexer;
};

#endif