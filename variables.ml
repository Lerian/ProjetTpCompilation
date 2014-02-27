open Complex_types

(** Les tables pour stocker les variables, selon leurs types *)
let variablesInt : (string, int) Hashtbl.t = Hashtbl.create 10
let variablesFloat : (string, float) Hashtbl.t = Hashtbl.create 10
let variablesBool : (string, bool) Hashtbl.t = Hashtbl.create 10
let variablesString : (string, string) Hashtbl.t = Hashtbl.create 10
let variablesColor : (string, string) Hashtbl.t = Hashtbl.create 10
let variablesPoint : (string, point) Hashtbl.t = Hashtbl.create 10
let variablesCercle : (string, cercle) Hashtbl.t = Hashtbl.create 10
let variablesRectangle : (string, rectangle) Hashtbl.t = Hashtbl.create 10
let variablesLigne : (string, ligne) Hashtbl.t = Hashtbl.create 10
let variablesTexte : (string, texte) Hashtbl.t = Hashtbl.create 10
let variablesImage : (string, image) Hashtbl.t = Hashtbl.create 10
	
(** Fonctions gérant les variables *)
let variableHandling varName =
	begin
	end

let variableFieldHandling fieldName =
	begin
	end
	
(** Création *)
let creation_var_entier name value =
	begin
		if((Hashtbl.mem variablesFloat name)
			||	(Hashtbl.mem variablesBool name)
			||	(Hashtbl.mem variablesString name)
			||	(Hashtbl.mem variablesColor name)
			||	(Hashtbl.mem variablesPoint name)
			||	(Hashtbl.mem variablesCercle name)
			||	(Hashtbl.mem variablesRectangle name)
			||	(Hashtbl.mem variablesLigne name)
			||	(Hashtbl.mem variablesTexte name)
			||	(Hashtbl.mem variablesImage name))
		then
			Printf.printf "erreur de type de variable : %s\n" name
		else
			begin
				Hashtbl.replace variablesInt name value;
			end
	end

let creation_var_flottant name value =
	begin
		if((Hashtbl.mem variablesInt name)
			||	(Hashtbl.mem variablesBool name)
			||	(Hashtbl.mem variablesString name)
			||	(Hashtbl.mem variablesColor name)
			||	(Hashtbl.mem variablesPoint name)
			||	(Hashtbl.mem variablesCercle name)
			||	(Hashtbl.mem variablesRectangle name)
			||	(Hashtbl.mem variablesLigne name)
			||	(Hashtbl.mem variablesTexte name)
			||	(Hashtbl.mem variablesImage name))
		then
			Printf.printf "erreur de type de variable : %s\n" name
		else
			begin
				Hashtbl.replace variablesFloat name value;
			end
	end

let creation_var_booleen name value =
	begin
		if((Hashtbl.mem variablesFloat name)
			||	(Hashtbl.mem variablesInt name)
			||	(Hashtbl.mem variablesString name)
			||	(Hashtbl.mem variablesColor name)
			||	(Hashtbl.mem variablesPoint name)
			||	(Hashtbl.mem variablesCercle name)
			||	(Hashtbl.mem variablesRectangle name)
			||	(Hashtbl.mem variablesLigne name)
			||	(Hashtbl.mem variablesTexte name)
			||	(Hashtbl.mem variablesImage name))
		then
			Printf.printf "erreur de type de variable : %s\n" name
		else
			begin
				Hashtbl.replace variablesBool name value;
			end
	end

let creation_var_texte name value =
	begin
		if((Hashtbl.mem variablesFloat name)
			||	(Hashtbl.mem variablesBool name)
			||	(Hashtbl.mem variablesString name)
			||	(Hashtbl.mem variablesColor name)
			||	(Hashtbl.mem variablesPoint name)
			||	(Hashtbl.mem variablesCercle name)
			||	(Hashtbl.mem variablesRectangle name)
			||	(Hashtbl.mem variablesLigne name)
			||	(Hashtbl.mem variablesInt name)
			||	(Hashtbl.mem variablesImage name))
		then
			Printf.printf "erreur de type de variable : %s\n" name
		else
			begin
				Hashtbl.replace variablesTexte name value;
			end
	end

let creation_var_cercle name value =
	begin
		if((Hashtbl.mem variablesFloat name)
			||	(Hashtbl.mem variablesBool name)
			||	(Hashtbl.mem variablesString name)
			||	(Hashtbl.mem variablesColor name)
			||	(Hashtbl.mem variablesPoint name)
			||	(Hashtbl.mem variablesInt name)
			||	(Hashtbl.mem variablesRectangle name)
			||	(Hashtbl.mem variablesLigne name)
			||	(Hashtbl.mem variablesTexte name)
			||	(Hashtbl.mem variablesImage name))
		then
			Printf.printf "erreur de type de variable : %s\n" name
		else
			begin
				Hashtbl.replace variablesCercle name value;
			end
	end

let creation_var_rectangle name value =
	begin
		if((Hashtbl.mem variablesFloat name)
			||	(Hashtbl.mem variablesBool name)
			||	(Hashtbl.mem variablesString name)
			||	(Hashtbl.mem variablesColor name)
			||	(Hashtbl.mem variablesPoint name)
			||	(Hashtbl.mem variablesCercle name)
			||	(Hashtbl.mem variablesInt name)
			||	(Hashtbl.mem variablesLigne name)
			||	(Hashtbl.mem variablesTexte name)
			||	(Hashtbl.mem variablesImage name))
		then
			Printf.printf "erreur de type de variable : %s\n" name
		else
			begin
				Hashtbl.replace variablesRectangle name value;
			end
	end

let creation_var_ligne name value =
	begin
		if((Hashtbl.mem variablesFloat name)
			||	(Hashtbl.mem variablesBool name)
			||	(Hashtbl.mem variablesString name)
			||	(Hashtbl.mem variablesColor name)
			||	(Hashtbl.mem variablesPoint name)
			||	(Hashtbl.mem variablesCercle name)
			||	(Hashtbl.mem variablesRectangle name)
			||	(Hashtbl.mem variablesInt name)
			||	(Hashtbl.mem variablesTexte name)
			||	(Hashtbl.mem variablesImage name))
		then
			Printf.printf "erreur de type de variable : %s\n" name
		else
			begin
				Hashtbl.replace variablesLigne name value;
			end
	end

let creation_var_string name value =
	begin
		if((Hashtbl.mem variablesFloat name)
			||	(Hashtbl.mem variablesBool name)
			||	(Hashtbl.mem variablesInt name)
			||	(Hashtbl.mem variablesColor name)
			||	(Hashtbl.mem variablesPoint name)
			||	(Hashtbl.mem variablesCercle name)
			||	(Hashtbl.mem variablesRectangle name)
			||	(Hashtbl.mem variablesLigne name)
			||	(Hashtbl.mem variablesTexte name)
			||	(Hashtbl.mem variablesImage name))
		then
			Printf.printf "erreur de type de variable : %s\n" name
		else
			begin
				Hashtbl.replace variablesString name value;
			end
	end

let creation_var_color name value =
	begin
		if((Hashtbl.mem variablesFloat name)
			||	(Hashtbl.mem variablesBool name)
			||	(Hashtbl.mem variablesString name)
			||	(Hashtbl.mem variablesInt name)
			||	(Hashtbl.mem variablesPoint name)
			||	(Hashtbl.mem variablesCercle name)
			||	(Hashtbl.mem variablesRectangle name)
			||	(Hashtbl.mem variablesLigne name)
			||	(Hashtbl.mem variablesTexte name)
			||	(Hashtbl.mem variablesImage name))
		then
			Printf.printf "erreur de type de variable : %s\n" name
		else
			begin
				Hashtbl.replace variablesColor name value;
			end
	end

let creation_var_point name value =
	begin
		if((Hashtbl.mem variablesFloat name)
			||	(Hashtbl.mem variablesBool name)
			||	(Hashtbl.mem variablesString name)
			||	(Hashtbl.mem variablesColor name)
			||	(Hashtbl.mem variablesInt name)
			||	(Hashtbl.mem variablesCercle name)
			||	(Hashtbl.mem variablesRectangle name)
			||	(Hashtbl.mem variablesLigne name)
			||	(Hashtbl.mem variablesTexte name)
			||	(Hashtbl.mem variablesImage name))
		then
			Printf.printf "erreur de type de variable : %s\n" name
		else
			begin
				Hashtbl.replace variablesPoint name value;
			end
	end

let creation_var_image name value =
	begin
		if((Hashtbl.mem variablesFloat name)
			||	(Hashtbl.mem variablesBool name)
			||	(Hashtbl.mem variablesString name)
			||	(Hashtbl.mem variablesColor name)
			||	(Hashtbl.mem variablesPoint name)
			||	(Hashtbl.mem variablesCercle name)
			||	(Hashtbl.mem variablesRectangle name)
			||	(Hashtbl.mem variablesLigne name)
			||	(Hashtbl.mem variablesTexte name)
			||	(Hashtbl.mem variablesInt name))
		then
			Printf.printf "erreur de type de variable : %s\n" name
		else
			begin
				Hashtbl.replace variablesImage name value;
			end
	end
