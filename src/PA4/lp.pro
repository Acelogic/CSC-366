% ------------------------------------------------------------------------------
% File: lp.pro
% Type: Prolog source
% Line: List processing library
% Date: 1987, 1993, 2013, 2020
% ------------------------------------------------------------------------------
% Writing elements of a list in order and in reverse order
% ------------------------------------------------------------------------------
% write_list(List) :: Write the elements of the list in order, one
% per line
write_list([]).
write_list([H|T]) :-
write(H),nl,
write_list(T).
% write_list_reversed(List) :: Write the elements of the list in
% reverse order, one per line
write_list_reversed([]).
write_list_reversed([H|T]) :-
write_list_reversed(T),
write(H),nl.
% Four explicit referencers
% ------------------------------------------------------------------------------
% first(List,First) :: Presuming the list is nonempty reference its
% first element
first( [ First | _ ], First).
% rest(List,Rest) :: Presuming the list is nonempty, reference the
% list except for the first element
rest( [ _ | Rest ], Rest).
% last(List,Last) :: Presuming the list is nonempty, reference the
% last element of the list
last( [ Singleton ], Singleton).
last( [ _ | Rest ], Last) :- last(Rest, Last).
% nth(N,List,NthElement) :: Presuming the list is nonempty, reference the
% nth element of the list
nth(0, [ H | _ ], H).

nth(N, [ _ | T ], NthElement) :- NM1 is N-1, nth(NM1,T,NthElement).
% item
% ------------------------------------------------------------------------------
% item(N,List,Item) :: ...
item(N,[H|_],H) :- N = 0.
item(N,[_|T],E) :- N > 0, K is N - 1, item(K,T,E).
% member
% ------------------------------------------------------------------------------
% member(Element,List) :: ...
member(X,[X|_]).
member(X,[_|Y]) :- member(X,Y).
% count
% ------------------------------------------------------------------------------
% count(Element,List,Count) :: ...
count(_,[],0).
count(Element,[Element|Rest],Count) :-
count(Element,Rest,RestCount),
Count is RestCount + 1.
count(Element,[_|Rest],Count) :-
count(Element,Rest,Count).
% append
% ------------------------------------------------------------------------------
% append(L1,L2,Result) :: ...
append([],L,L).
append([H|T1],L2,[H|T3]) :- append(T1,L2,T3).
% append(L1,L2,L3,Result) :: ...
append(L1,L2,L3,Result) :-
append(L1,L2,L12),append(L12,L3,Result).
% append(L1,L2,L3,L4,Result) :: ...
append(L1,L2,L3,L4,Result) :-
append(L1,L2,L3,L123),append(L123,L4,Result).
% remove
% ------------------------------------------------------------------------------
% remove(E,L,Result) :: ...
remove(_,[],[]).

remove(First,[First|Rest],Rest).
remove(Element,[First|Rest],[First|RestLessElement]) :-
remove(Element,Rest,RestLessElement).
% replace
% ------------------------------------------------------------------------------
% replace(Position,Value,InList,OutList) :: ...
replace(0,Object,[_|T],[Object|T]).
replace(ListPosition,Object,[H|T1],[H|T2]) :-
K is ListPosition - 1,
replace(K,Object,T1,T2).
% make_list
% ------------------------------------------------------------------------------
% make_list(Size,Element,List) :: ...
make_list(0,_,[]).
make_list(Length,Element,[Element|Rest]) :-
K is Length - 1,
make_list(K,Element,Rest).
% reverse
% ------------------------------------------------------------------------------
% reverse(L,R) ::
reverse([],[]).
reverse([H|T],R) :-
reverse(T,Rev),add_last(H,Rev,R).
% add_first
% ------------------------------------------------------------------------------
% add_first(E,L,R) ::
add_first(X,L,[X|L]).
% add_last
% ------------------------------------------------------------------------------
% add_last(E,L,R) ::
add_last(X,[],[X]).
add_last(X,[H|T],[H|TX]) :- add_last(X,T,TX).
% pick
% ------------------------------------------------------------------------------
% pick(List,Item) :: ...
pick(L,Item) :-

length(L,Length),
random(0,Length,RN),
item(RN,L,Item).
% take
% ------------------------------------------------------------------------------
% take(InList,OutElement,OutList) :: ...
take(List,Element,Rest) :-
pick(List,Element),
remove(Element,List,Rest).
% iota
% ------------------------------------------------------------------------------
% iota(K,IotaK) :: ...
iota(0,[]).
iota(N,IotaN) :-
K is N - 1,
iota(K,IotaK),
add_last(N,IotaK,IotaN).
% sum
% ------------------------------------------------------------------------------
% sum(ListOfNumbers,Sum) :: ...
sum([],0).
sum([Head|Tail],Sum) :-
sum(Tail,SumOfTail),
Sum is Head + SumOfTail.
% producut
% ------------------------------------------------------------------------------
% product(ListOfNumbers,Product) :: ...
product([],1).
product([Head|Tail],Product) :-
product(Tail,ProductOfTail),
Product is Head * ProductOfTail.
% factorial
% ------------------------------------------------------------------------------
% factorial(N,F) :: ...
factorial(N,Nfactorial) :-
iota(N,IotaN),
product(IotaN,Nfactorial).
% min

% ------------------------------------------------------------------------------
% min[NumericList,MinimumNumber] :: find the smallest number in the list

% max
% ------------------------------------------------------------------------------
% max[NumericList,MinimumNumber] :: find the largest number in the list

% sort_inc
% ------------------------------------------------------------------------------
% sort_inc[UnorderedNumericList,OrderedNumericList] :: order low to high

% sort_dec
% ------------------------------------------------------------------------------
% sort_dec[UnorderedNumericList,OrderedNumericList] :: order high to low

% alist
% ------------------------------------------------------------------------------
% Example:
% ?- alist([a,b,c,d],[1,2,3,4],A_List).
% A_List = [pair(a,1),pair(b,2),pair(c,3),pair(d,4)]
% alist(FirstList,SecondList,AssociationList) :: create the association list
% - (alist) from the two lists of equal length, the pairs of which are
% - encapsulated into terms with the name ’pair’

% assoc
% ------------------------------------------------------------------------------
% Example:
% ?- assoc([pair(a,1),pair(b,2),pair(c,3),pair(d,4)],c,Value).
% Value = 3
% assoc(A_List,Key,Value) :: find the Value in the second slot corresponding

% - to the Key in the first slot of some association list pair

% freq_count
% ------------------------------------------------------------------------------
% Example:
% ?- freq_count([a,b,a,b,c,a,b,c,d,a,b,c,d,e],FCL).
% FCL = [pair(a,5),pair(b,4),pair(c,3),pair(d,2),pair(e,1)]
% freq_count(List,FCL) :: ...
freq_count(List,FC_list) :-
make_set(List,Set),
freq_counter(Set,List,FC_list).
freq_counter([],_,[]).
freq_counter([H|T],List,FC_list) :-
count(H,List,H_count),
freq_counter(T,List,FCT_list),
FC_list = [pair(H,H_count) | FCT_list].
% make_set
% ------------------------------------------------------------------------------
% make_set(List,Set) :: ...
make_set([],[]).
make_set([H|T],TS) :-
member(H,T),
make_set(T,TS).
make_set([H|T],[H|TS]) :-
make_set(T,TS).

% flatten
% ------------------------------------------------------------------------------
% flatten(HL,FL) :: ...
flatten([],[]).
flatten([[]|T],L) :-
flatten(T,L).
flatten([H|T],L) :-
atom(H),
flatten(T,Tflattened),
append([H],Tflattened,L).
flatten([H|T],L) :-
flatten(H,FlatHead),
flatten(T,FlatTail),
append(FlatHead,FlatTail,L).
