% ----------------------------------------------------------------------------
% File:  dotsville_i.pro
% Type:  Prolog source
% Line:  Implementation of an interpreter for Dotspeak
% Date:  November 20, 2020
% ----------------------------------------------------------------------------

%-----------------------------------------------------------------------------
% libraries
:- consult('io.pro').
:- consult('dotsville_lls.pro').

% --------------------------------------------------------------------------
% DCG for the Dotspeak language


% CFG 1-10
% sentence, question, command
sentence --> command,[.].
sentence --> question,[?].
question --> existentialquestion.
question --> countquestion.
question --> contentquestion.
command --> displaycommand.
command --> addcommand.
command --> deletecommand.
command --> movecommand.
command --> [stop],{abort}.

existentialquestion --> [is],[there],nsdot,[not],[on],[the],[table],{is_there_a_dot_not_on_the_table}.
existentialquestion --> [is],[there],nsdot,[on],[the],[table],{is_there_a_dot}.
existentialquestion --> [is],[there],nsdot,{is_there_a_dot}.
existentialquestion --> [is],[there],csdot(Color),[on],[the],[table],{is_there_a_colored_dot_on_the_table(Color)}.
existentialquestion --> [is],[there],csdot(Color),{is_there_a_colored_dot(Color)}.
existentialquestion --> [is],[there],csdot,[to],[the],[left],[of],csdot.
existentialquestion --> [is],[there],csdot,[to],[the],[right],[of],csdot.
existentialquestion --> [is],[there],csdot,[not],[on],[the],[table].

countquestion --> countdots,[in],[column],columnid(Column),{how_many_dots_in_column(Column)}.
countquestion --> countdots,[in],[the],[world],{how_many_dots_in_the_world}.
countquestion --> countdots,[on],[the],[table].
countquestion --> countdots,[off],[the],[table].
countquestion --> countcolordots,[in],[column],columnid.
countquestion --> countcolordots,[in],[the],[world].
countquestion --> countspaces,[in],[column],columnid.
countquestion --> countspaces,[in],[the],[world].

contentquestion --> [is],[column],columnid(Column),[empty],{is_column_empty(Column)}.
contentquestion --> [is],[column],columnid(Column),[full],{is_column_full(Column)}.
contentquestion --> [is],[the],[world],[empty].
contentquestion --> [is],[the],[world],[full].

displaycommand --> [display],[the],[world],{display_world}.
displaycommand --> [list],[the],[dots],{list_the_dots}.
displaycommand --> [list],[the],color,[dots].
displaycommand --> [list],[the],[dots],[in],[column],columnid.
displaycommand --> [list],[the],[dots],[on],[the],[table].
displaycommand --> [list],[the],[dots],[off],[the],[table].

addcommand --> [add],csdot(Color),[to],[column],columnid(Column),{add_dot_to_column(Column,Color)}.
addcommand --> [add],csdot(Color),{add_one_colored_dot(Color)}.
addcommand --> [add],nsdot,{sprinkle_one_dot}.
addcommand --> [add],nsdot,[to],[column],columnid.
addcommand --> [fill],[column],columnid.
addcommand --> [fill],[the],[world],{fill_world}.
addcommand --> [sprinkle],xdigit,[dots],[onto],[the],[world].


deletecommand --> [remove],nsdot,[from],[column],columnid(Column),{remove_dot_from_column(Column)}.
deletecommand --> [remove],nsdot.
deletecommand --> [clear],[the],[world],{clear_world}.


movecommand --> [move],nsdot,[from],[column],columnid,[to],[column],columnid.


countdots --> [how],[many],[dots].
countcolordots --> [how],[many],color,[dots].
countspaces --> [how],[many],[spaces],[available].


nsdot --> [a],[dot].
csdot(Color) --> detcolor(Color),[dot].
detcolor(orange) --> [an],[orange].
detcolor(Color) --> [a],nonorange(Color).


nonorange(blue) --> [blue].
nonorange(yellow) --> [yellow].
nonorange(red) --> [red].
nonorange(green) --> [green].
nonorange(purple) --> [purple].

color --> [orange].
color --> [blue].
color --> [yellow].
color --> [red].
color --> [green].
color --> [purple].


xdigit --> [two].
xdigit --> [2].
xdigit --> [three].
xdigit --> [3].
xdigit --> [four].
xdigit --> [4].
xdigit --> [five].
xdigit --> [5].
xdigit --> [six].
xdigit --> [6].
xdigit --> [seven].
xdigit --> [7].
xdigit --> [eight].
xdigit --> [8].
xdigit --> [nine].
xdigit --> [9].

columnid(1) --> [1].
columnid(2) --> [2].
columnid(3) --> [3].
columnid(4) --> [4].
columnid(5) --> [5].
columnid(6) --> [6].

%-----------------Interpreter/Semantic Support ------------------------
% Interpreter 
interpreter :-
    read_sentence(S),
    sentence(S,[]),
    interpreter.
    interpreter :-
    write('Error ...'),nl,
    interpreter.

% Conditional existance commands


is_there_a_dot :- % is_there_a_dot
    exists_dot_of_color_on_table(_),
    write('Yes.'),nl.
    is_there_a_dot :-
    write('No.'),nl.
    


is_there_not_a_dot :- %is_there_not_a_dot
    not(exists_dot_of_color_on_table(_)),
    write('Yes.'),nl.
is_there_not_a_dot :-
    write('No.'),nl.



is_there_a_dot_to_the_left(Color1,Color2) :- % is_there_a_dot_to_the_left
    exists_dot_left_of(Color1, Color2),
    write('Yes.'),nl.

is_there_a_dot_to_the_left(_,_) :-
    write('No.'),nl.



is_there_a_dot_to_the_right(Color1,Color2) :- % is_there_a_dot_to_the_right
    exists_dot_right_of(Color1, Color2),
    write('Yes.'),nl.

is_there_a_dot_to_the_right(_,_) :-
    write('No.'),nl.


is_column_empty(Column) :- % is_column_empty
    is_empty_column(Column),
    write('Yes.'),nl.

is_column_empty(_) :- % is_column_full (list)
    write('No.'),nl.


is_column_full(Column) :- % is_column_full
    is_full_column(Column),
    write('Yes.'),nl.
is_column_full(_) :-
    write('No.'),nl.


is_color_right_of_color(Color1, Color2) :-  % is_color_right_of_color(Color1, Color2)
    exists_dot_right_of(Color1,Color2), write('Yes.'), nl.
is_color_right_of_color(_, _) :- 
    write('No.'), nl.


is_color_left_of_color(Color1, Color2) :-  % is_color_left_of_color(Color1, Color2)
    exists_dot_left_of(Color1,Color2), write('Yes.'), nl.
is_color_left_of_color(_, _) :- 
    write('No.'), nl.


%-------------------------- Functions ----------------------

% list_the_dots
list_the_dots :- list_dots_in_column(1),
	list_dots_in_column(2),
	list_dots_in_column(3),
	list_dots_in_column(4),
	list_dots_in_column(5),
	list_dots_in_column(6).


remove_random_dot :- % remove_random_dot
    dot(cell(Row,Column),_), Row >= 1, remove_dot_from_column(Column).
remove_random_dot :- 
    write('No dots to remove.'), nl. 


add_one_colored_dot(Color) :-% add_one_colored_dot(Color)
    available_spaces(S),
    pick(S,space(Row,Column)),
    add_dot(cell(Row,Column),color(Color)).

add_one_colored_dot(_) :-
    write('### Could not add the dot.'),nl.


add_one_colored_dot_to_column(Color, Column) :- not(dot(cell(1, Column), color(_))),
        add_dot(cell(1, Column), color(Color)).
add_one_colored_dot_to_column(Color, Column) :- not(dot(cell(2, Column), color(_))),
        add_dot(cell(2, Column), color(Color)).
add_one_colored_dot_to_column(Color, Column) :- not(dot(cell(3, Column), color(_))),
        add_dot(cell(3, Column), color(Color)).
add_one_colored_dot_to_column(Color, Column) :- not(dot(cell(4, Column), color(_))),
        add_dot(cell(4, Column), color(Color)).
add_one_colored_dot_to_column(_, _) :- write('### Could not add the dot.'), nl.


count_dots_of_color_in_world(Color, Count) :- % count_dots_of_color_in_world
    count_dots_of_color_in_column(Color,1,Count1),
    count_dots_of_color_in_column(Color,2,Count2),
    count_dots_of_color_in_column(Color,3,Count3),
    count_dots_of_color_in_column(Color,4,Count4),
    count_dots_of_color_in_column(Color,5,Count5),
    count_dots_of_color_in_column(Color,6,Count6),
    Count is Count1 + Count2 + Count3 + Count4 + Count5 + Count6.