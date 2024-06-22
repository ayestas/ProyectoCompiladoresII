#include <fstream>
#include <iostream>
#include "Lexer.hpp"
#include "Parser.hpp"
#include "LppAst.hpp"

int main(int argc, char *argv[])
{
    if (argc != 3)
    {
        std::cerr << "Not enough CLI arguments\n";
        return 1;
    }

    std::string nombreArchivo = argv[2];

    if (nombreArchivo.size() < 4 || nombreArchivo.substr(nombreArchivo.size() - 4) != ".asm")
    {
        std::cerr << "Error: El archivo debe tener la extensión .asm" << std::endl;
        return 0;
    }
    else
    {
        std::ifstream in(argv[1], std::ios::in);
        std::ofstream out(argv[2], std::ios::out);

        if (!in.is_open())
        {
            std::cerr << "Cannot open file\n";
            return 0;
        }

        if (!out.is_open())
        {
            std::cerr << "Cannot open file\n";
            return 0;
        }

        try
        {
            out << "; CODIGO GENERADO DE ASM" << std::endl;
        }
        catch (const std::exception &e)
        {
            std::cerr << e.what() << '\n';
        }

        Lexer lexer(in, out);
        Parser parser(lexer);

        try
        {
            parser.parse();
            const std::vector<AstNode *> &stmts = parser.getStmts();

            for (const auto &s : stmts)
            {
                std::cout << s->toString() << '\n';
            }
        }
        catch (const std::runtime_error &e)
        {
            std::cerr << e.what() << '\n';
            return 0;
        }
    }
}