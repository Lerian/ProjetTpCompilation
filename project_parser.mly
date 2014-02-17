%{
	open Complex_types

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

%token PAR_G PAR_D VIRG

%token CERCLE RECTANGLE POINT LIGNE TEXTE IMAGE

%token INF SUP INF_EGAL SUP_EGAL

%left INF SUP INF_EGAL SUP_EGAL

%token AND OR

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
	|	booleen {print_bool $1}
	|	STRING {print_string $1}
	|	COLOR {print_color $1}
	
	|	figure {}
	
	|	ERROR {print_string "error"}
;

entier:
	INT {$1}
	|	entier PLUS entier {(+) $1 $3}
	|	entier MOINS entier {(-) $1 $3}
	|	entier MUL entier {( * ) $1 $3}
	|	entier DIV entier {(/) $1 $3}
	|	entier MOD entier {(mod) $1 $3}
	
	|	PAR_G entier PAR_D {$2}
;

flottant:
	FLOAT {$1}
	|	flottant PLUS flottant {(+.) $1 $3}
	|	flottant MOINS flottant {(-.) $1 $3}
	|	flottant MUL flottant {( *. ) $1 $3}
	|	flottant DIV flottant {(/.) $1 $3}
	
	|	PAR_G flottant PAR_D {$2}
;

booleen:
	BOOL {$1}
	|	entier INF entier {(<) $1 $3}
	|	entier SUP entier {(>) $1 $3}
	|	entier INF_EGAL entier {(<=) $1 $3}
	|	entier SUP_EGAL entier {(>=) $1 $3}
	
	|	flottant INF flottant {(<) $1 $3}
	|	flottant SUP flottant {(>) $1 $3}
	|	flottant INF_EGAL flottant {(<=) $1 $3}
	|	flottant SUP_EGAL flottant {(>=) $1 $3}
	
	|	booleen AND booleen { (&&) $1 $3}
	|	booleen OR booleen { (||) $1 $3}
	
	|	PAR_G booleen PAR_D {$2}
;

figure:
	POINT PAR_G flottant VIRG flottant PAR_D {let p={p_x=$3;p_y=$5} in print_point p}
	|	LIGNE PAR_G flottant VIRG flottant VIRG flottant VIRG flottant PAR_D {let p1={p_x=$3;p_y=$5} in let p2={p_x=$7;p_y=$9} in let l={l_origine=p1;l_destination=p2} in print_line l}
	|	texte {print_text $1}
	|	cercle {print_circle $1}
	|	rectangle {print_rectangle $1}
	|	IMAGE PAR_G entier VIRG entier PAR_D {let i={i_width=$3;i_height=$5} in print_image i}
;

texte:
	TEXTE PAR_G STRING VIRG flottant VIRG flottant PAR_D {create_text $3 $5 $7 "black" 12}
	|	TEXTE PAR_G STRING VIRG flottant VIRG flottant VIRG COLOR VIRG entier PAR_D {create_text $3 $5 $7 $9 $11}
;

cercle:
	CERCLE PAR_G flottant VIRG flottant VIRG flottant PAR_D {create_circle $3 $5 $7 "black" "white" 1}
	|	CERCLE PAR_G flottant VIRG flottant VIRG flottant VIRG COLOR VIRG COLOR VIRG entier PAR_D {create_circle $3 $5 $7 $9 $11 $13}
;

rectangle:
	RECTANGLE PAR_G flottant VIRG flottant VIRG flottant VIRG flottant PAR_D {create_rectangle $3 $5 $7 $9 "black" "white" 1}
	|	RECTANGLE PAR_G flottant VIRG flottant VIRG flottant VIRG flottant VIRG COLOR VIRG COLOR VIRG entier PAR_D {create_rectangle $3 $5 $7 $9 $11 $13 $15}
