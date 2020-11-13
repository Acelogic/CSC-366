% ------------------------------------------------------------------------------
% File: dotsville.pro
% Type: Prolog source
% Line: Basic Dotsville infrastructure
% Date: 2020
% Modifed By: Miguel Cruz
% ------------------------------------------------------------------------------

% Description of Dotsville
%
% Dotsville consists of 24 cells layed out in 4 rows of 6 columns,
% referenced by row indexes 1 2 3 4 and column indexes 1 2 3 4 5 6.
% Row 1, the lowest row, is considered to be on the table.
%
% Dots (1x1 elements) of a particular color can be placed in the cells,
% one dot per cell, subject to the constraint that dots cannot float.
%
% The conceptual names and color codes of the Dotsville colors are:
% red R
% blue B
% green G
% yellow Y
% orange O
% purple P

% Example state of the world
%
%
% B
% R O BG
% R O YG
% ------

% On the representation of dots ...
%
% A structure of the form
%
% dot(cell(R,C),color(Color))
%
% will be used to mean that there is a dot of color Color in row R and column C

% Elaboration on the underworld (the table)
%
% There is a row of "artificial dots", with row index 0, will be equated with
% the table. To be precise, the following structures will collectively represent
% the table:
% dot(cell(0, 1), color(table)).
% dot(cell(0, 2), color(table)).
% dot(cell(0, 3), color(table)).
% dot(cell(0, 4), color(table)).
% dot(cell(0, 5), color(table)).
% dot(cell(0, 6), color(table)).
% The "color code" of a table dot is conveniently taken to be: -

% ------------------------------------------------------------------------------
% Program to make the table and a call to actually make it
make_table :-
	assert(dot(cell(0,1),color(table))),
	assert(dot(cell(0,2),color(table))),
	assert(dot(cell(0,3),color(table))),
	assert(dot(cell(0,4),color(table))),
	assert(dot(cell(0,5),color(table))),
	assert(dot(cell(0,6),color(table))).
	:- make_table.

% ------------------------------------------------------------------------------
% Display the world, one row at a time, from the top, including the underworld
display_world :-
	display_row(4),
	display_row(3),
	display_row(2),
	display_row(1),
	display_row(0).
display_row(R) :-
	display_cell(R,1), write(' '),
	display_cell(R,2), write(' '),
	display_cell(R,3), write(' '),
	display_cell(R,4), write(' '),
	display_cell(R,5), write(' '),
	display_cell(R,6), write(' '),
	nl.
display_cell(R,C) :-
	dot(cell(R,C),color(Color)),
	color_code(Color,Code),
	write(Code).
display_cell(_,_) :-
	write(' ').
	color_code(red,'R').
	color_code(blue,'B').
	color_code(yellow,'Y').
	color_code(orange,'O').
	color_code(purple,'P').
	color_code(green,'G').
	color_code(table,'-').

% ------------------------------------------------------------------------------
% The add dot predicate (with some integrity!)  (Purple Bug Fixed)

add_dot(cell(R,_),_) :- not(member(R,[1,2,3,4])),
	write('### Cannot add dot: row position is invalid.'),nl.
add_dot(cell(_,C),_) :- not(member(C,[1,2,3,4,5,6])),
	write('### Cannot add dot: column position is invalid.'),nl.
add_dot(cell(R,C),_) :- dot(cell(R,C),_),
	write('### Cannot add dot: cell is already filled.'),nl.
add_dot(cell(R,C),_) :- SubR is R-1, not(dot(cell(SubR,C),_)),
	write('### Cannot add dot: dots cannot float.'),nl.
add_dot(_,color(Color)) :- not(member(Color,[red,blue,yellow,green,orange,purple])),  
	write('### Cannot add dot: invalid color.'),nl.
add_dot(cell(R,C),color(Color)) :-
	assert(dot(cell(R,C),color(Color))).

% ------------------------------------------------------------------------------
% demo1 - display the empty world
demo1 :-
	display_world,
	listing(dot).

% ------------------------------------------------------------------------------
% demo2 - display the world with different colored dots on the table
demo2 :-
	add_dot(cell(1,1),color(red)),
	add_dot(cell(1,2),color(blue)),
	add_dot(cell(1,3),color(yellow)),
	add_dot(cell(1,4),color(green)),
	add_dot(cell(1,5),color(purple)),
	add_dot(cell(1,6),color(orange)),   
	display_world,
	listing(dot).

% ------------------------------------------------------------------------------
% Clear the world, one row at a time, from the bottom, but not including the
% underworld.
clear_world :-
	clear_cell(_,_),fail.
clear_world :-
	make_table.
clear_cell(_,_) :-
	retract(dot(cell(_,_),_)).
	clear_cell(_,_).

% ------------------------------------------------------------------------------
% demo3 - demostrate that the clear world command works
demo3 :-
	clear_world,
	demo2,
	clear_world,
	demo1.

% ------------------------------------------------------------------------------
% demo4 - demostrate that we cannot place a dot in a full position
demo4 :-
	clear_world,
	add_dot(cell(1,1),color(red)),
	add_dot(cell(1,1),color(blue)),
	add_dot(cell(1,2),color(blue)),
	display_world.

% ------------------------------------------------------------------------------
% demo5 - demostrating that the dots cannot float
demo5 :-
	clear_world,
	add_dot(cell(1,1),color(red)),
	add_dot(cell(1,2),color(blue)),
	add_dot(cell(4,3),color(yellow)),
	add_dot(cell(3,4),color(green)),
	add_dot(cell(2,5),color(purple)),
	add_dot(cell(1,6),color(orange)),
	display_world.