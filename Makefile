EXEC = project

CAMLC = ocamlc
CAMLLEX = ocamllex
CAMLYACC = ocamlyacc

all:
	$(CAMLLEX) project_lexer.mll
	$(CAMLYACC) project_parser.mly
	$(CAMLC) -c complex_types.ml
	$(CAMLC) -c variables.ml
	$(CAMLC) -c project_parser.mli
	$(CAMLC) -c project_parser.ml
	$(CAMLC) -c project_lexer.ml
	$(CAMLC) complex_types.cmo variables.cmo project_lexer.cmo project_parser.cmo project_main.ml -o $(EXEC)
	
all_native:
	ocamlbuild project_main.native

clean:
	rm -f *.mli *~ .*~ *.cm[iox] 
	rm -rf project_lexer.ml project_parser.ml

fullclean: clean
	rm -f project
