%{
	let print_float x =
		begin
			Printf.printf "float := %f\n" x;
		end

	let print_int x =
		begin
			Printf.printf "int := %d\n" x;
		end

	let print_bool x =
		begin
			if x then
				begin
					Printf.printf "bool := true\n";
				end
			else
				begin
					Printf.printf "bool := false\n";
				end
		end

	let print_string x =
		begin
			Printf.printf "string := %s\n" x;
		end

	let print_color x =
		begin
			Printf.printf "color := %s\n" x;
		end
%}

%token EOF
%token ERROR

%token <float> FLOAT
%token <int> INT
%token <bool> BOOL
%token <string> STRING COLOR

%token PLUS MOINS MUL DIV MOD

%left PLUS MOINS
%left MUL DIV MOD

%start main
%type <unit> main

%%

main:
	expressions EOF {}
;

expressions:
	expression {}
	|	expression expressions {}

expression:
	flottant {print_float $1}
	|	entier {print_int $1}
	|	BOOL {print_bool $1}
	|	STRING {print_string $1}
	|	COLOR {print_color $1}
	
	|	ERROR {print_string "error"}
;

entier:
	INT {$1}
	|	entier PLUS entier {(+) $1 $3}
	|	entier MOINS entier {(-) $1 $3}
	|	entier MUL entier {( * ) $1 $3}
	|	entier DIV entier {(/) $1 $3}
	|	entier MOD entier {(mod) $1 $3}
;

flottant:
	FLOAT {$1}
	|	flottant PLUS flottant {(+.) $1 $3}
	|	flottant MOINS flottant {(-.) $1 $3}
	|	flottant MUL flottant {( *. ) $1 $3}
	|	flottant DIV flottant {(/.) $1 $3}
;
