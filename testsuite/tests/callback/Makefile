#########################################################################
#                                                                       #
#                                 OCaml                                 #
#                                                                       #
#                 Xavier Clerc, SED, INRIA Rocquencourt                 #
#                                                                       #
#   Copyright 2010 Institut National de Recherche en Informatique et    #
#   en Automatique.  All rights reserved.  This file is distributed     #
#   under the terms of the Q Public License version 1.0.                #
#                                                                       #
#########################################################################

BASEDIR=../..

CC=$(NATIVECC) -I $(TOPDIR)/byterun

default: run-byte run-opt

common:
	@$(CC) -c callbackprim.c

run-byte: common
	@printf " ... testing 'bytecode':"
	@$(OCAMLC) -c tcallback.ml
	@$(OCAMLC) -o ./program -custom unix.cma callbackprim.$(O) tcallback.cmo
	@./program > bytecode.result
	@$(DIFF) reference bytecode.result || (echo " => failed" && exit 1)
	@echo " => passed"

run-opt: common
	@if [ -z "$(BYTECODE_ONLY)" ]; then \
	  printf " ... testing 'native':"; \
	  $(OCAMLOPT) -c tcallback.ml; \
	  $(OCAMLOPT) -o ./program unix.cmxa callbackprim.$(O) tcallback.cmx; \
	  ./program > native.result; \
	  $(DIFF) reference native.result || (echo " => failed" && exit 1); \
	  echo " => passed"; \
	fi

promote: defaultpromote

clean: defaultclean
	@rm -f *.result ./program

include $(BASEDIR)/makefiles/Makefile.common
