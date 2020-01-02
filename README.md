# HTML_TO_LATEX
Convert HTML file to LateX file.

Language used: C++

The features(tags) of HTML considered are (given) :-
1. head
2. body
3. title
4. a:href
5. font: size
6. center
7. br
8. p
10. h1, h2, h3, h4
11. ul, li, ol, ul, dl, dt, dd
12. div
13. u, b, i, em, tt, strong, small,
14. sub, sup
15. img: src, width, height, figure, figcaption
16. table, caption, th, tr, td


Files

• lexer.l : lex file which contains rules to match tokens
• as.y : parser which contain all grammar rules and coressponding actions.
• MAIN.cpp : It contains main function which calls parser and call treverse() to traverse ast.
• AST.cpp : It contains all the functions for mapping.

To run code:
./run.sh input.html output.tex


