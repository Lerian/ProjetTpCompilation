type point = {
	mutable x: float;
	mutable y:float}

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
	mutable t_contenu: string}

type image = {
	i_width: int;
	i_height: int}
