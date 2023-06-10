:- module(BookModule, [getBookById/2, getBookByName/2, getBooksByGenre/2, getBooksByAuthor/2, printAllBooks/0, printBooks/1]).
:- use_module('CsvModule.pl').
:- use_module('UtilModule.pl').
:- use_module(library(lists)).


getAllBooks(AllBooks) :-
    getBooks(Books),
    AllBooks = Books, !.

getBookById(Id, Book) :- 
    getAllBooks(Books), 
    getBookByIdAux(Books, Id, Book),!.
getBookByName(Name, Book):- 
    getAllBooks(Books), 
    getBookByNameAux(Books, Name, Book), !.
getBooksByAuthor(Author, Book) :- 
    getAllBooks(Books), 
    length(Books, Len), 
    getBooksByAuthorAux(Books, 0, Len, Author, [], Book), !.
getBooksByGenre(Genre, Book) :- 
    getAllBooks(Books), 
    length(Books, Len), 
    getBooksByGenreAux(Books, 0, Len, Genre, [], Book),!.

printAllBooks :-
    getAllBooks(Books),
    printBooks(Books),!.

printBooks([Head]):-
    nth0(0, Head, Id),
    nth0(1, Head, Name),
    nth0(2, Head, Author),
    nth0(3, Head, Genre),
    write(Id),
    write(" - "),
    write(Name),
    write(" - "),
    write(Author),
    write(" - "),
    write(Genre),
    write("\n"), !.
printBooks([Head|Tail]) :- 
    nth0(0, Head, Id),
    nth0(1, Head, Name),
    nth0(2, Head, Author),
    nth0(3, Head, Genre),
    write(Id),
    write(" - "),
    write(Name),
    write(" - "),
    write(Author),
    write(" - "),
    write(Genre),
    write("\n"),
    printBooks(Tail).

getBooksByAuthorAux(Array, Cont, Len, Author, Books, Books):-
    Cont =:= Len, !.
getBooksByAuthorAux(Array, Cont, Len, Author, Books, Resposta):-
    nth0(Cont, Array, Output),
    nth0(2, Output, NameAuthor), toUpperCase(NameAuthor, NameAuthorUpper), toUpperCase(Author, AuthorUpper),
    NameAuthorUpper == AuthorUpper,
    append([Output], Books, Array1),
    Cont2 is (Cont + 1),
    getBooksByAuthorAux(Array, Cont2, Len, Author, Array1, Resposta),!.
getBooksByAuthorAux(Array, Cont, Len, Author, Books, Resposta):-
    nth0(Cont, Array, Output),
    nth0(2, Output, NameAuthor), toUpperCase(NameAuthor, NameAuthorUpper), toUpperCase(Author, AuthorUpper),
    NameAuthorUpper \= AuthorUpper,
    Cont2 is Cont + 1,
    getBooksByAuthorAux(Array, Cont2, Len, Author, Books, Resposta),!.

getBookByIdAux([], _, []) :- !.
getBookByIdAux([Head|Tail],Id,Books) :- 
    nth0(0, Head, Out), 
    (Out=:=Id -> Books = Head, !; getBookByIdAux(Tail,Id,Books)),!.

getBookByNameAux([], _, []) :- !.
getBookByNameAux([Head|Tail], Name, Books):- 
    nth0(1, Head, Out), 
    (Out==Name -> Books = Head, !; getBookByNameAux(Tail,Name,Books)),!.



getBooksByGenreAux(Array, Cont, Len, Genre, Books, Books):-
    Cont =:= Len, !.
getBooksByGenreAux(Array, Cont, Len, Genre, Books, Resposta):-
    nth0(Cont, Array, Output),
    nth0(3, Output, NameGenre), toUpperCase(NameGenre, NameGenreUpper), toUpperCase(Genre, GenreUpper),
    NameGenreUpper == GenreUpper,
    append([Output], Books, Array1),
    Cont2 is (Cont + 1),
    getBooksByGenreAux(Array, Cont2, Len, Genre, Array1, Resposta),!.
    
getBooksByGenreAux(Array, Cont, Len, Genre, Books, Resposta):-
    nth0(Cont, Array, Output),
    nth0(3, Output, NameGenre), toUpperCase(NameGenre, NameGenreUpper), toUpperCase(Genre, GenreUpper),
    NameGenreUpper \= GenreUpper,
    Cont2 is Cont + 1,
    getBooksByGenreAux(Array, Cont2, Len, Genre, Books, Resposta),!.
    