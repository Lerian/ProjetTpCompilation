type operator_t =
	Add | Sub | Mul | Div | Mod
	
type instrNode = {
	operator : operator_t;
	left : instrNode;
	right : instrNode;
}

type node = Instr of instrNode | InstrList of (node) list



