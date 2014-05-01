/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

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

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     INTLIT = 258,
     BOOLLIT = 259,
     INT = 260,
     BOOL = 261,
     NEW = 262,
     IF = 263,
     ELSE = 264,
     WHILE = 265,
     PRINT = 266,
     PARSEINT = 267,
     CLASS = 268,
     PUBLIC = 269,
     STATIC = 270,
     VOID = 271,
     STRING = 272,
     DOTLENGTH = 273,
     RETURN = 274,
     OCURV = 275,
     CCURV = 276,
     OBRACE = 277,
     CBRACE = 278,
     OSQUARE = 279,
     CSQUARE = 280,
     OP1 = 281,
     OP2 = 282,
     OP3 = 283,
     OP4 = 284,
     NOT = 285,
     ASSIGN = 286,
     SEMIC = 287,
     COMMA = 288,
     RESERVED = 289,
     ID = 290,
     REDUCEEXPRESSON1 = 291,
     IFX = 292,
     OPS_FTW = 293
   };
#endif
/* Tokens.  */
#define INTLIT 258
#define BOOLLIT 259
#define INT 260
#define BOOL 261
#define NEW 262
#define IF 263
#define ELSE 264
#define WHILE 265
#define PRINT 266
#define PARSEINT 267
#define CLASS 268
#define PUBLIC 269
#define STATIC 270
#define VOID 271
#define STRING 272
#define DOTLENGTH 273
#define RETURN 274
#define OCURV 275
#define CCURV 276
#define OBRACE 277
#define CBRACE 278
#define OSQUARE 279
#define CSQUARE 280
#define OP1 281
#define OP2 282
#define OP3 283
#define OP4 284
#define NOT 285
#define ASSIGN 286
#define SEMIC 287
#define COMMA 288
#define RESERVED 289
#define ID 290
#define REDUCEEXPRESSON1 291
#define IFX 292
#define OPS_FTW 293




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 12 "ijparser.y"
{
	char cval;
	int intval;
}
/* Line 1529 of yacc.c.  */
#line 130 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

