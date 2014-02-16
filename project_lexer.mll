{
  open Lexing
  open Project_parser
}

let blank = [' ' '\t' '\r']
let digit = ['0'-'9']

(** Types primitifs *)
let flottant = digit+'.'digit+
let entier = digit+
let couleur = "red"|"blue"|"yellow"|"green"|"black"|"white"
let booleen = "true"|"false"
let chaineCaracs =  "\""[^'"']*"\""

(** Opérateurs *)
let operateurComparaison = "<"|">"|"<="|">="
let operateurBooleen = "and"|"or"

rule main = parse
  | "#" {comment lexbuf}
 
  | '\n'  {main lexbuf}
  | blank {main lexbuf}
  
  | flottant as x {FLOAT(float_of_string x)}
  | entier as x {INT(int_of_string x)}
  
  | couleur as x {COLOR x}
  | booleen as x {BOOL(bool_of_string x)}
  | chaineCaracs as x {STRING x}
  
  | '+' {PLUS}
  | '-' {MOINS}
  | '*' {MUL}
  | '/' {DIV}
  | '%' {MOD}
  
  
  | eof { EOF }
  | _ {ERROR}

and comment = parse
  | '\n' {main lexbuf}
  | eof  {EOF}
  | _    {comment lexbuf}

{}
