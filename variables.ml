open Complex_types

(** La table pour stocker les variables *)
let variables : (string, type_t_values * type_t) Hashtbl.t = Hashtbl.create 100

(** la table pour stocker les fichiers associés aux images *)
let files : (string, string) Hashtbl.t = Hashtbl.create 5

(** Conversion d'une forme en sa description XML *)
let shape_to_string shapeName =
	begin
		if(Hashtbl.mem variables shapeName)
		then
			begin
				match (Hashtbl.find variables shapeName) with
					|(Cercle_t, Cercle x) -> ("	<circle\n		cx=\""^(string_of_float x.c_centre.p_x)^"\" cy=\""^(string_of_float x.c_centre.p_y)^"\"\n		r=\""^(string_of_float x.c_radius)^"\"\n		fill=\""^x.c_couleurRemplissage^"\"\n		stroke=\""^x.c_couleurContour^"\"\n		stroke-width=\""^(string_of_int x.c_epaisseurContour)^"\" />\n")
					|(Rectangle_t, Rectangle x) -> ("	<rect\n		width=\""^(string_of_float x.r_width)^"\" height=\""^(string_of_float x.r_height)^"\"\n		x=\""^(string_of_float x.r_coinHG.p_x)^"\" y=\""^(string_of_float x.r_coinHG.p_y)^"\"\n		fill=\""^x.r_couleurRemplissage^"\"\n		stroke=\""^x.r_couleurContour^"\"\n		stroke-width=\""^(string_of_int x.r_epaisseurContour)^"\" />\n")
					|(Ligne_t, Ligne x) -> ("	<line\n		x1=\""^(string_of_float x.l_origine.p_x)^"\" y1=\""^(string_of_float x.l_origine.p_y)^"\"\n		x2=\""^(string_of_float x.l_destination.p_x)^"\" y2=\""^(string_of_float x.l_destination.p_y)^"\"\n		stroke=\""^x.l_couleurContour^"\"\n		stroke-width=\""^(string_of_int x.l_epaisseurContour)^"\" />\n")
					|(Texte_t, Texte x) -> ("	<text\n		x=\""^(string_of_float x.t_position.p_x)^"\" y=\""^(string_of_float x.t_position.p_y)^"\"\n		fill=\""^(x.t_couleur)^"\"\n		font-size=\""^(string_of_int x.t_tailleFonte)^"\">\n		"^(x.t_contenu)^"\n	</text>\n")
					| _ -> "erreur"
					;
			end
		else
			begin
				raise Not_found
			end
	end
	
(** dessin d'une forme dans l'image *)
let draw_shape imageName shapeName =
	begin
		if(Hashtbl.mem files (imageName^".svg"))
		then
			if(Hashtbl.mem variables shapeName)
			then
				begin
					let shape_content = shape_to_string shapeName in
						begin
							Hashtbl.replace files (imageName^".svg") ((Hashtbl.find files (imageName^".svg"))^shape_content)
						end
				end
			else
				begin
					raise Not_found
				end
		else
			begin
				raise Not_found
			end
	end

(** Création d'un fichier pour enregistrer une image *)
let create_file fileName width height =
	begin
		let file_content = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
											^"<svg\n"
											^"	xmlns=\"http://www.w3.org/2000/svg\"\n"
											^"	version=\"1.1\"\n"
											^"	width=\""^(string_of_int width)^"\"\n"
											^"	height=\""^(string_of_int height)^"\">\n"
											^"	<title>Exemple simple de figure SVG</title>\n"
											^"	<desc>\n"
											^"		\n"
											^"	</desc>\n" in
			begin
				Hashtbl.add files fileName file_content;
			end
	end

(** Fermeture de la balise xml </svg> d'un fichier *)
let close_file fileName file_content =
	begin
		let file = open_out fileName in
			begin
				output_string file file_content;
				output_string file "</svg>";
				close_out file
			end
	end
	
(** Fermeture des balises xml </svg> des fichiers ouverts *)
let close_files () =
	begin
		Hashtbl.iter (close_file) files
	end
	
(** Fonctions gérant les variables *)
(** Création *)

let creation_var_image name value =
	begin
		if(Hashtbl.mem variables name)
		then
			match Hashtbl.find variables name with
				|	(Image_t, _) 	->	Printf.printf "erreur: %s existe déjà.\n" name
				|	_			->	Printf.printf "erreur: %s existe déjà est le type est mauvais.\n" name
				;
		else
			begin
				(** création du fichier correspondant *)
				create_file (name^".svg") (value.i_width) (value.i_height);
				Hashtbl.add variables name (Image_t, Image value)
			end
	end

let creation_var_entier name value =
	begin
		if(Hashtbl.mem variables name)
		then
			match Hashtbl.find variables name with
				|	(Entier_t, _) 	->	Hashtbl.replace variables name (Entier_t, Entier value)
				|	_			->	Printf.printf "erreur: %s existe déjà est le type est mauvais.\n" name
				;
		else
			begin
				Hashtbl.add variables name (Entier_t, Entier value);
			end
	end

let creation_var_flottant name value =
	begin
		if(Hashtbl.mem variables name)
		then
			match Hashtbl.find variables name with
				|	(Flottant_t, _) 	->	Hashtbl.replace variables name (Flottant_t, Flottant value)
				|	_					->	Printf.printf "erreur: %s existe déjà est le type est mauvais.\n" name
				;
		else
			begin
				Hashtbl.add variables name (Flottant_t, Flottant value);
			end
	end

let creation_var_booleen name value =
	begin
		if(Hashtbl.mem variables name)
		then
			match Hashtbl.find variables name with
				|	(Booleen_t, _) 	->	Hashtbl.replace variables name (Booleen_t, Booleen value)
				|	_			->	Printf.printf "erreur: %s existe déjà est le type est mauvais.\n" name
				;
		else
			begin
				Hashtbl.add variables name (Booleen_t, Booleen value);
			end
	end

let creation_var_texte name value =
	begin
		if(Hashtbl.mem variables name)
		then
			match Hashtbl.find variables name with
				|	(Texte_t, _) 	->	Hashtbl.replace variables name (Texte_t, Texte value)
				|	_			->	Printf.printf "erreur: %s existe déjà est le type est mauvais.\n" name
				;
		else
			begin
				Hashtbl.add variables name (Texte_t, Texte value);
			end
	end

let creation_var_cercle name value =
	begin
		if(Hashtbl.mem variables name)
		then
			match Hashtbl.find variables name with
				|	(Cercle_t, _) 	->	Hashtbl.replace variables name (Cercle_t, Cercle value)
				|	_			->	Printf.printf "erreur: %s existe déjà est le type est mauvais.\n" name
				;
		else
			begin
				Hashtbl.add variables name (Cercle_t, Cercle value);
			end
	end

let creation_var_rectangle name value =
	begin
		if(Hashtbl.mem variables name)
		then
			match Hashtbl.find variables name with
				|	(Rectangle_t, _) 	->	Hashtbl.replace variables name (Rectangle_t, Rectangle value)
				|	_			->	Printf.printf "erreur: %s existe déjà est le type est mauvais.\n" name
				;
		else
			begin
				Hashtbl.add variables name (Rectangle_t, Rectangle value);
			end
	end

let creation_var_ligne name value =
	begin
		if(Hashtbl.mem variables name)
		then
			match Hashtbl.find variables name with
				|	(Ligne_t, _) 	->	Hashtbl.replace variables name (Ligne_t, Ligne value)
				|	_			->	Printf.printf "erreur: %s existe déjà est le type est mauvais.\n" name
				;
		else
			begin
				Hashtbl.add variables name (Ligne_t, Ligne value);
			end
	end

let creation_var_string name value =
	begin
		if(Hashtbl.mem variables name)
		then
			match Hashtbl.find variables name with
				|	(Chaine_t, _) 	->	Hashtbl.replace variables name (Chaine_t, Chaine value)
				|	_			->	Printf.printf "erreur: %s existe déjà est le type est mauvais.\n" name
				;
		else
			begin
				Hashtbl.add variables name (Chaine_t, Chaine value);
			end
	end

let creation_var_color name value =
	begin
		if(Hashtbl.mem variables name)
		then
			match Hashtbl.find variables name with
				|	(Couleur_t, _) 	->	Hashtbl.replace variables name (Couleur_t, Couleur value)
				|	_			->	Printf.printf "erreur: %s existe déjà est le type est mauvais.\n" name
				;
		else
			begin
				Hashtbl.add variables name (Couleur_t, Couleur value);
			end
	end

let creation_var_point name value =
	begin
		if(Hashtbl.mem variables name)
		then
			match Hashtbl.find variables name with
				|	(Point_t, _) 	->	Hashtbl.replace variables name (Point_t, Point value)
				|	_			->	Printf.printf "erreur: %s existe déjà est le type est mauvais.\n" name
				;
		else
			begin
				Hashtbl.add variables name (Point_t, Point value);
			end
	end

(** Récupération de la valeur d'une variable *)
let get_float_value varName =
	begin
		if(Hashtbl.mem variables varName)
		then
			match Hashtbl.find variables varName with
				|	(Flottant_t, Flottant x)	->	x
				|	_				->	raise Not_found
				;
		else
			begin
				raise Not_found
			end
	end

let get_int_value varName =
	begin
		if(Hashtbl.mem variables varName)
		then
			match Hashtbl.find variables varName with
				|	(Entier_t, Entier x)	->	x
				|	_				->	raise Not_found
				;
		else
			begin
				raise Not_found
			end
	end


let get_boolean_value varName =
	begin
		if(Hashtbl.mem variables varName)
		then
			match Hashtbl.find variables varName with
				|	(Booleen_t, Booleen x)	->	x
				|	_				->	raise Not_found
				;
		else
			begin
				raise Not_found
			end
	end

let get_point_value varName =
	begin
		if(Hashtbl.mem variables varName)
		then
			match Hashtbl.find variables varName with
				|	(Point_t, Point x)	->	x
				|	_				->	raise Not_found
				;
		else
			begin
				raise Not_found
			end
	end

let get_image_value varName =
	begin
		if(Hashtbl.mem variables varName)
		then
			match Hashtbl.find variables varName with
				|	(Image_t, Image x)	->	x
				|	_				->	raise Not_found
				;
		else
			begin
				raise Not_found
			end
	end

let get_text_value varName =
	begin
		if(Hashtbl.mem variables varName)
		then
			match Hashtbl.find variables varName with
				|	(Texte_t, Texte x)	->	x
				|	_				->	raise Not_found
				;
		else
			begin
				raise Not_found
			end
	end

let get_circle_value varName =
	begin
		if(Hashtbl.mem variables varName)
		then
			match Hashtbl.find variables varName with
				|	(Cercle_t, Cercle x)	->	x
				|	_				->	raise Not_found
				;
		else
			begin
				raise Not_found
			end
	end

let get_rectangle_value varName =
	begin
		if(Hashtbl.mem variables varName)
		then
			match Hashtbl.find variables varName with
				|	(Rectangle_t, Rectangle x)	->	x
				|	_				->	raise Not_found
				;
		else
			begin
				raise Not_found
			end
	end

let get_line_value varName =
	begin
		if(Hashtbl.mem variables varName)
		then
			match Hashtbl.find variables varName with
				|	(Ligne_t, Ligne x)	->	x
				|	_				->	raise Not_found
				;
		else
			begin
				raise Not_found
			end
	end

let get_string_value varName =
	begin
		if(Hashtbl.mem variables varName)
		then
			match Hashtbl.find variables varName with
				|	(Chaine_t, Chaine x)	->	x
				|	_				->	raise Not_found
				;
		else
			begin
				raise Not_found
			end
	end

let get_color_value varName =
	begin
		if(Hashtbl.mem variables varName)
		then
			match Hashtbl.find variables varName with
				|	(Couleur_t, Couleur x)	->	x
				|	_				->	raise Not_found
				;
		else
			begin
				raise Not_found
			end
	end







(** Récupération d'une variable selon son nom, quel que soit son type 
let get_var varName =
	begin
		try Hashtbl.find variablesInt varName with
			Not_found -> try Hashtbl.find variablesInt varName with
			Not_found -> try Hashtbl.find variablesInt varName with
			Not_found -> try Hashtbl.find variablesInt varName with
			Not_found -> try Hashtbl.find variablesInt varName with
			Not_found -> try Hashtbl.find variablesInt varName with
			Not_found -> try Hashtbl.find variablesInt varName with
			Not_found -> try Hashtbl.find variablesInt varName with
			Not_found -> try Hashtbl.find variablesInt varName with
			Not_found -> try Hashtbl.find variablesInt varName with
			Not_found -> try Hashtbl.find variablesInt varName with
			Not_found -> Printf.printf "variable %s introuvable en mémoire\n" varName;
	end*)

(** Vérification d'existance d'un champ *)
let var_has_field_entier varName fieldName =
	begin
		true
	end

let update_var_field_entier varName fieldName value =
	begin
	
	end
