type point = {
	mutable x: float;
	mutable y:float}

type cercle = {
	mutable centre: point; 
	mutable radius: float}

type rectangle = {
	mutable coinHG: point;
	mutable width: float;
	mutable height: float}

type ligne = {
	mutable origine: point;
	mutable destination: point}

type texte = {
	mutable position: point;
	mutable contenu: string}
