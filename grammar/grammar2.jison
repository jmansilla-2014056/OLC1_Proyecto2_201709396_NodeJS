/**
 * Ejemplo mi primer proyecto con Jison utilizando Nodejs en Ubuntu
 */


%{
    const {NodeAst} = require('../treeAST/NodeAst');
    var count = 0;
%}


/* Definición Léxica */
%lex

%options case-sensitive

%%

/* Espacios en blanco */
[ \r\t]+            {}
\n                  {}

"//".*   {};

[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]    {};

"int"                   return 'INT';
"double"                return 'DOUBLE';
"boolean"               return 'BOOLEAN';
"char"                  return 'CHAR';
"String"                return 'STRING';


"if"                    return 'IF';
"else"                  return 'ELSE';
"switch"                return 'SWITCH';
"case"                  return 'CASE';
"while"                 return 'WHILE';
"do"                    return 'DO';
"for"                   return 'FOR';
"void"                  return 'VOID';
"return"                return 'RETURN';
"break"                 return 'BREAK';
"main"                  return 'MAIN';
"continue"              return'CONTINUE';
"System.out.println"    return'SOUTLN';
"System.out.print"      return'SOUT';


"import"                return'IMPORT';
"class"                 return'CLASS';
"true"                  return'TRUE';
"false"                 return'FALSE';
"default"               return'DEFAULT';

"{"                     return 'LLAVEIZQ';
"}"                     return 'LLAVEDER';
";"                     return 'PTCOMA';
"("                     return 'PARIZQ';
")"                     return 'PARDER';
"["                     return 'CORIZQ';
"]"                     return 'CORDER';
","                     return 'COMA';
":"                     return 'DOSPUNTOS';

"&&"                    return 'AND';
"||"                    return 'OR';
"!="                    return 'DISTINTO';
"=="                    return 'IGUALDAD';
">="                    return 'MAYORIGUALQUE';
"<="                    return 'MENORIGUALQUE';
">"                     return 'MAYORQUE';
"<"                     return 'MENORQUE';


"="                     return 'IGUAL';


"!"                     return 'NOT';


"+"                     return 'MAS';
"-"                     return 'MENOS';
"*"                     return 'POR';
"/"                     return 'DIVIDIDO';
"%"                     return 'MODULO';
"^"                     return 'POTENCIA';

[0-9]+("."[0-9]+)       return 'DECIMAL';

[0-9]+\b                return 'ENTERO';




(\"[^"]*\")             return 'CADENA';
(\'[^']\')              return'CARACTER';



([a-zA-Z]|[_])[a-zA-Z0-9_]* return 'IDENTIFICADOR';



<<EOF>>                 return 'EOF';

.                       { console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); }
/lex

/* Asociación de operadores y precedencia */


%left OR
%left AND
%left IGUALDAD, DISTINTO
%left MAYORIGUALQUE, MENORIGUALQUE, MENORQUE, MAYORQUE
%left MAS, MENOS
%left POR, DIVIDIDO, MODULO
%left POTENCIA
%right NOT
%left UMENOS

%start INICIO

%% /* Definición de la gramática */

INICIO : IMPORTSYCLASES EOF {$$=$1; return $$;}
        |error { console.error('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column); }
;

INSTRUCCIONES : INSTRUCCIONES INSTRUCCION
              | INSTRUCCION
              ;

INSTRUCCION : PRINT
            | IF2
            | WHILE2
            | FOR2
            | DO2
            | SWITCH2
;


INSTRUCCIONESCLASE : INSTRUCCIONESCLASE INSTRUCCIONCLASE
              | INSTRUCCIONCLASE
              ;

INSTRUCCIONCLASE : CLASE2
;

INICIO2: IMPORTSYCLASES {$$= new NodeAst("Raiz","Raiz",count++);$$.listaIns.push($1)}
    ;



IMPORTSYCLASES: IMPORT2 CLASE2 {$$=new NodeAst("Raiz","Raiz",count++); $$.encontrarNodeAstAst($1);$$.listaIns.push($2);}
            |CLASE2 {$$ = new NodeAst("Raiz","Raiz",count++); $$.listaIns.push($1);}
            ;

IMPORT2: IMPORT2 IMPORT IDENTIFICADOR PTCOMA {$$=$1;$$.push(new NodeAst("Import",$2+" "+$3,count++))}
        |IMPORT IDENTIFICADOR PTCOMA {$$=[];$$.push(new NodeAst("Import",$1+" "+$2,count++))}
        ;

INSTRUCCIONESDENTROCLASE : INSTRUCCIONESDENTROCLASE INSTRUCCIONDENTROCLASE {$$=$1;$$.push($2)}
              | INSTRUCCIONDENTROCLASE   {$$=[];$$.push($1)}
              ;

INSTRUCCIONDENTROCLASE : METODO2 {$$ = $1}
            | FUNCION2 {$$ = $1}
            | DECLARACION {$$ = $1}

;

INSTRUCCIONESMETODO : INSTRUCCIONESMETODO INSTRUCCIONMETODO {$$=$1;$$.push($2)}
              | INSTRUCCIONMETODO   {$$=[];$$.push($1)}
              ;

INSTRUCCIONMETODO : PRINT {$$ = $1}
            | IFM {$$ = $1}
            | WHILEM {$$ = $1}
            | FORM {$$ = $1}
            | DOM {$$ = $1}
            | SWITCHM {$$ = $1}
            | DECLARACION {$$ = $1}
            | ASIGNACION {$$ = $1}
            | IDENTIFICADOR PARIZQ LISTAEXPRESION PARDER PTCOMA {$$ = new NodeAst("Sentencia", $1,count++); $$.encontrarNodeAstAst($3)}
            | RETURN PTCOMA {$$ = new NodeAst("Sentencia",$1,count++);}

;

INSTRUCCIONESFUNCION : INSTRUCCIONESFUNCION INSTRUCCIONFUNCION {$$=$1;$$.push($2)}
              | INSTRUCCIONFUNCION {$$=[];$$.push($1)}
              ;

INSTRUCCIONFUNCION : PRINT {$$ = $1}
            | IF2 {$$ = $1}
            | WHILE2 {$$ = $1}
            | FOR2 {$$ = $1}
            | DO2 {$$ = $1}
            | SWITCH2 {$$ = $1}
            | DECLARACION {$$ = $1}
            | ASIGNACION {$$ = $1}
            | IDENTIFICADOR PARIZQ LISTAEXPRESION PARDER PTCOMA {$$ = new NodeAst("Sentencia", $1,count++); $$.encontrarNodeAstAst($3)}



;

INSTRUCCIONESIF: INSTRUCCIONESIF INSTRUCCIONIF {$$=$1;$$.push($2)}
                |INSTRUCCIONIF {$$=[];$$.push($1)}
                ;

INSTRUCCIONIF: PRINT {$$ = $1}
            | IF2 {$$ = $1}
            | WHILE2 {$$ = $1}
            | FOR2 {$$ = $1}
            | DO2 {$$ = $1}
            | SWITCH2 {$$ = $1}
            |IDENTIFICADOR PARIZQ LISTAEXPRESION PARDER PTCOMA  {$$ = new NodeAst("Sentencia", $1,count++); $$.encontrarNodeAstAst($3)}
            |DECLARACION {$$ = $1}
            |ASIGNACION {$$ = $1}
            | RETURN EXPRESION PTCOMA { $$ = new NodeAst("Sentencia", $1,count++);$$.listaIns.push($2);}
            ;

INSTRUCCIONESFOR: INSTRUCCIONESFOR INSTRUCCIONFOR {$$=$1;$$.push($2)}
                |INSTRUCCIONFOR {$$=[];$$.push($1)}
                ;

INSTRUCCIONFOR: PRINT {$$ = $1}
            | IF2 {$$ = $1}
            | WHILE2 {$$ = $1}
            | FOR2 {$$ = $1}
            | DO2 {$$ = $1}
            | SWITCH2 {$$ = $1}
            | BREAK PTCOMA { $$ = new NodeAst("Sentencia", $1,count++);}
            | CONTINUE PTCOMA { $$ = new NodeAst("Sentencia", $1,count++);}
            | IDENTIFICADOR PARIZQ LISTAEXPRESION PARDER PTCOMA {$$ = new NodeAst("Sentencia", $1,count++); $$.encontrarNodeAstAst($3)}
            | DECLARACION {$$ = $1}
            | ASIGNACION {$$ = $1}
            | RETURN EXPRESION PTCOMA { $$ = new NodeAst("Sentencia", $1,count++);$$.listaIns.push($2);}
            ;


INSTRUCCIONESSWITCH: INSTRUCCIONESSWITCH INSTRUCCIONSWITCH {$$=$1;$$.push($2)}
                |INSTRUCCIONSWITCH {$$=[];$$.push($1)}
                ;

INSTRUCCIONSWITCH: PRINT {$$ = $1}
            | IF2 {$$ = $1}
            | WHILE2  {$$ = $1}
            | FOR2 {$$ = $1}
            | DO2 {$$ = $1}
            | SWITCH2 {$$ = $1}
            | BREAK PTCOMA { $$ = new NodeAst("Sentencia", $1,count++);}
            |IDENTIFICADOR PARIZQ LISTAEXPRESION PARDER PTCOMA {$$ = new NodeAst("Sentencia", $1,count++); $$.encontrarNodeAstAst($3)}
            |DECLARACION {$$ = $1}
            |ASIGNACION {$$ = $1}
            |RETURN EXPRESION PTCOMA { $$ = new NodeAst("Sentencia", $1,count++);$$.listaIns.push($2);}
            ;

LISTAEXPRESION: LISTAEXPRESION COMA EXPRESION  {$$=$1;$$.push($3)}
                |EXPRESION {$$=[];$$.push($1)}
                ;


FUNCION2: TIPO IDENTIFICADOR PARIZQ PARAMETROS PARDER BLOQUE_INSTRUCCIONESFUNCION {$$=new NodeAst("Funcion",$1+" "+$2, count++);$$.encontrarNodeAstAst($4);if($6!=null){$$.encontrarNodeAstAst($6)};}
        | TIPO IDENTIFICADOR PARIZQ  PARDER BLOQUE_INSTRUCCIONESFUNCION {$$=new NodeAst("Funcion",$1+" "+$2, count++);if($5!=null){$$.encontrarNodeAstAst($5)};}

    ;

METODO2 : VOID IDENTIFICADOR PARIZQ PARAMETROS PARDER BLOQUE_INSTRUCCIONESMETODO {$$=new NodeAst("Metodo",$1+" "+$2,count++);$$.encontrarNodeAstAst($4);if($6!=null){$$.encontrarNodeAstAst($6)};}
        | VOID IDENTIFICADOR PARIZQ  PARDER BLOQUE_INSTRUCCIONESMETODO {$$=new NodeAst("Metodo",$1+" "+$2,count++);if($5!=null){$$.encontrarNodeAstAst($5)};}
        |  VOID MAIN PARIZQ PARDER BLOQUE_INSTRUCCIONESMETODO {$$=new NodeAst("Main",$1+" "+$2,count++);if($5!=null){$$.encontrarNodeAstAst($5)};}

    ;

CLASE2 : CLASS IDENTIFICADOR BLOQUE_INSTRUCCIONESCLASE { $$ = new NodeAst("Clase", $1+" "+$2, count++);if($3!=null){$$.encontrarNodeAstAst($3)};}
    ;

SWITCH2 : SWITCH  CONDICION LLAVEIZQ CASE2 LLAVEDER {$$=new NodeAst("Sentencia",$1, count++);$$.listaIns.push($2);$$.encontrarNodeAstAst($4);}
        | SWITCH CONDICION LLAVEIZQ CASE2 DEFAULT2 LLAVEDER {$$=new NodeAst("Sentencia",$1, count++);$$.listaIns.push($2);$$.encontrarNodeAstAst($4);$$.listaIns.push($5);}

    ;

CASE2: CASE2 CASE EXPRESION DOSPUNTOS INSTRUCCIONESSWITCH {$$=$1;$$.push(new NodeAst("Sentencia",$2, count++));$$[$$.length-1].listaIns.push($3);if($5!=null){$$[$$.length-1].encontrarNodeAstAst($5)};}
    |CASE EXPRESION DOSPUNTOS INSTRUCCIONESSWITCH {$$=[];$$.push(new NodeAst("Sentencia",$1, count++));$$[0].listaIns.push($2);if($4!=null){$$[0].encontrarNodeAstAst($4)} ;}
    ;

DEFAULT2:  DEFAULT DOSPUNTOS  INSTRUCCIONESSWITCH {$$=new NodeAst("Sentencia",$1, count++);if($3!=null){$$.encontrarNodeAstAst($3)};}

    ;

DO2 : DO BLOQUE_INSTRUCCIONESFOR WHILE CONDICION PTCOMA {$$=new NodeAst("Sentencia",$1+$3, count++);if($2!=null){$$.encontrarNodeAstAst($2)};$$.listaIns.push($4);}
    ;

FOR2 : FOR PARIZQ DECLARACION EXPRESION PTCOMA CONDICIONFOR PARDER BLOQUE_INSTRUCCIONESFOR {$$=new NodeAst("Sentencia",$1, count++); $$.listaIns.push($3);$$.listaIns.push($4);$$.listaIns.push($6);if($8!=null){$$.encontrarNodeAstAst($8)};}
     | FOR PARIZQ ASIGNACION EXPRESION PTCOMA CONDICIONFOR PARDER BLOQUE_INSTRUCCIONESFOR  {$$=new NodeAst("Sentencia",$1, count++); $$.listaIns.push($3);$$.listaIns.push($4);$$.listaIns.push($6);if($8!=null){$$.encontrarNodeAstAst($8)};}
    ;


CONDICIONFOR : IDENTIFICADOR MAS MAS {$$ = new NodeAst("Asignacion",$1, count++); $$.listaIns.push(new NodeAst("Incremento",$2+$3, count++));}
     | IDENTIFICADOR MENOS MENOS {$$ = new NodeAst("Asignacion",$1, count++); $$.listaIns.push(new NodeAst("Decremento",$2+$3, count++));}
;

TIPO : STRING {$$ = $1;}
     | BOOLEAN {$$ = $1;}
     | CHAR {$$ = $1;}
     | DOUBLE {$$ = $1;}
     | INT {$$ = $1;}
;

DECLARACION : TIPO LISTAID IGUAL EXPRESION PTCOMA {$$=new NodeAst("Declaracion",$1, count++); $$.encontrarNodeAstAst($2);$$.listaIns.push($4);}
            | TIPO LISTAID PTCOMA {$$=new NodeAst("Declaracion",$1, count++); $$.encontrarNodeAstAst($2);}
            |
            ;



LISTAID: LISTAID COMA IDENTIFICADOR {$$=$1;$$.push(new NodeAst("Variable",$3, count++));}
        |IDENTIFICADOR {$$=[];$$.push(new NodeAst("Variable",$1, count++));}
        ;


ASIGNACION : IDENTIFICADOR IGUAL EXPRESION PTCOMA {$$=new NodeAst("Asignacion",$1, count++); $$.listaIns.push($3);}
            | IDENTIFICADOR MAS MAS PTCOMA {$$ = new NodeAst("Asignacion",$1, count++); $$.listaIns.push(new NodeAst("Incremento",$2+$3, count++));}
            | IDENTIFICADOR MENOS MENOS PTCOMA {$$ = new NodeAst("Asignacion",$1, count++); $$.listaIns.push(new NodeAst("Decremento",$2+$3, count++));}
    ;

WHILE2 : WHILE CONDICION BLOQUE_INSTRUCCIONESFOR { $$ = new NodeAst("Sentencia", $1, count++);$$.listaIns.push($2); if($3!=null){$$.encontrarNodeAstAst($3)};}
      ;

IF2 : IF CONDICION BLOQUE_INSTRUCCIONESIF { $$ = new NodeAst("Sentencia", $1, count++);$$.listaIns.push($2); if($3!=null){$$.encontrarNodeAstAst($3)};}
   | IF CONDICION BLOQUE_INSTRUCCIONESIF ELSE2 { $$ = new NodeAst("Sentencia", $1, count++);$$.listaIns.push($2); if($3!=null){$$.encontrarNodeAstAst($3)};$$.listaIns.push($4);}
   ;

ELSE2: ELSE BLOQUE_INSTRUCCIONESIF { $$ = new NodeAst("Sentencia", $1, count++); if($2!=null){$$.encontrarNodeAstAst($2)};}
     |ELSE IF2 { $$ = $2;}
    ;

CONDICION : PARIZQ EXPRESION PARDER { $$ = $2;}
          ;


BLOQUE_INSTRUCCIONES : LLAVEIZQ INSTRUCCIONES LLAVEDER
                     | LLAVEIZQ LLAVEDER
                     ;

BLOQUE_INSTRUCCIONESIF : LLAVEIZQ INSTRUCCIONESIF LLAVEDER {$$=$2}
                     | LLAVEIZQ LLAVEDER {$$=null;}
                     ;

BLOQUE_INSTRUCCIONESFOR : LLAVEIZQ INSTRUCCIONESFOR LLAVEDER  {$$=$2}
                     | LLAVEIZQ LLAVEDER {$$=null;}
                     ;


BLOQUE_INSTRUCCIONESCLASE : LLAVEIZQ INSTRUCCIONESDENTROCLASE LLAVEDER {$$=$2}
                     | LLAVEIZQ LLAVEDER {$$=null;}
                     ;

BLOQUE_INSTRUCCIONESMETODO : LLAVEIZQ INSTRUCCIONESMETODO LLAVEDER {$$=$2}
                     | LLAVEIZQ LLAVEDER {$$=null;}
                     ;

BLOQUE_INSTRUCCIONESFUNCION : LLAVEIZQ INSTRUCCIONESFUNCION RETURN EXPRESION PTCOMA LLAVEDER {$$=$2;$$.push(new NodeAst("Sentencia",$3,count++));$$[$$.length-1].listaIns.push($4);}
                     | LLAVEIZQ RETURN EXPRESION PTCOMA LLAVEDER {$$=[]; $$.push(new NodeAst("Sentencia",$2, count++));$$[0].listaIns.push($3);}
                     ;

PRINT : SOUT PARIZQ EXPRESION PARDER PTCOMA { $$ = new NodeAst("Imprimir", $1, count++);$$.listaIns.push($3);}
    | SOUTLN PARIZQ EXPRESION PARDER PTCOMA { $$ = new NodeAst("Imprimir", $1, count++);$$.listaIns.push($3);}
      ;

PARAMETROS : PARAMETROS COMA TIPO IDENTIFICADOR {$$=$1;$$.push(new NodeAst("Parametros",$3+" "+$4, count++));}
        | TIPO IDENTIFICADOR {$$=[];$$.push(new NodeAst("Parametros",$1+" "+$2, count++));}
        ;

IFM:IF CONDICION BLOQUE_INSTRUCCIONESIFM { $$ = new NodeAst("Sentencia", $1, count++);$$.listaIns.push($2); if($3!=null){$$.encontrarNodeAstAst($3)};}
   | IF CONDICION BLOQUE_INSTRUCCIONESIFM ELSEM { $$ = new NodeAst("Sentencia", $1, count++);$$.listaIns.push($2); if($3!=null){$$.encontrarNodeAstAst($3)};$$.listaIns.push($4);}
   ;


ELSEM: ELSE BLOQUE_INSTRUCCIONESIFM { $$ = new NodeAst("Sentencia", $1, count++); if($2!=null){$$.encontrarNodeAstAst($2)};}
    |ELSE IFM { $$ = $2;}
;

INSTRUCCIONESIFM: INSTRUCCIONESIFM INSTRUCCIONIFM {$$=$1;$$.push($2)}
                |INSTRUCCIONIFM {$$=[];$$.push($1)}
                ;

INSTRUCCIONIFM: PRINT {$$ = $1}
            | IFM {$$=$1}
            | WHILEM {$$=$1}
            | FORM  {$$=$1}
            | DOM   {$$=$1}
            | SWITCHM  {$$=$1}
            | IDENTIFICADOR PARIZQ LISTAEXPRESION PARDER PTCOMA {$$ = new NodeAst("Sentencia", $1, count++); $$.encontrarNodeAstAst($3)}
            | DECLARACION {$$=$1}
            | ASIGNACION {$$=$1}
            | RETURN PTCOMA { $$ = new NodeAst("Sentencia", $1, count++);}
            ;

BLOQUE_INSTRUCCIONESIFM : LLAVEIZQ INSTRUCCIONESIFM LLAVEDER {$$=$2}
                     | LLAVEIZQ LLAVEDER {$$=null;}
                     ;


WHILEM : WHILE CONDICION BLOQUE_INSTRUCCIONESFORM { $$ = new NodeAst("Sentencia", $1, count++);$$.listaIns.push($2); if($3!=null){$$.encontrarNodeAstAst($3)};}
      ;


BLOQUE_INSTRUCCIONESFORM : LLAVEIZQ INSTRUCCIONESFORM LLAVEDER {$$=$2}
                     | LLAVEIZQ LLAVEDER {$$=null;}
                     ;

INSTRUCCIONESFORM: INSTRUCCIONESFORM INSTRUCCIONFORM {$$=$1;$$.push($2)}
                |INSTRUCCIONFORM {$$=[];$$.push($1)}
                ;

INSTRUCCIONFORM: PRINT {$$ = $1}
            | IFM {$$ = $1}
            | WHILEM {$$ = $1}
            | FORM {$$ = $1}
            | DOM {$$ = $1}
            | SWITCHM {$$ = $1}
            | BREAK PTCOMA { $$ = new NodeAst("Sentencia", $1, count++);}
            | CONTINUE PTCOMA { $$ = new NodeAst("Sentencia", $1, count++);}
            | IDENTIFICADOR PARIZQ LISTAEXPRESION PARDER PTCOMA {$$ = new NodeAst("Sentencia", $1, count++); $$.encontrarNodeAstAst($3)}
            | DECLARACION {$$ = $1}
            | ASIGNACION {$$ = $1}
            | RETURN PTCOMA { $$ = new NodeAst("Sentencia", $1, count++);}
            ;

FORM : FOR PARIZQ DECLARACION EXPRESION PTCOMA CONDICIONFOR PARDER BLOQUE_INSTRUCCIONESFORM {$$=new NodeAst("Sentencia",$1, count++); $$.listaIns.push($3);$$.listaIns.push($4);$$.listaIns.push($6);if($8!=null){$$.encontrarNodeAstAst($8)};}
     | FOR PARIZQ ASIGNACION EXPRESION PTCOMA CONDICIONFOR PARDER BLOQUE_INSTRUCCIONESFORM {$$=new NodeAst("Sentencia",$1, count++); $$.listaIns.push($3);$$.listaIns.push($4);$$.listaIns.push($6);if($8!=null){$$.encontrarNodeAstAst($8)};}
     ;

DOM : DO BLOQUE_INSTRUCCIONESFORM WHILE CONDICION PTCOMA {$$=new NodeAst("Sentencia",$1+$3, count++);if($2!=null){$$.encontrarNodeAstAst($2)};$$.listaIns.push($4);}
    ;


SWITCHM : SWITCH  CONDICION LLAVEIZQ CASEM LLAVEDER {$$=new NodeAst("Sentencia",$1, count++);$$.listaIns.push($2);$$.encontrarNodeAstAst($4);}
        | SWITCH CONDICION LLAVEIZQ CASEM DEFAULTM LLAVEDER {$$=new NodeAst("Sentencia",$1, count++);$$.listaIns.push($2);$$.encontrarNodeAstAst($4);$$.listaIns.push($5);}

    ;

CASEM: CASEM CASE EXPRESION DOSPUNTOS INSTRUCCIONESSWITCHM {$$=$1;$$.push(new NodeAst("Sentencia",$2, count++));$$[$$.length-1].listaIns.push($3);if($5!=null){$$[$$.length-1].encontrarNodeAstAst($5)};}
    |CASE EXPRESION DOSPUNTOS INSTRUCCIONESSWITCHM {$$=[];$$.push(new NodeAst("Sentencia",$1, count++));$$[0].listaIns.push($2);if($4!=null){$$[0].encontrarNodeAstAst($4)} ;}
    ;


DEFAULTM:  DEFAULT DOSPUNTOS  INSTRUCCIONESSWITCHM {$$=new NodeAst("Sentencia",$1, count++);if($3!=null){$$.encontrarNodeAstAst($3)};}

    ;

INSTRUCCIONESSWITCHM: INSTRUCCIONESSWITCHM INSTRUCCIONSWITCHM {$$=$1;$$.push($2)}
                |INSTRUCCIONSWITCHM {$$=[];$$.push($1)}
                ;

INSTRUCCIONSWITCHM: PRINT {$$ = $1}
            | IFM {$$ = $1}
            | WHILEM  {$$ = $1}
            | FORM {$$ = $1}
            | DOM {$$ = $1}
            | SWITCHM {$$ = $1}
            | BREAK PTCOMA { $$ = new NodeAst("Sentencia", $1, count++);}
            |IDENTIFICADOR PARIZQ LISTAEXPRESION PARDER PTCOMA {$$ = new NodeAst("Sentencia", $1, count++); $$.encontrarNodeAstAst($3)}
            |DECLARACION {$$ = $1}
            |ASIGNACION {$$ = $1}
            |RETURN PTCOMA { $$ = new NodeAst("Sentencia", $1, count++);}
            ;


EXPRESION : MENOS EXPRESION %prec UMENOS
          | NOT EXPRESION	          { $$ = new NodeAst("Relacional", $1, count++);$$.listaIns.push($2);}
          | EXPRESION MAS EXPRESION	     {$$= new NodeAst("Artimetica",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION MENOS EXPRESION     {$$= new NodeAst("Artimetica",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION POR EXPRESION		    {$$= new NodeAst("Artimetica",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION DIVIDIDO EXPRESION	 {$$= new NodeAst("Artimetica",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION MENORQUE EXPRESION	 {$$= new NodeAst("Relacional",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION MAYORQUE EXPRESION	{$$= new NodeAst("Relacional",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION MAYORIGUALQUE EXPRESION	 {$$= new NodeAst("Relacional",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION MENORIGUALQUE EXPRESION	  {$$= new NodeAst("Relacional",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION IGUALDAD EXPRESION	{$$= new NodeAst("Relacional",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION DISTINTO EXPRESION	{$$= new NodeAst("Relacional",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION OR EXPRESION	    {$$= new NodeAst("Relacional",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION AND EXPRESION	   {$$= new NodeAst("Relacional",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION POTENCIA EXPRESION	{$$= new NodeAst("Artimetica",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION MODULO EXPRESION	  {$$= new NodeAst("Artimetica",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | DECIMAL   { $$ = new NodeAst("Primitivo", $1, count++);}
          | ENTERO	  { $$ = new NodeAst("Primitivo", $1, count++);}
          | TRUE	  { $$ = new NodeAst("Primitivo", $1, count++);}
          | FALSE	  { $$ = new NodeAst("Primitivo", $1,  count++);}
          | CADENA    { $$ = new NodeAst("Primitivo", $1,  count++);}
          | CARACTER  { $$ = new NodeAst("Primitivo", $1,  count++);}
          | IDENTIFICADOR PARIZQ LISTAEXPRESION PARDER 	{$$ = new NodeAst("Variable", $1, count++); $$.encontrarNodeAstAst($3)}
          | IDENTIFICADOR PARIZQ PARDER 		    { $$ = new NodeAst("Variable", $1, count++);}
          | IDENTIFICADOR	{ $$ = new NodeAst("Variable", $1,  count++);}
          ;