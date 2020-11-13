% file: wildcard.pro
% line: some knowledge about pokemon 


% pokemon(N, type(T),A, D, S).
% N = Name
% T = Type
% A = Attack
% D = Defense
% S = Speed

pokemon(eevee,type(normal),45,50,65). 
pokemon(leafeon,type(leaf),30,45,48).
pokemon(espeon,type(psychic),45,61,47).
pokemon(flareon,type(fire),74,85,35).
pokemon(vaporeon,type(water),56,41,65).
pokemon(jolteon,type(electric),47,28,23).
pokemon(bulbasaur,type(leaf),52,78,37).
pokemon(squirtle,type(water),23,12,25).
pokemon(pikachu,type(electric),59,48,23).
pokemon(charmander,type(fire),21,89,14).

% Predicated based on rules
%

% Rules for listing pokemon by name 
names :- pokemon(N,_,_,_,_), write(N),nl,fail.
names.


% Rules for listing pokemon by type
types :- pokemon(_,type(T),_,_,_), write(T),nl,fail.
types. 


% Rules for listing pokemon by name and type
pokemons :- names, types. 
pokemons.

%Rules for determining if a pokemon associated with the name is the correct type 
leaf(N) :- pokemon(N, type(leaf),_,_,_).
fire(N) :- pokemon(N, type(fire),_,_,_).
water(N) :- pokemon(N, type(water),_,_,_).
electric(N) :- pokemon(N, type(electric),_,_,_).
normal(N) :- pokemon(N, type(normal),_,_,_).
psychic(N) :- pokemon(N, type(psychic),_,_,_).



% strong(N)/weakN) :: for defining pokemon by strong and weak attack
strongatk(N) :- pokemon(N, _, A,_,_), A >= 50.
weakatk(N) :- pokemon(N, _, A,_,_), A < 50.

% strongdef(N)/weakdef(N) :: for defining pokemon by strong and weak defence
strongdef(N):- pokemon(N, _,_,D,_), D >= 50.
weakdef(N) :- pokemon(N, _,_,D,_), D < 50.

% fast(N)/slow(N) :: for defining pokemon by slow and fast speed
fast(N) :- pokemon(N, _, _,_,S), S >= 50.
slow(N) :- pokemon(N, _, _,_,S), S < 50.
