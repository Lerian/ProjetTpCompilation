type point = {
	mutable p_x: float;
	mutable p_y:float}

type cercle = {
	mutable c_centre: point; 
	mutable c_radius: float}

type rectangle = {
	mutable r_coinHG: point;
	mutable r_width: float;
	mutable r_height: float}

type ligne = {
	mutable l_origine: point;
	mutable l_destination: point}

type texte = {
	mutable t_position: point;
	mutable t_contenu: string;
	mutable t_couleur: string;
	mutable t_tailleFonte: int}

type image = {
	i_width: int;
	i_height: int}

(** Les fonctions liées aux types définis précédemment *)
(** Création *)
let create_text contenu x y couleur tailleFonte=
	begin
		let p={p_x=x; p_y=y} in
			let t={t_position=p; t_contenu=contenu; t_couleur=couleur; t_tailleFonte=tailleFonte} in
				t
	end
	
(** Affichage *)
let print_circle c =
	begin
		Printf.printf "Cercle: x = %f y = %f radius = %f\n" c.c_centre.p_x c.c_centre.p_y c.c_radius;
	end

let print_rectangle r =
	begin
		Printf.printf "Rectangle: x = %f y = %f width = %f height = %f\n" r.r_coinHG.p_x r.r_coinHG.p_y r.r_width r.r_height;
	end

let print_point p =
	begin
		Printf.printf "Point: x = %f y = %f\n" p.p_x p.p_y;
	end

let print_line l =
	begin
		Printf.printf "Ligne: x1 = %f y1 = %f x2 = %f y2 = %f\n" l.l_origine.p_x l.l_origine.p_y l.l_destination.p_x l.l_destination.p_y;
	end

let print_text t =
	begin
		Printf.printf "Texte: x = %f y = %f contenu = %s couleur = %s tailleFonte = %d\n" t.t_position.p_x t.t_position.p_y t.t_contenu t.t_couleur t.t_tailleFonte;
	end

let print_image i =
	begin
		Printf.printf "Image: width = %d height = %d\n" i.i_width i.i_height;
	end
