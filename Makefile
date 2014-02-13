EXEC = project

CAMLC = ocamlc
CAMLLEX = ocamllex
CAMLYACC = ocamlyacc

all:
	ocamlbuild project_main.native


all_old:
	$(CAMLLEX) project_lexer.mll
	$(CAMLYACC) project_parser.mly
	$(CAMLC) -c project_parser.mli
	$(CAMLC) -c project_parser.ml
	$(CAMLC) -c project_lexer.ml
	$(CAMLC) project_lexer.cmo project_parser.cmo project_main.ml -o $(EXEC)

clean:
	rm -f *.mli *~ .*~ *.cm[iox] 
	rm -rf project_lexer.ml project_parser.ml
