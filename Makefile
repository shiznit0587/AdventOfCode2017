default: main

main: main.native

%.native:
	ocamlbuild -use-ocamlfind src/$@
	mv $@ $*

clean:
	rm -r _build
	rm main