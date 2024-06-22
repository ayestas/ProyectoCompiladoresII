cmake_minimum_required(VERSION 3.14)
project(Lpp)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(FLEX REQUIRED)
find_package(BISON REQUIRED)

find_program (TREECC treecc
              PATHS /usr /usr/local /opt /opt/local $ENV{TREECC_DIR}
              PATH_SUFFIXES treecc/bin bin )

if (TREECC)
    message(STATUS "Using treecc executable ${TREECC}")
else(TREECC)
    message(FATAL_ERROR "treecc was not found. Try setting TREECC_DIR environment variable")
endif(TREECC)

# Run treecc to generate the AST
add_custom_command (
  OUTPUT LppAst.cpp LppAst.hpp
  COMMAND ${TREECC} -o LppAst.cpp -h LppAst.hpp ${PROJECT_SOURCE_DIR}/LppAst.tc
  MAIN_DEPENDENCY ${PROJECT_SOURCE_DIR}/LppAst.tc
  )

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
    LppAst.hpp
    LppAst.cpp
    main.cpp
 )