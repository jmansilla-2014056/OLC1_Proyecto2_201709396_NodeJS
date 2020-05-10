%lex

%options case-sensitive

%%

\s+											// se ignoran espacios en blanco
"//".*										// comentario simple línea se ignora
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]			// comentario multiple líneas se ignora

\\ VARIABLES
"int"               return 'INT';
"double"            return 'DOUBLE';
"boolean"           return 'BOOLEAN';
"char"              return 'CHAR';
"String"            return "STRING";

\\OPERACIONES RELACIONALES
"=="                return 'IGUALDAD';
"!="                return 'DISTINTO';
">="                return 'MAYOROIGUAL';
"<="                return 'MENOROIGUAL';
"<"                 return 'MENORQUE';
">"                 return 'MAYORQUE';
"="                 return ''

\\OPERACIONES LOGICAS
"&&"                return 'AND';
"||"                return 'OR';
"!"                 return "NOT";


\\ OPERACION ARITEMETICAS
"++"                return 'MASMAS';
"--"                return 'MENOSMENOS'
"+"                 return 'MAS';
"-"                 return 'MENOS';
"*"                 return 'POR';
"/"                 return 'DIVISION';
"^"                 return 'POTENCIA';
"%"                 return 'PORCENTAJE';

\\ OTROS SIMBOLOS
":"					return 'DOSPTS';
";"					return 'PTCOMA';
"{"					return 'ALLAVES';
"}"					return 'CLLAVES';
"("					return 'APAREN';
")"					return 'CPAREN';

\\
"import"            return 'IMPORT';
"class"             return 'CLASS';




