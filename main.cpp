#include <fstream>
#include <iostream>
#include "Lexer.hpp"
#include "Parser.hpp"

int main(int argc, char *argv[]) 
{    
    if (argc != 2) {
        std::cerr << "Not enough CLI arguments\n";
        return 1;
    }
    std::ifstream in(argv[1], std::ios::in);

    if (!in.is_open()) {
        std::cerr << "Cannot open file\n";
        return 1;
    }

    Lexer lexer(in);
    Parser parser(lexer);

    try
    {
        parser.parse();        
        std::cout << "Programa Evaluado sin errores!\n";
    }
    catch(const std::runtime_error& e)
    {
        std::cerr << e.what() << '\n';
    }
    
}
