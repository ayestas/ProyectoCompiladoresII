cmake_minimum_required(VERSION 3.14)
project(Lpp)

find_package(FLEX REQUIRED)
find_package(BISON REQUIRED)

FLEX_TARGET(LppLexer LppLexer.l
            ${CMAKE_CURRENT_BINARY_DIR}/LexerImpl.cpp
            DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/LexerImpl.hpp
            )

BISON_TARGET(LppParser LppParser.y
            ${CMAKE_CURRENT_BINARY_DIR}/ParserImpl.cpp
            DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/ParserImpl.hpp
            )

include_directories(${CMAKE_CURRENT_BINARY_DIR})
include_directories(${CMAKE_SOURCE_DIR})

add_executable(${PROJECT_NAME}
    ${FLEX_LppLexer_OUTPUTS}
    ${BISON_LppParser_OUTPUTS}
    Lexer.hpp
    Lexer.cpp
    Parser.hpp
    Parser.cpp
    main.cpp
 )