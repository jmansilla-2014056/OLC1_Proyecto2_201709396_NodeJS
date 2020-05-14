/**
 * Ejemplo mi primer proyecto con Jison utilizando NodeAstjs en Ubuntu
 */


%{
    const {NodeAst} = require('../treeAST/NodeAst');
    var count = 0;
    var prueba = "puto"
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

"int"                   return 'int';
"double"                return 'double';
"boolean"               return 'boolean';
"char"                  return 'char';
"String"                return 'string';


"if"                    return 'if';
"else"                  return 'else';
"switch"                return 'switch';
"case"                  return 'case';
"while"                 return 'while';
"do"                    return 'do';
"for"                   return 'for';
"void"                  return 'void';
"return"                return 'return';
"break"                 return 'break';
"main"                  return 'main';
"continue"              return'continue';
"System.out.println"    return'soutln';
"System.out.print"      return'sout';


"import"                return'import';
"class"                 return'class';
"true"                  return'true';
"false"                 return'false';
"default"               return'default';

"{"                     return 'lizquierdo';
"}"                     return 'lderecho';
";"                     return 'puntocoma';
"("                     return 'pizquierdo';
")"                     return 'pderecho';
"["                     return 'cizquierdo';
"]"                     return 'cderecho';
","                     return 'coma';
":"                     return 'dospuntos';

"&&"                    return 'and';
"||"                    return 'or';
"!="                    return 'distinto';
"=="                    return 'igualdad';
">="                    return 'mayorigualque';
"<="                    return 'menorigualque';
">"                     return 'mayorque';
"<"                     return 'menorque';


"="                     return 'igual';


"!"                     return 'not';


"+"                     return 'mas';
"-"                     return 'menos';
"*"                     return 'por';
"/"                     return 'dividido';
"%"                     return 'modulo';
"^"                     return 'potencia';

[0-9]+("."[0-9]+)       return 'decimal';

[0-9]+\b                return 'entero';




(\"[^"]*\")             return 'cadena';
(\'[^']\')              return'caracter';



([a-zA-Z]|[_])[a-zA-Z0-9_]* return 'identificador';



<<EOF>>                 return 'EOF';

.                       { console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); }
/lex

/* Asociación de operadores y precedencia */


%left or
%left and
%left igualdad, distinto
%left mayorigualque, menorigualque, menorque, mayorque
%left mas, menos
%left por, dividido, modulo
%left potencia
%right not
%left UMENOS

%start INICIO

%% /* Definición de la gramática */

INICIO : IMPORTSYCLASES EOF {$$=$1; return $$;}
        |error { console.error('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column); }
;

IMPORTSYCLASES: IMPORT2 CLASE2 {$$=new NodeAst("Raiz","Raiz",count++); $$.encontrarNodeAst($1);$$.listaIns.push($2);
            |CLASE2 {$$ = new NodeAst("Raiz","Raiz",count++); $$.encontrarNodeAst($1); }
            ;

IMPORT2: IMPORT2 import identificador puntocoma {$$=$1;$$.push(new NodeAst("Import",$2+" "+$3,count++))}
        |import identificador puntocoma {$$=[];$$.push(new NodeAst("Import",$1+" "+$2,count++))}
        ;

CLASE2 : class identificador BLOQUE_INSTRUCCIONESCLASE { $$ = new NodeAst("Clase", $1+" "+$2, count++);if($3!=null){$$.encontrarNodeAst($3)};}
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
            | CLASE2
;


INSTRUCCIONESCLASE : INSTRUCCIONESCLASE INSTRUCCIONCLASE
              | INSTRUCCIONCLASE
              ;

INSTRUCCIONCLASE : CLASE2
;

INICIO2: IMPORTSYCLASES {$$= new NodeAst("Raiz","Raiz",count++);$$.listaIns.push($1)}
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
            | identificador pizquierdo LISTAEXPRESION pderecho puntocoma {$$ = new NodeAst("Sentencia", $1,count++); $$.encontrarNodeAst($3)}
            | return puntocoma {$$ = new NodeAst("Sentencia",$1,count++);}

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
            | identificador pizquierdo LISTAEXPRESION pderecho puntocoma {$$ = new NodeAst("Sentencia", $1,count++); $$.encontrarNodeAst($3)}



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
            | identificador pizquierdo LISTAEXPRESION pderecho puntocoma  {$$ = new NodeAst("Sentencia", $1,count++); $$.encontrarNodeAst($3)}
            | DECLARACION {$$ = $1}
            | ASIGNACION {$$ = $1}
            | return EXPRESION puntocoma { $$ = new NodeAst("Sentencia", $1,count++);$$.listaIns.push($2);}
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
            | break puntocoma { $$ = new NodeAst("Sentencia", $1,count++);}
            | continue puntocoma { $$ = new NodeAst("Sentencia", $1,count++);}
            | identificador pizquierdo LISTAEXPRESION pderecho puntocoma {$$ = new NodeAst("Sentencia", $1,count++); $$.encontrarNodeAst($3)}
            | DECLARACION {$$ = $1}
            | ASIGNACION {$$ = $1}
            | return EXPRESION puntocoma { $$ = new NodeAst("Sentencia", $1,count++);$$.listaIns.push($2);}
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
            | break puntocoma { $$ = new NodeAst("Sentencia", $1,count++);}
            |identificador pizquierdo LISTAEXPRESION pderecho puntocoma {$$ = new NodeAst("Sentencia", $1,count++); $$.encontrarNodeAst($3)}
            |DECLARACION {$$ = $1}
            |ASIGNACION {$$ = $1}
            |return EXPRESION puntocoma { $$ = new NodeAst("Sentencia", $1,count++);$$.listaIns.push($2);}
            ;

LISTAEXPRESION: LISTAEXPRESION coma EXPRESION  {$$=$1;$$.push($3)}
                |EXPRESION {$$=[];$$.push($1)}
                ;


FUNCION2: TIPO identificador pizquierdo PARAMETROS pderecho BLOQUE_INSTRUCCIONESFUNCION {$$=new NodeAst("Funcion",$1+" "+$2, count++);$$.encontrarNodeAst($4);if($6!=null){$$.encontrarNodeAst($6)};}
        | TIPO identificador pizquierdo  pderecho BLOQUE_INSTRUCCIONESFUNCION {$$=new NodeAst("Funcion",$1+" "+$2, count++);if($5!=null){$$.encontrarNodeAst($5)};}

    ;

METODO2 : void identificador pizquierdo PARAMETROS pderecho BLOQUE_INSTRUCCIONESMETODO {$$=new NodeAst("Metodo",$1+" "+$2,count++);$$.encontrarNodeAst($4);if($6!=null){$$.encontrarNodeAst($6)};}
        | void identificador pizquierdo  pderecho BLOQUE_INSTRUCCIONESMETODO {$$=new NodeAst("Metodo",$1+" "+$2,count++);if($5!=null){$$.encontrarNodeAst($5)};}
        |  void main pizquierdo pderecho BLOQUE_INSTRUCCIONESMETODO {$$=new NodeAst("Main",$1+" "+$2,count++);if($5!=null){$$.encontrarNodeAst($5)};}

    ;

SWITCH2 : switch  CONDICION lizquierdo CASE2 lderecho {$$=new NodeAst("Sentencia",$1, count++);$$.listaIns.push($2);$$.encontrarNodeAst($4);}
        | switch CONDICION lizquierdo CASE2 DEFAULT2 lderecho {$$=new NodeAst("Sentencia",$1, count++);$$.listaIns.push($2);$$.encontrarNodeAst($4);$$.listaIns.push($5);}

    ;

CASE2: CASE2 case EXPRESION dospuntos INSTRUCCIONESSWITCH {$$=$1;$$.push(new NodeAst("Sentencia",$2, count++));$$[$$.length-1].listaIns.push($3);if($5!=null){$$[$$.length-1].encontrarNodeAst($5)};}
    |case EXPRESION dospuntos INSTRUCCIONESSWITCH {$$=[];$$.push(new NodeAst("Sentencia",$1, count++));$$[0].listaIns.push($2);if($4!=null){$$[0].encontrarNodeAst($4)} ;}
    ;

DEFAULT2:  default dospuntos  INSTRUCCIONESSWITCH {$$=new NodeAst("Sentencia",$1, count++);if($3!=null){$$.encontrarNodeAst($3)};}

    ;

DO2 : do BLOQUE_INSTRUCCIONESFOR while CONDICION puntocoma {$$=new NodeAst("Sentencia",$1+$3, count++);if($2!=null){$$.encontrarNodeAst($2)};$$.listaIns.push($4);}
    ;

FOR2 : for pizquierdo DECLARACION EXPRESION puntocoma CONDICIONFOR pderecho BLOQUE_INSTRUCCIONESFOR {$$=new NodeAst("Sentencia",$1, count++); $$.listaIns.push($3);$$.listaIns.push($4);$$.listaIns.push($6);if($8!=null){$$.encontrarNodeAst($8)};}
     | for pizquierdo ASIGNACION EXPRESION puntocoma CONDICIONFOR pderecho BLOQUE_INSTRUCCIONESFOR  {$$=new NodeAst("Sentencia",$1, count++); $$.listaIns.push($3);$$.listaIns.push($4);$$.listaIns.push($6);if($8!=null){$$.encontrarNodeAst($8)};}
    ;


CONDICIONFOR : identificador mas mas {$$ = new NodeAst("Asignacion",$1, count++); $$.listaIns.push(new NodeAst("Incremento",$2+$3, count++));}
     | identificador menos menos {$$ = new NodeAst("Asignacion",$1, count++); $$.listaIns.push(new NodeAst("Decremento",$2+$3, count++));}
;

TIPO : string {$$ = $1;}
     | boolean {$$ = $1;}
     | char {$$ = $1;}
     | double {$$ = $1;}
     | int {$$ = $1;}
     ;

DECLARACION : TIPO LISTAID igual EXPRESION puntocoma {$$=new NodeAst("Declaracion",$1, count++); $$.encontrarNodeAst($2);$$.listaIns.push($4);}
            | TIPO LISTAID puntocoma {$$=new NodeAst("Declaracion",$1, count++); $$.encontrarNodeAst($2);}
            |
            ;



LISTAID: LISTAID coma identificador {$$=$1;$$.push(new NodeAst("Variable",$3, count++));}
        |identificador {$$=[];$$.push(new NodeAst("Variable",$1, count++));}
        ;


ASIGNACION : identificador igual EXPRESION puntocoma {$$=new NodeAst("Asignacion",$1, count++); $$.listaIns.push($3);}
            | identificador mas mas puntocoma {$$ = new NodeAst("Asignacion",$1, count++); $$.listaIns.push(new NodeAst("Incremento",$2+$3, count++));}
            | identificador menos menos puntocoma {$$ = new NodeAst("Asignacion",$1, count++); $$.listaIns.push(new NodeAst("Decremento",$2+$3, count++));}
    ;

WHILE2 : while CONDICION BLOQUE_INSTRUCCIONESFOR { $$ = new NodeAst("Sentencia", $1, count++);$$.listaIns.push($2); if($3!=null){$$.encontrarNodeAst($3)};}
      ;

IF2 : if CONDICION BLOQUE_INSTRUCCIONESIF { $$ = new NodeAst("Sentencia", $1, count++);$$.listaIns.push($2); if($3!=null){$$.encontrarNodeAst($3)};}
   | if CONDICION BLOQUE_INSTRUCCIONESIF ELSE2 { $$ = new NodeAst("Sentencia", $1, count++);$$.listaIns.push($2); if($3!=null){$$.encontrarNodeAst($3)};$$.listaIns.push($4);}
   ;

ELSE2: else BLOQUE_INSTRUCCIONESIF { $$ = new NodeAst("Sentencia", $1, count++); if($2!=null){$$.encontrarNodeAst($2)};}
     |else IF2 { $$ = $2;}
    ;

CONDICION : pizquierdo EXPRESION pderecho { $$ = $2;}
          ;


BLOQUE_INSTRUCCIONES : lizquierdo INSTRUCCIONES lderecho
                     | lizquierdo lderecho
                     ;

BLOQUE_INSTRUCCIONESIF : lizquierdo INSTRUCCIONESIF lderecho {$$=$2}
                     | lizquierdo lderecho {$$=null;}
                     ;

BLOQUE_INSTRUCCIONESFOR : lizquierdo INSTRUCCIONESFOR lderecho  {$$=$2}
                     | lizquierdo lderecho {$$=null;}
                     ;

BLOQUE_INSTRUCCIONESCLASE : lizquierdo INSTRUCCIONESDENTROCLASE FIN {$$=$2}
                     | lizquierdo lderecho {$$=null;}
                     ;

BLOQUE_INSTRUCCIONESMETODO : lizquierdo INSTRUCCIONESMETODO lderecho {$$=$2}
                     | lizquierdo lderecho {$$=null;}
                     ;

BLOQUE_INSTRUCCIONESFUNCION : lizquierdo INSTRUCCIONESFUNCION return EXPRESION puntocoma lderecho {$$=$2;$$.push(new NodeAst("Sentencia",$3,count++));$$[$$.length-1].listaIns.push($4);}
                     | lizquierdo return EXPRESION puntocoma lderecho {$$=[]; $$.push(new NodeAst("Sentencia",$2, count++));$$[0].listaIns.push($3);}
                     ;

PRINT : sout pizquierdo EXPRESION pderecho puntocoma { $$ = new NodeAst("Imprimir", $1, count++);$$.listaIns.push($3);}
    | soutln pizquierdo EXPRESION pderecho puntocoma { $$ = new NodeAst("Imprimir", $1, count++);$$.listaIns.push($3);}
      ;

PARAMETROS : PARAMETROS coma TIPO identificador {$$=$1;$$.push(new NodeAst("Parametros",$3+" "+$4, count++));}
        | TIPO identificador {$$=[];$$.push(new NodeAst("Parametros",$1+" "+$2, count++));}
        ;

IFM:if CONDICION BLOQUE_INSTRUCCIONESIFM { $$ = new NodeAst("Sentencia", $1, count++);$$.listaIns.push($2); if($3!=null){$$.encontrarNodeAst($3)};}
   | if CONDICION BLOQUE_INSTRUCCIONESIFM ELSEM { $$ = new NodeAst("Sentencia", $1, count++);$$.listaIns.push($2); if($3!=null){$$.encontrarNodeAst($3)};$$.listaIns.push($4);}
   ;


ELSEM: else BLOQUE_INSTRUCCIONESIFM { $$ = new NodeAst("Sentencia", $1, count++); if($2!=null){$$.encontrarNodeAst($2)};}
    |else IFM { $$ = $2;}
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
            | identificador pizquierdo LISTAEXPRESION pderecho puntocoma {$$ = new NodeAst("Sentencia", $1, count++); $$.encontrarNodeAst($3)}
            | DECLARACION {$$=$1}
            | ASIGNACION {$$=$1}
            | return puntocoma { $$ = new NodeAst("Sentencia", $1, count++);}
            ;

BLOQUE_INSTRUCCIONESIFM : lizquierdo INSTRUCCIONESIFM lderecho {$$=$2}
                     | lizquierdo lderecho {$$=null;}
                     ;


WHILEM : while CONDICION BLOQUE_INSTRUCCIONESFORM { $$ = new NodeAst("Sentencia", $1, count++);$$.listaIns.push($2); if($3!=null){$$.encontrarNodeAst($3)};}
      ;


BLOQUE_INSTRUCCIONESFORM : lizquierdo INSTRUCCIONESFORM lderecho {$$=$2}
                     | lizquierdo lderecho {$$=null;}
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
            | break puntocoma { $$ = new NodeAst("Sentencia", $1, count++);}
            | continue puntocoma { $$ = new NodeAst("Sentencia", $1, count++);}
            | identificador pizquierdo LISTAEXPRESION pderecho puntocoma {$$ = new NodeAst("Sentencia", $1, count++); $$.encontrarNodeAst($3)}
            | DECLARACION {$$ = $1}
            | ASIGNACION {$$ = $1}
            | return puntocoma { $$ = new NodeAst("Sentencia", $1, count++);}
            ;

FORM : for pizquierdo DECLARACION EXPRESION puntocoma CONDICIONFOR pderecho BLOQUE_INSTRUCCIONESFORM {$$=new NodeAst("Sentencia",$1, count++); $$.listaIns.push($3);$$.listaIns.push($4);$$.listaIns.push($6);if($8!=null){$$.encontrarNodeAst($8)};}
     | for pizquierdo ASIGNACION EXPRESION puntocoma CONDICIONFOR pderecho BLOQUE_INSTRUCCIONESFORM {$$=new NodeAst("Sentencia",$1, count++); $$.listaIns.push($3);$$.listaIns.push($4);$$.listaIns.push($6);if($8!=null){$$.encontrarNodeAst($8)};}
    ;

DOM : do BLOQUE_INSTRUCCIONESFORM while CONDICION puntocoma {$$=new NodeAst("Sentencia",$1+$3, count++);if($2!=null){$$.encontrarNodeAst($2)};$$.listaIns.push($4);}
    ;


SWITCHM : switch  CONDICION lizquierdo CASEM lderecho {$$=new NodeAst("Sentencia",$1, count++);$$.listaIns.push($2);$$.encontrarNodeAst($4);}
        | switch CONDICION lizquierdo CASEM DEFAULTM lderecho {$$=new NodeAst("Sentencia",$1, count++);$$.listaIns.push($2);$$.encontrarNodeAst($4);$$.listaIns.push($5);}

    ;

CASEM: CASEM case EXPRESION dospuntos INSTRUCCIONESSWITCHM {$$=$1;$$.push(new NodeAst("Sentencia",$2, count++));$$[$$.length-1].listaIns.push($3);if($5!=null){$$[$$.length-1].encontrarNodeAst($5)};}
    |case EXPRESION dospuntos INSTRUCCIONESSWITCHM {$$=[];$$.push(new NodeAst("Sentencia",$1, count++));$$[0].listaIns.push($2);if($4!=null){$$[0].encontrarNodeAst($4)} ;}
    ;


DEFAULTM:  default dospuntos  INSTRUCCIONESSWITCHM {$$=new NodeAst("Sentencia",$1, count++);if($3!=null){$$.encontrarNodeAst($3)};}

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
            | break puntocoma { $$ = new NodeAst("Sentencia", $1, count++);}
            |identificador pizquierdo LISTAEXPRESION pderecho puntocoma {$$ = new NodeAst("Sentencia", $1, count++); $$.encontrarNodeAst($3)}
            |DECLARACION {$$ = $1}
            |ASIGNACION {$$ = $1}
            |return puntocoma { $$ = new NodeAst("Sentencia", $1, count++);}
            ;


EXPRESION : menos EXPRESION %prec UMENOS
          | not EXPRESION	          { $$ = new NodeAst("Relacional", $1, count++);$$.listaIns.push($2);}
          | EXPRESION mas EXPRESION	     {$$= new NodeAst("Artimetica",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION menos EXPRESION     {$$= new NodeAst("Artimetica",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION por EXPRESION		    {$$= new NodeAst("Artimetica",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION dividido EXPRESION	 {$$= new NodeAst("Artimetica",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION menorque EXPRESION	 {$$= new NodeAst("Relacional",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION mayorque EXPRESION	{$$= new NodeAst("Relacional",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION mayorigualque EXPRESION	 {$$= new NodeAst("Relacional",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION menorigualque EXPRESION	  {$$= new NodeAst("Relacional",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION igualdad EXPRESION	{$$= new NodeAst("Relacional",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION distinto EXPRESION	{$$= new NodeAst("Relacional",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION or EXPRESION	    {$$= new NodeAst("Relacional",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION and EXPRESION	   {$$= new NodeAst("Relacional",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION potencia EXPRESION	{$$= new NodeAst("Artimetica",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | EXPRESION modulo EXPRESION	  {$$= new NodeAst("Artimetica",$2, count++);$$.listaIns.push($1);$$.listaIns.push($3);}
          | decimal   { $$ = new NodeAst("Primitivo", $1, count++);}
          | entero	  { $$ = new NodeAst("Primitivo", $1, count++);}
          | true	  { $$ = new NodeAst("Primitivo", $1, count++);}
          | false	  { $$ = new NodeAst("Primitivo", $1,  count++);}
          | cadena    { $$ = new NodeAst("Primitivo", $1,  count++);}
          | caracter  { $$ = new NodeAst("Primitivo", $1,  count++);}
          | identificador pizquierdo LISTAEXPRESION pderecho 	{$$ = new NodeAst("Variable", $1, count++); $$.encontrarNodeAst($3)}
          | identificador pizquierdo pderecho 		    { $$ = new NodeAst("Variable", $1, count++);}
          | identificador	{ $$ = new NodeAst("Variable", $1,  count++);}

          ;