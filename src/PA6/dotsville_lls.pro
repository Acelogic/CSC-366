% ------------------------------------------------------------------------------
% File:  dotsville_lls.pro
% Type:  Prolog source
% Line:  Dotsville - low level semantics
% Date:  2020
% Author: Miguel Cruz
% ------------------------------------------------------------------------------

% ------------------------------------------------------------------------------
% libraries

:- consult('dotsville.pro').
:- consult('lp.pro').
:- consult('gv.pro').

% ------------------------------------------------------------------------------
% just a few states of the world, the third of which is featured in the demos

state1 :-
  clear_world,
  add_dot(cell(1,1),color(blue)),
  add_dot(cell(2,1),color(blue)),
  add_dot(cell(1,3),color(red)),
  add_dot(cell(2,3),color(yellow)),
  add_dot(cell(3,3),color(orange)),
  display_world.

state2 :-
  clear_world,
  add_dot(cell(1,1),color(red)),
  add_dot(cell(1,2),color(blue)),
  add_dot(cell(2,2),color(red)),
  display_world.

state3 :-
  clear_world,
  add_dot(cell(1,2),color(yellow)),
  add_dot(cell(1,4),color(red)),
  add_dot(cell(2,4),color(red)),
  add_dot(cell(1,6),color(blue)),
  add_dot(cell(2,6),color(green)),
  add_dot(cell(3,6),color(blue)),
  add_dot(cell(4,6),color(green)),
  display_world.

% ------------------------------------------------------------------------- Task #1 
% exists_dot_of_color(Color)
% --- succeeds if there is a dot of color Color

% --> Task 1: Define the method here (Completed)

exists_dot_of_color(Color) :-
  dot(_,color(Color)).

demo__exists_dot_of_color :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  exists_dot_of_color'), nl,
  state3,
  exists_dot_of_color(blue),
  write('>>> there is a blue dot'),nl,
  not(exists_dot_of_color(purple)),
  write('>>> there is no purple dot'),nl.
  
% ------------------------------------------------------------------------- Task #2 
% exists_dot_of_color_on_table(Color)
% --- succeeds if there is a dot of color Color

% --> Task 2: Define the method here (Completed)

exists_dot_of_color_on_table(Color) :-
  dot(cell(1,_),color(Color)).

demo__exists_dot_of_color_on_table :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  exists_dot_of_color_on_table'), nl,
  state3,
  exists_dot_of_color_on_table(blue),
  write('>>> there is a blue dot on the table'),nl,
  not(exists_dot_of_color_on_table(green)),
  write('>>> there is no green dot on the table'),nl.

% ------------------------------------------------------------------------- Task #3
% exists_dot_left_of(Color1,Color2)
% --- succeeds if there is a dot of Color1 to the left of a dot of Color2

% --> Task 3: Define the method here (Completed)

exists_dot_left_of(Color1,Color2) :- 
  dot(cell(_,Column1),color(Color1)),
  dot(cell(_,Column2),color(Color2)),
  Column1 < Column2.

demo__exists_dot_left_of :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  exists_dot_left_of'), nl,
  state3,
  exists_dot_left_of(red,blue),
  write('>>> there is a red dot to the left of a blue dot'),nl,
  not(exists_dot_left_of(blue,red)),
  write('>>> there is not a blue dot to the left of a red dot.'),nl.
  
% ------------------------------------------------------------------------- Task #4 
% exists_dot_right_of(Color1,Color2)
% --- succeeds if there is a dot of Color1 to the right of a dot of Color2

% --> Task 4: Define the method here (Completed)

exists_dot_right_of(Color1,Color2) :- 
  dot(cell(_,Column1),color(Color1)),
  dot(cell(_,Column2),color(Color2)),
  Column1 > Column2.

demo__exists_dot_right_of :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  exists_dot_right_of'), nl,
  state3,
  exists_dot_right_of(blue,red),
  write('>>> there is a blue dot to the right of a red dot'),nl,
  not(exists_dot_right_of(red,blue)),
  write('>>> there is not a red dot to the right of a blue dot.'),nl.
  
% ------------------------------------------------------------------------- Task #5
% list_dots_of_color(Color)
% --- lists all of the dots of color Color

% --> Task 5: Just study this code, and carefully enter it into your file (Completed)

list_dots_of_color(Color) :-
  dot(cell(R,C),color(Color)),
  write(dot(cell(R,C),color(Color))), nl,
  fail.
list_dots_of_color(_).

demo__list_dots_of_color :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  list_dots_of_color'), nl,
  state3,
  write('>>> these are the blue dots ...'),nl,
  list_dots_of_color(blue),
  write('>>> these are the red dots ...'),nl,
  list_dots_of_color(red),
  write('>>> these are the purple dots ...'),nl,
  list_dots_of_color(purple).

% -------------------------------------------------------------------------  Task #6
% list_dots_in_column(Column)
% --- lists all of the dots in column Column

% --> Task 6: Define the method here (Completed)

list_dots_in_column(Column) :-
  dot(cell(R,Column),color(Color)),
  R > 0, 
  write(dot(cell(R,Column),color(Color))), nl,
  fail.
 list_dots_in_column(_).

demo__list_dots_in_column :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  list_dots_in_column'), nl,
  state3,
  write('>>> these are the dots in column 1 ...'),nl,
  list_dots_in_column(1),
  write('>>> these are the dots in column 2 ...'),nl,
  list_dots_in_column(2),
  write('>>> these are the dots in column 3 ...'),nl,
  list_dots_in_column(3),
  write('>>> these are the dots in column 4 ...'),nl,
  list_dots_in_column(4),
  write('>>> these are the dots in column 5 ...'),nl,
  list_dots_in_column(5),
  write('>>> these are the dots in column 6 ...'),nl,
  list_dots_in_column(6).

% -------------------------------------------------------------------------  Task #7
% add_dot_to_column(Column,Color)
% --- add a dot of the given Color to the given Column

% --> Task 7: Just study this code, and carefully enter it into your file (Completed)

add_dot_to_column(Column,Color) :-
  not(dot(cell(1,Column),_)),
  add_dot(cell(1,Column),color(Color)).
add_dot_to_column(Column,Color) :-
  not(dot(cell(2,Column),_)),
  add_dot(cell(2,Column),color(Color)).
add_dot_to_column(Column,Color) :-
  not(dot(cell(3,Column),_)),
  add_dot(cell(3,Column),color(Color)).
add_dot_to_column(Column,Color) :-
  not(dot(cell(4,Column),_)),
  add_dot(cell(4,Column),color(Color)).
add_dot_to_column(Column,_) :-
  write('### no room to add a dot to column '),write(Column),nl.

demo__add_dot_to_column :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  add_dot_to_column'), nl,
  state3,
  add_dot_to_column(2,red),
  add_dot_to_column(4,purple),
  add_dot_to_column(6,yellow),
  write('>>> after adding red and purple dots to columns 2 and 4:  '), nl,
  display_world.

% ------------------------------------------------------------------------ Task #8
% add_random_dot(Row,Col)
% --- add a randomly colored dot in row Row and column Col

% --> Task 8: Define the method here  (Completed)

add_random_dot(Row,Col) :-
  pick([red,blue,yellow,orange,purple,green],Color),
    not(dot(cell(Row,Col),_)),
    add_dot(cell(Row,Col),color(Color)).
  
demo__add_random_dot :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  add_random_dot'), nl,
  state3,
  add_random_dot(1,1),
  add_random_dot(2,1),
  add_random_dot(3,1),
  add_random_dot(4,1),
  add_random_dot(1,3),
  add_random_dot(2,3),
  add_random_dot(3,3),
  add_random_dot(4,3),
  write('>>> the world after filling columns 1 and 3 with random dots ...'),nl,
  display_world.

% ------------------------------------------------------------------------- Task #9
% remove_dot_from_column(Column)
% --- succeeds if there is at least one dot in a column by removing top dot

% --> Task 9: Just study this code, and carefully enter it into your file (Completed)

remove_dot_from_column(Column) :-
  dot(cell(4,Column),_), retract(dot(cell(4,Column),_) ).
remove_dot_from_column(Column) :-
  dot(cell(3,Column),_), retract(dot(cell(3,Column),_) ).
remove_dot_from_column(Column) :-
  dot(cell(2,Column),_), retract(dot(cell(2,Column),_) ).
remove_dot_from_column(Column) :-
  dot(cell(1,Column),_), retract(dot(cell(1,Column),_) ).
remove_dot_from_column(Column) :-
  write('### There is no dot in column '), write(Column), write(' to remove.'), nl.

demo__remove_dot_from_column :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  remove_dot_from_column'), nl,
  state3,
  remove_dot_from_column(1),
  remove_dot_from_column(2),
  remove_dot_from_column(3),
  remove_dot_from_column(4),
  remove_dot_from_column(5),
  remove_dot_from_column(6),
  write('>>> after removing a dot from each nonempty column ...'),nl,
  display_world.
  

% ------------------------------------------------------------------------- Task #10
% count_dots_in_column(Column,Count)
% --- returns the number of dots in the given column

% --> Task 10: Define the method here (Completed)

count_dots_in_column(Column,4) :-
	dot(cell(4,Column),_).
count_dots_in_column(Column,3) :-
  	dot(cell(3,Column),_).
count_dots_in_column(Column,2) :-
  	dot(cell(2,Column),_).
count_dots_in_column(Column,1) :-
  	dot(cell(1,Column),_).
count_dots_in_column(Column,0) :-
  	dot(cell(0,Column),_).
  
demo__count_dots_in_column :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  count_dots_in_column'), nl,
  state3,
  count_dots_in_column(1,Count1),
  write('>>> number of dots in column 1:  '), write(Count1), nl,
  count_dots_in_column(2,Count2),
  write('>>> number of dots in column 2:  '), write(Count2), nl,
  count_dots_in_column(3,Count3),
  write('>>> number of dots in column 3:  '), write(Count3), nl,
  count_dots_in_column(4,Count4),
  write('>>> number of dots in column 4:  '), write(Count4), nl,
  count_dots_in_column(5,Count5),
  write('>>> number of dots in column 5:  '), write(Count5), nl,
  count_dots_in_column(6,Count6),
  write('>>> number of dots in column 6:  '), write(Count6), nl.

% ------------------------------------------------------------------------- Task #11
% count_dots(Count)
% --- returns the number of dots in the world

% --> Task 11: Define the method here (Completed)

count_dots(Count) :-
  count_dots_in_column(1,Count1),
  count_dots_in_column(2,Count2),
  count_dots_in_column(3,Count3),
  count_dots_in_column(4,Count4),
  count_dots_in_column(5,Count5),
  count_dots_in_column(6,Count6),
  Count is Count1 + Count2 + Count3 + Count4 + Count5 + Count6.

demo__count_dots :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  count_dots'), nl,
  state3,
  count_dots(Count),
  write('>>> number of dots in the world:  '), write(Count), nl.

% ------------------------------------------------------------------------- Task #12
% available_space_count_in_column(Column,Count)
% --- returns the number available spaces in the given column

% --> Task 12: Define the method here   (Completed)

available_space_count_in_column(Column,Count) :-
  count_dots_in_column(Column,C),
  Count is 4 - C.
  
demo__available_space_count_in_column :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  available_space_count_in_column'), nl,
  state3,
  available_space_count_in_column(1,Count1),
  write('>>> space available in column 1:  '), write(Count1), nl,
  available_space_count_in_column(2,Count2),
  write('>>> space available in column 2:  '), write(Count2), nl,
  available_space_count_in_column(3,Count3),
  write('>>> space available in column 3:  '), write(Count3), nl,
  available_space_count_in_column(4,Count4),
  write('>>> space available in column 4:  '), write(Count4), nl,
  available_space_count_in_column(5,Count5),
  write('>>> space available in column 5:  '), write(Count5), nl,
  available_space_count_in_column(6,Count6),
  write('>>> space available in column 6:  '), write(Count6), nl.

% ------------------------------------------------------------------------- Task #13
% available_space_count(Count)
% --- returns the number of dots available in the world

% --> Task 13: Define the method here (Completed)

available_space_count(Count) :-
  available_space_count_in_column(1,Count1),
  available_space_count_in_column(2,Count2),
  available_space_count_in_column(3,Count3),
  available_space_count_in_column(4,Count4),
  available_space_count_in_column(5,Count5),
  available_space_count_in_column(6,Count6),
  Count is Count1 + Count2 + Count3 + Count4 + Count5 + Count6.

demo__available_space_count :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  available_space_count'), nl,
  state3,
  available_space_count(Count),
  write('>>> number of spaces available in the world:  '), write(Count), nl.
  
% ------------------------------------------------------------------------- Task #14
% fill_column(Column)
% --- fill the specified column with randomly colored dots

% --> Task 14: Just study this code, and carefully enter it into your file (Completed)

fill_column(Column) :-
  available_space_count_in_column(Column,Count),
  add_random_dots_to_column(Column,Count).

add_random_dots_to_column(_,0).
add_random_dots_to_column(Column,N) :-
  add_random_dot_to_column(Column),
  NM1 is N-1,
  add_random_dots_to_column(Column,NM1).

add_random_dot_to_column(Column) :-
  not(dot(cell(1,Column),_)),
  add_random_dot(1,Column).
add_random_dot_to_column(Column) :-
  not(dot(cell(2,Column),_)),
  add_random_dot(2,Column).
add_random_dot_to_column(Column) :-
  not(dot(cell(3,Column),_)),
  add_random_dot(3,Column).
add_random_dot_to_column(Column) :-
  not(dot(cell(4,Column),_)),
  add_random_dot(4,Column).
add_random_dot_to_column(Column) :-
  write('### no room to add a random dot to column '),write(Column),nl.
  
demo__fill_column :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  fill_column'), nl,
  state3,
  fill_column(1),
  fill_column(2),
  fill_column(3),
  fill_column(4),
  fill_column(5),
  fill_column(6),
  write('>>> the world after filling all of the columns:  '), nl,
  display_world.

% ------------------------------------------------------------------------- Task #15
% fill_world
% --- fill the world with randomly colored dots

%--> Task 15: Define the method here (Completed)

fill_world :-
  fill_column(1),
  fill_column(2),
  fill_column(3),
  fill_column(4),
  fill_column(5),
  fill_column(6).
  
demo__fill_world :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  fill_world'), nl,
  state3,
  fill_world,
  write('>>> after filling the world:  '), nl,
  display_world.

% ------------------------------------------------------------------------- Task #16
% sprinkle_dots(NumberOfDots)
% --- sprinkle so many randomly colored dots into random columns

% --> Task 16: Just study this code, and carefully enter it into your file (Completed)

sprinkle_dots(0).
sprinkle_dots(N) :-
  available_space_count(Count),
  N > Count,
  write('### not enough space available in the world for the sprinkling.'), nl.
sprinkle_dots(N) :-
  sprinkle_the_dots_for_real(N). 
  
sprinkle_the_dots_for_real(0).
sprinkle_the_dots_for_real(N) :-
  sprinkle_one_dot,
  NM1 is N-1,
  sprinkle_the_dots_for_real(NM1).

sprinkle_one_dot :-
  available_spaces(S),
  pick(S,space(Row,Column)),
  add_random_dot(Row,Column).
  
available_spaces(ListOfSpaces) :-
  available_spaces(1,ListOfSpaces).

available_spaces(6,[Space]) :-
  available_space_count_in_column(6,Count),
  Count > 0,
  nextSpace(6,Space).
available_spaces(6,[]).

available_spaces(C,ListOfSpacesC) :-
  available_space_count_in_column(C,Count),
  Count > 0,
  nextSpace(C,Space),
  D is C + 1,
  available_spaces(D,ListOfSpacesD),
  ListOfSpacesC = [Space|ListOfSpacesD].
available_spaces(C,ListOfSpacesC) :-
  D is C + 1,
  available_spaces(D,ListOfSpacesD),
  ListOfSpacesC = ListOfSpacesD.

nextSpace(Column,space(1,Column)) :- not(dot(cell(1,Column),_)).
nextSpace(Column,space(2,Column)) :- not(dot(cell(2,Column),_)).
nextSpace(Column,space(3,Column)) :- not(dot(cell(3,Column),_)).
nextSpace(Column,space(4,Column)) :- not(dot(cell(4,Column),_)).

demo__sprinkle_dots :-
nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  sprinkle_dots'), nl,
  clear_world,
  display_world,
  sprinkle_dots(12),
  write('>>> after sprinkling 12 dots on the empty world:  '), nl,
  display_world,
  clear_world,
  write('>>> after clearning the world:  '), nl,
  display_world,
  sprinkle_dots(12),
  write('>>> after sprinkling 12 dots on the empty world:  '), nl,
  display_world.

% ------------------------------------------------------------------------- Task #17
% is_empty_column(Column)
% --- succeed if the specified column is empty

% --> Task 17: Define the method here (Completed)

is_empty_column(0).
is_empty_column(Column):-
  available_space_count_in_column(Column,Count),
  Empty is Count - 4,
  Empty < 0,!,fail.
is_empty_column(Column):-
  available_space_count_in_column(Column,Count),
  Empty is Count - 4,
  Empty = 0,!.
  
demo__is_empty_column :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  is_empty_column'), nl,
  state3,
  is_empty_column(3),
  write('>>> column 3 is empty '), nl,
  not(is_empty_column(4)),
  write('>>> column 4 is not empty '), nl.

% ------------------------------------------------------------------------- Task #18
% is_full_column(Column)
% --- succeed if the specified column is full

% --> Task 18: Define the method here (Completed)

is_full_column(0).
is_full_column(Column):-
  available_space_count_in_column(Column,Count),
  Count > 4,!,fail.
is_full_column(Column):-
  available_space_count_in_column(Column,Count),
  Count = 0,!.

demo__is_full_column :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  is_full_column'), nl,
  state3,
  not(is_full_column(4)),
  write('>>> column 4 is not full '), nl,
  not(is_full_column(5)),
  write('>>> column 5 is not full '), nl,
  is_full_column(6),
  write('>>> column 6 is full '), nl.

% ------------------------------------------------------------------------- Task #19
% move_dot_from_column_to_column(Column1,Column2)  
% --- move a dot from Column1 to Column2, if possible

% --> Task 19: Just study this code, and carefully enter it into your file (Completed)

move_dot_from_column_to_column(Column1,Column2) :-
  not(is_empty_column(Column1)),
  not(is_full_column(Column2)),
  top_dot(Column1,dot(_,color(Color))),
  remove_dot_from_column(Column1),
  add_dot_to_column(Column2,Color).

top_dot(Column,Dot) :-
  dot(cell(4,Column),color(Color)), Dot = dot(cell(4,Column),color(Color)).
top_dot(Column,Dot) :-
  dot(cell(3,Column),color(Color)), Dot = dot(cell(3,Column),color(Color)).
top_dot(Column,Dot) :-
  dot(cell(2,Column),color(Color)), Dot = dot(cell(2,Column),color(Color)).
top_dot(Column,Dot) :-
  dot(cell(1,Column),color(Color)), Dot = dot(cell(1,Column),color(Color)).


demo__move_dot_from_column_to_column :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  move_dot_from_column_to_column'), nl,
  state3,
  move_dot_from_column_to_column(2,1),
  move_dot_from_column_to_column(4,1),
  move_dot_from_column_to_column(6,1),
  move_dot_from_column_to_column(4,6),
  write('after moving dots from columns 2 to 1, 4 to 2, 6 to 1, and 4 to 6'),nl,
  display_world.


% ------------------------------------------------------------------------- Task #20
% count_dots_of_color_in_column(Color,Column,Count)
% --- count the number of dots of a particular Color in the given Column

% --> Task 20: Just study this code, and carefully enter it into your file (Completed)

count_dots_of_color_in_column(Color,Column,Count) :-
  declare(count,0),
  count_the_colored_dots_in_the_column(Color,Column),
  valueOf(count,Count),
  undeclare(count).

count_the_colored_dots_in_the_column(Color,Column) :-
  dot(cell(_,Column),color(Color)),
  inc(count),
  fail.
count_the_colored_dots_in_the_column(_,_).
  
demo__count_the_colored_dots_in_the_column :-
  nl, nl, write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> demo:  count_the_colored_dots_in_the_column'), nl,
  fill_world,
  display_world,
  count_dots_of_color_in_column(blue,1,CountBlue1),
  write('>>> number of blue dots in column 1 = '), write(CountBlue1), nl,
  count_dots_of_color_in_column(blue,2,CountBlue2),
  write('>>> number of blue dots in column 2 = '), write(CountBlue2), nl,
  count_dots_of_color_in_column(blue,3,CountBlue3),
  write('>>> number of blue dots in column 3 = '), write(CountBlue3), nl,
  count_dots_of_color_in_column(blue,4,CountBlue4),
  write('>>> number of blue dots in column 4 = '), write(CountBlue4), nl,
  count_dots_of_color_in_column(blue,5,CountBlue5),
  write('>>> number of blue dots in column 5 = '), write(CountBlue5), nl,
  count_dots_of_color_in_column(blue,6,CountBlue6),
  write('>>> number of blue dots in column 6 = '), write(CountBlue6), nl,
  fill_world,
  display_world,
  count_dots_of_color_in_column(purple,1,CountPurple1),
  write('>>> number of purple dots in column 1 = '), write(CountPurple1), nl,
  count_dots_of_color_in_column(purple,2,CountPurple2),
  write('>>> number of purple dots in column 2 = '), write(CountPurple2), nl,
  count_dots_of_color_in_column(purple,3,CountPurple3),
  write('>>> number of purple dots in column 3 = '), write(CountPurple3), nl,
  count_dots_of_color_in_column(purple,4,CountPurple4),
  write('>>> number of purple dots in column 4 = '), write(CountPurple4), nl,
  count_dots_of_color_in_column(purple,5,CountPurple5),
  write('>>> number of purple dots in column 5 = '), write(CountPurple5), nl,
  count_dots_of_color_in_column(purple,6,CountPurple6),
  write('>>> number of purple dots in column 6 = '), write(CountPurple6), nl.

  
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% demos
% --- run all of the demos

demos :-
  nl, write('>>> beginning of demos'), nl, nl,
demo__exists_dot_of_color,
demo__exists_dot_of_color_on_table,
demo__exists_dot_left_of,
demo__exists_dot_right_of,
demo__list_dots_of_color,
demo__list_dots_in_column,
demo__add_dot_to_column,
demo__add_random_dot,
demo__remove_dot_from_column,
demo__count_dots_in_column,
demo__count_dots,
demo__available_space_count_in_column,
demo__available_space_count,
demo__fill_column,
demo__fill_world,
demo__sprinkle_dots,
demo__is_empty_column,
demo__is_full_column,
demo__move_dot_from_column_to_column,
demo__count_the_colored_dots_in_the_column,
  nl, write('>>> end of demos'), nl.

