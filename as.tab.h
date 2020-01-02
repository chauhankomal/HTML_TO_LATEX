/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_AS_TAB_H_INCLUDED
# define YY_YY_AS_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    S_HEAD = 258,
    E_HEAD = 259,
    S_BODY = 260,
    E_BODY = 261,
    S_TITLE = 262,
    E_TITLE = 263,
    S_H1 = 264,
    E_H1 = 265,
    STRING = 266,
    FONT = 267,
    S_HTML = 268,
    E_HTML = 269,
    S_H2 = 270,
    E_H2 = 271,
    S_H3 = 272,
    E_H3 = 273,
    S_H4 = 274,
    E_H4 = 275,
    A_HREF = 276,
    E_A = 277,
    E_ANG_BRACKET = 278,
    S_U = 279,
    E_U = 280,
    TITLE = 281,
    S_CENTER = 282,
    E_CENTER = 283,
    BREAK = 284,
    S_PARA = 285,
    E_PARA = 286,
    E_FONT = 287,
    WIDTH = 288,
    HEIGHT = 289,
    HREF = 290,
    S_FIGCAPTION = 291,
    E_FIGCAPTION = 292,
    S_OLIST = 293,
    E_OLIST = 294,
    S_ULIST = 295,
    E_ULIST = 296,
    S_ITEM = 297,
    E_ITEM = 298,
    S_DL = 299,
    E_DL = 300,
    S_DT = 301,
    E_DT = 302,
    S_DD = 303,
    E_DD = 304,
    IMAGE_WITH_ATTRIBUTE = 305,
    S_I = 306,
    E_I = 307,
    S_SMALL = 308,
    E_SMALL = 309,
    S_STRONG = 310,
    E_STRONG = 311,
    S_BOLD = 312,
    E_BOLD = 313,
    S_EM = 314,
    E_EM = 315,
    S_TT = 316,
    E_TT = 317,
    S_DIV = 318,
    E_DIV = 319,
    E_TABLE = 320,
    S_TABLE = 321,
    SIZE = 322,
    ATTRIBUTE = 323,
    SOURCE = 324,
    ATTR_VAL = 325,
    BORDER = 326,
    NAME = 327,
    ID = 328,
    S_SUB = 329,
    E_SUB = 330,
    S_SUP = 331,
    E_SUP = 332,
    SYMBOL = 333,
    S_TD = 334,
    E_TD = 335,
    S_TR = 336,
    E_TR = 337,
    S_TH = 338,
    E_TH = 339,
    S_CAPTION = 340,
    E_CAPTION = 341,
    GREEK = 342,
    S_FIG = 343,
    E_FIG = 344
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 29 "as.y" /* yacc.c:1909  */

	struct astNode *node;
	char* s;
	int i;

#line 150 "as.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_AS_TAB_H_INCLUDED  */
