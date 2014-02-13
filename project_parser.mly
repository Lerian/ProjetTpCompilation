%{
  let variable_number = ref 1
  
  let print_operation x op y =
    let variable = "x" ^ (string_of_int !variable_number) in
    begin
     incr variable_number;
     Printf.printf "%s := %s %c %s\n" variable x op y;
     variable
    end
%}

%token EOF
%token PLUS MINUS MUL DIV
%token BEGIN_PAR END_PAR
%token <float> VAL

%left PLUS MINUS
%left MUL DIV

%start main
%type <unit> main

%%

main:
  expression EOF {}
;

expression:
    operand PLUS operand {print_operation $1 '+' $3}
  | operand MINUS operand {print_operation $1 '-' $3}
  | operand MUL operand {print_operation $1 '*' $3}
  | operand DIV operand {print_operation $1 '/' $3}
  | BEGIN_PAR expression END_PAR {$2}
;

operand:
    VAL {string_of_float $1}
  | expression {$1}
;
