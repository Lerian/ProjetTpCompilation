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
%token <string> STRING
%token <string> COLOR

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
	FLOAT {print_float $1}
	|	INT {print_int $1}
	|	BOOL {print_bool $1}
	|	STRING {print_string $1}
	|	COLOR {print_color $1}
	|	ERROR {print_string "error"}
;
