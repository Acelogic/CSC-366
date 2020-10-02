% file: proglang_v2.pro
% line: some knowledge about programming languages
% language(L) means L is a programming language

language(smalltalk).
language(lisp).
language(prolog).

% essense(L,DT,CF) means language L features datatype DT
% and computational formalism CF

essence(smalltalk,object,'message passing').
essence(lisp,list,'recursive functions').
essence(prolog,relation,'logical inferencing').

% history(L,invertor(I),date(D)) means language L was invented by I in year D

history(smalltalk,inventor('Alan Kay'),date(1980)).
history(lisp,inventor('John McCarthy'),date(1959)).
history(prolog,inventor('Alan Colmeraur'),date(1971)).