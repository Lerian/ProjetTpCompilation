%{
	open Complex_types
	open Variables

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
%token <string> STRING COLOR VAR

%token PAR_G PAR_D VIRG

%token AFF

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
	
	|	affectation {}
	
	|	ERROR {print_string "error"}
;

affectation:
	VAR AFF entier {creation_var_entier $1 $3}
	|	VAR AFF flottant {creation_var_flottant $1 $3}
	|	VAR AFF booleen {creation_var_booleen $1 $3}
	|	VAR AFF texte {creation_var_texte $1 $3}
	|	VAR AFF cercle {creation_var_cercle $1 $3}
	|	VAR AFF rectangle {creation_var_rectangle $1 $3}
	|	VAR AFF ligne {creation_var_ligne $1 $3}
	|	VAR AFF STRING {creation_var_string $1 $3}
	|	VAR AFF COLOR {creation_var_color $1 $3}
	|	VAR AFF point {creation_var_point $1 $3}
	|	VAR AFF image {creation_var_image $1 $3}
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
	point {print_point $1}
	|	texte {print_text $1}
	|	cercle {print_circle $1}
	|	rectangle {print_rectangle $1}
	|	ligne {print_line $1}
	|	image {print_image $1}
;

point:
	POINT PAR_G flottant VIRG flottant PAR_D {create_point $3 $5}
;

image:
	IMAGE PAR_G entier VIRG entier PAR_D {create_image $3 $5}
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
;

ligne:
	LIGNE PAR_G flottant VIRG flottant VIRG flottant VIRG flottant PAR_D {create_line $3 $5 $7 $9 "black" 1}
	|	LIGNE PAR_G flottant VIRG flottant VIRG flottant VIRG flottant VIRG COLOR VIRG entier PAR_D {create_line $3 $5 $7 $9 $11 $13}
