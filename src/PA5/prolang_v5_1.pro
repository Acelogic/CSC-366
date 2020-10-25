%FILE: dotsville.pl
%Date: Due October 19,2020       
%---------------------------------

%=================================
%Description of Dotsville
% The dotsville is made of 24 cells. Which is 4 ROWS and 6 
%----The Table-----
%4 
%3 
%2 
%1 
%0 - - - - - - 
%  1 2 3 4 5 6
%The Table:
%dot(cell(0,1), color(table)).
%dot(cell(0,2), color(table)).
%dot(cell(0,3), color(table)).
%dot(cell(0,4), color(table)).
%dot(cell(0,5), color(table)).
%dot(cell(0,6), color(table)).
%=============================
%---------------------------------------------------------
%Program to make the table and a call to actually make it
make_table :-
    assert(dot( cell(0,1),color(table))),
	assert(dot( cell(0,2),color(table))),
	assert(dot( cell(0,3),color(table))),
	assert(dot( cell(0,4),color(table))),
	assert(dot( cell(0,5),color(table))),
	assert(dot( cell(0,6),color(table))).
:- make_table.
%---------------------------------------------------------
%Display the world, one row at a time, from the top, including the underworld
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
%----------------------------------------------------------
%Variables to be used to print in the cell table 
color_code(red,   'R').
color_code(blue,  'B').
color_code(yellow,'Y').
color_code(orange,'O').
color_code(purple,'P').
color_code(green, 'G').
color_code(table, '-').
%----------------------------------------------------------
%==========================================================
%The add dot predicate (with some integrity!)

add_dot(cell(R,_),_) :- not(member(R,[1,2,3,4])),
   write('### Cannot add dot: row position is invalid.'),nl.
%---To inform that you can't add the dot at the selected ROW.---

add_dot(cell(_,C),_) :- not(member(C,[1,2,3,4,5,6])),
   write('### Cannot add dot: column position is invalid.'),nl.
%---To inform that you can't add a dot on the selected COLUMN.---

add_dot(cell(R,C),_) :- dot(cell(R,C),_),
   write('### Cannot add dot: cell is already filled.'),nl.
%---To inform that you can't place a DOT because its already filled.---

add_dot(cell(R,C),_) :- SubR is R-1, not(dot(cell(SubR,C),_)),
   write('### Cannot add dot: dots cannot float.'),nl.
%---To inform you that you can't place a DOT there cause it doesn't automatically float--
 
add_dot(_,color(Color)) :- not(member(Color,[red,blue,yellow,orange,purple,green])),
   write('### Cannot add dot: invalid color.'),nl.
%---To ensure that the color mentioned in the list is only used in the dotsville---

add_dot(cell(R,C),color(Color)) :-
  assert(dot(cell(R,C),color(Color))).
%---Ensures to add the users selected colors at the particular cell--
%--------------------------------------------------------------
%==============================================================
%========================DEMOS=================================
%------------------------DEMO 1: Display the empty-------------
demo1 :-
   display_world,
   listing(dot).
%------------------------DEMO 2: Display the world with diff----
%------------------------colored dots on the table--------------
demo2 :-
   add_dot(cell(1,1),color(red)),
   add_dot(cell(1,2),color(blue)),
   add_dot(cell(1,3),color(yellow)),
   add_dot(cell(1,4),color(green)),
   add_dot(cell(1,5),color(purple)),
   add_dot(cell(1,6),color(orange)),
   display_world,
   listing(dot).
%----------------------------------------------------------------
%Clears the world, one row at a time
clear_world :-
  clear_cell(_,_),fail.
clear_world :-
  make_table.
  
clear_cell(_,_) :-
  retract(dot(cell(_,_),_)).
clear_cell(_,_).
%-----------------------------------------------------------------
%---------------------------DEMO 3: demonstrate that the clear world
%---------------------------command works-------------------------
demo3 :-
  clear_world,
  demo2,
  clear_world,
  demo1.
%-------------------------------------------------------------------
%--------------------------DEMO 4: demonstrate that we cannot place-
%-----a dot in a full postion---------------------------------------
demo4 :-
  clear_world,
  add_dot(cell(1,1),color(red)),
  add_dot(cell(1,1),color(blue)),
  add_dot(cell(1,2),color(blue)),
  display_world.
%----------------------------------------------------------------------
%--------------DEMO 5: demonstrating that the dots cannot float--------
demo5 :-
   clear_world,
   add_dot(cell(1,1),color(red)),
   add_dot(cell(1,2),color(blue)),
   add_dot(cell(4,3),color(yellow)),
   add_dot(cell(3,4),color(green)),
   add_dot(cell(2,5),color(purple)),
   add_dot(cell(1,6),color(orange)),
   display_world.