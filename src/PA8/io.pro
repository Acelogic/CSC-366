% ------------------------------------------------------------------------------
% File:  io.pro
% Type:  Prolog source
% Line:  IO library
% Date:  Written 1987, touched 2020
% ------------------------------------------------------------------------------

% ------------------------------------------------------------------------------
% Read a sentence represented as a sequence of characters terminated by a
% period, comma, or exclamation point, and transform it into a sentence
% represented by a list of symbols.

read_sentence([FirstWord|RestOfSentence]) :- 
  get0(Char),
  readWord(Char,FirstWord,NextChar),
  readRestOfSentence(FirstWord,NextChar,RestOfSentence).

readRestOfSentence(Word,_,[]) :- 
  endOfSentenceWord(Word),!.
readRestOfSentence(_,Char,[NextWord|RestOfSentence]) :-
  readWord(Char,NextWord,NextChar), 
  readRestOfSentence(NextWord,NextChar,RestOfSentence).

readWord(Char,Word,NextChar) :-
  singleCharWord(Char),!,name(Word,[Char]),get0(NextChar).
readWord(Char,Word,NextChar) :-
  componentChar(Char,NewChar),
  !,
  get0(TempNextChar),
  restWord(TempNextChar,RestWord,NextChar),
  name(Word,[NewChar|RestWord]).
readWord(_,Word,NextChar) :- 
  get0(TempChar), 
  readWord(TempChar,Word,NextChar).

restWord(Char,[NewChar|RestWord],NextChar) :-
  componentChar(Char,NewChar),
  !,
  get0(TempNextChar),
  restWord(TempNextChar,RestWord,NextChar).
  restWord(Char,[],Char).

singleCharWord(44).  /* , */
singleCharWord(59).  /* ; */
singleCharWord(58).  /* : */
singleCharWord(63).  /* ? */
singleCharWord(33).  /* ! */
singleCharWord(46).  /* . */

componentChar(Char,Char) :- Char>96,Char<123.
componentChar(Char,L) :- Char>64,Char<91,L is Char+32.
componentChar(Char,Char) :- Char>47,Char<58.
componentChar(39,39).
componentChar(45,45).

endOfSentenceWord('.').
endOfSentenceWord('!').
endOfSentenceWord('?').

% ------------------------------------------------------------------------------
% Write a sentenece stored as a list of symbols to the standard output stream.

write_sentence([]).
write_sentence([H|T]) :-
  write(H),write(' '),
  write_rest_of_sentence(T).

write_rest_of_sentence([]).
write_rest_of_sentence([H|[.]]) :-
  write(H),write('.').
write_rest_of_sentence([H|[?]]) :-
  write(H),write('?').
write_rest_of_sentence([H|T]) :-
  write(H),write(' '),
  write_rest_of_sentence(T).



