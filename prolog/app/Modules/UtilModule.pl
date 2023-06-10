:- module(UtilModule,[centeredText/2, clearScreen/0, readOptions/1,mapGenres/2, listToString/2, toUpperCase/2, listToInt/2, listToBooks/2]).
:- use_module("BookModule.pl").

centeredText(Text, Width) :-
    string_length(Text, Length),
    Line1SpacesBefore is (Width - Length) // 2,
    Line1SpacesAfter is Width - Length - Line1SpacesBefore,
    write_dashed_line(Width),
    nl,
    write_spaces(Line1SpacesBefore),
    write(Text),
    write_spaces(Line1SpacesAfter),
    nl,
    write_dashed_line(Width),!.

write_dashed_line(Width) :-
    Width > 0,
    write('-'),
    Width1 is Width - 1,
    write_dashed_line(Width1),!.
write_dashed_line(0):-!.

write_spaces(N) :-
    N > 0,
    write(' '),
    N1 is N - 1,
    write_spaces(N1),!.
write_spaces(0):-!.


clearScreen :-
    current_prolog_flag(windows, true), !,
    shell('cls'),!.

clearScreen :-
    current_prolog_flag(unix, true), !,
    shell('clear'),!.


readOptions([Number| Rest]) :-
    read(Number),
    Number \= -1,
    readOptions(Rest), !.
readOptions([]):-!.


mapGenres([], []):-!.
mapGenres([1|T], ['Ficcao'|MappedTail]) :-
    mapGenres(T, MappedTail),!.
mapGenres([2|T], ['Fantasia'|MappedTail]) :-
    mapGenres(T, MappedTail),!.
mapGenres([3|T], ['Infantil'|MappedTail]) :-
    mapGenres(T, MappedTail),!.
mapGenres([4|T], ['Misterio'|MappedTail]) :-
    mapGenres(T, MappedTail),!.
mapGenres([5|T], ['Historia'|MappedTail]) :-
    mapGenres(T, MappedTail),!.
mapGenres([6|T], ['Aventura'|MappedTail]) :-
    mapGenres(T, MappedTail),!.
mapGenres([7|T], ['Romance'|MappedTail]) :-
    mapGenres(T, MappedTail),!.
mapGenres([_|T], MappedList) :-
    mapGenres(T, MappedList),!.

listToString(List, String) :-
    atomic_list_concat(List, ',', String),!.

toUpperCase(String, StringMaiuscula) :-
    atom_string(Atom, String),
    upcase_atom(Atom, AtomMaiusculo),
    atom_string(AtomMaiusculo, StringMaiuscula),!.

listToInt([], []).
listToInt([String|Resto], [Inteiro|Resultado]) :-
    atom_number(String, Inteiro),
    listToInt(Resto, Resultado).

listToBooks([], []).
listToBooks([Head|Tail], [Book|Resultado]) :-
    getBookById(Head, Book),
    listToBooks(Tail, Resultado).
