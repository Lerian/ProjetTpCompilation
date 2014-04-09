open Complex_types

let do_if_true booleen value =
	begin
		if(booleen)
		then
			begin
				Printf.printf value;
			end
		else
			begin
				Printf.printf "echec";
			end
	end
