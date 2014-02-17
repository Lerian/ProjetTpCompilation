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
let operateurBooleen = "and"|"or"




rule main = parse
  | "#" {comment lexbuf}
 
  | '\n'  {main lexbuf}
  | blank {main lexbuf}
  
  (** Les types primitifs *)
  | flottant as x {FLOAT(float_of_string x)}
  | entier as x {INT(int_of_string x)}
  | couleur as x {COLOR x}
  | booleen as x {BOOL(bool_of_string x)}
  | chaineCaracs as x {STRING x}
  
  (** Les opérateurs arithmétiques *)
  | '+' {PLUS}
  | '-' {MOINS}
  | '*' {MUL}
  | '/' {DIV}
  | '%' {MOD}
  
  (** Les opérateurs de comparaison *)
  |	'<' {INF}
  | '>' {SUP}
  |	"<=" {INF_EGAL}
  | ">=" {SUP_EGAL}
  
  (** Les opérateurs booléens *)
  | "and" {AND}
  | "or" {OR}
  
  (** La ponctuation *)
  | '(' {PAR_G}
  | ')' {PAR_D}
  | ',' {VIRG}
  
  (** Les types complexes *)
  | "Circle" {CERCLE}
  | "Rectangle" {RECTANGLE}
  | "Point" {POINT}
  
  | eof { EOF }
  | _ {ERROR}




and comment = parse
  | '\n' {main lexbuf}
  | eof  {EOF}
  | _    {comment lexbuf}

{}
