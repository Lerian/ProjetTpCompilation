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
			Printf.printf "Cercle: x = %f y = %f radius = %f\n" c.c_centre.x c.c_centre.y c.c_radius;
		end
	
	let print_rectangle r =
		begin
			Printf.printf "Rectangle: x = %f y = %f width = %f height = %f\n" r.r_coinHG.x r.r_coinHG.y r.r_width r.r_height;
		end
	
	let print_point p =
		begin
			Printf.printf "Point: x = %f y = %f\n" p.x p.y;
		end
	
	let print_line l =
		begin
			Printf.printf "Ligne: x1 = %f y1 = %f x2 = %f y2 = %f\n" l.l_origine.x l.l_origine.y l.l_destination.x l.l_destination.y;
		end
	
	let print_text t =
		begin
			Printf.printf "Texte: x = %f y = %f contenu = %s\n" t.t_position.x t.t_position.y t.t_contenu;
		end
	
	let print_image i =
		begin
			Printf.printf "Image: width = %d height = %d\n" i.i_width i.i_height;
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
	CERCLE PAR_G flottant VIRG flottant VIRG flottant PAR_D {let p={x=$3;y=$5} in let c={c_centre=p;c_radius=$7} in print_circle c}
	|	RECTANGLE PAR_G flottant VIRG flottant VIRG flottant VIRG flottant PAR_D {let p={x=$3;y=$5} in let r={r_coinHG=p;r_width=$7;r_height=$9} in print_rectangle r}
	|	POINT PAR_G flottant VIRG flottant PAR_D {let p={x=$3;y=$5} in print_point p}
	|	LIGNE PAR_G flottant VIRG flottant VIRG flottant VIRG flottant PAR_D {let p1={x=$3;y=$5} in let p2={x=$7;y=$9} in let l={l_origine=p1;l_destination=p2} in print_line l}
	|	TEXTE PAR_G STRING VIRG flottant VIRG flottant PAR_D {let p={x=$5;y=$7} in let t={t_position=p;t_contenu=$3} in print_text t}
	|	IMAGE PAR_G entier VIRG entier PAR_D {let i={i_width=$3;i_height=$5} in print_image i}
;
