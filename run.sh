flex lexer.l
bison -dv as.y
g++ MAIN.cpp lex.yy.c as.tab.c AST.cpp MAP.cpp -o compiler -std=c++11
./compiler $1 $2
