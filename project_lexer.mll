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
let chaineCaracs =  "\""['"']*"\""

rule main = parse
  | "//" {comment lexbuf}
 
  | '\n'  {main lexbuf}
  | blank {main lexbuf}
  
  | flottant as x {}
  | entier as x {}
  
  | couleur as x {}
  | booleen as x {}
  | chaineCaracs as x {}
  
  | eof {EOF}
  | _ {}

and comment = parse
  | '\n' {main lexbuf}
  | eof  {EOF}
  | _    {comment lexbuf}

{}
