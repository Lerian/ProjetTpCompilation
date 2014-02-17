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
	
	let print_circle c =
		begin
			Printf.printf "Cercle: x = %f y = %f radius = %f\n" c.centre.x c.centre.y c.radius;
		end
	
	let print_rectangle r =
		begin
			Printf.printf "Rectangle: x = %f y = %f width = %f height = %f\n" r.coinHG.x r.coinHG.y r.width r.height;
		end
	
	let print_point p =
		begin
			Printf.printf "Point: x = %f y = %f\n" p.x p.y;
		end
	
	let print_line l =
		begin
			Printf.printf "Ligne: x1 = %f y1 = %f x2 = %f y2 = %f\n" l.origine.x l.origine.y l.destination.x l.destination.y;
		end
%}

%token EOF
%token ERROR

%token <float> FLOAT
%token <int> INT
%token <bool> BOOL
%token <string> STRING COLOR

%token PAR_G PAR_D VIRG

%token CERCLE RECTANGLE POINT LIGNE

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
	CERCLE PAR_G flottant VIRG flottant VIRG flottant PAR_D {let p={x=$3;y=$5} in let c={centre=p;radius=$7} in print_circle c}
	|	RECTANGLE PAR_G flottant VIRG flottant VIRG flottant VIRG flottant PAR_D {let p={x=$3;y=$5} in let r={coinHG=p;width=$7;height=$9} in print_rectangle r}
	|	POINT PAR_G flottant VIRG flottant PAR_D {let p={x=$3;y=$5} in print_point p}
	|	LIGNE PAR_G flottant VIRG flottant VIRG flottant VIRG flottant PAR_D {let p1={x=$3;y=$5} in let p2={x=$7;y=$9} in let l={origine=p1;destination=p2} in print_line l}
;
