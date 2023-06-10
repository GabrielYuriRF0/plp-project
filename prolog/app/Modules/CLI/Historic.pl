:- module(HistoricModule, [printBookHistoric/1, printHistoricMenu/2]).
:- use_module('../UtilModule.pl').
:- use_module('../ValidInput/Validation.pl').
:- use_module('MainMenu.pl').
:- use_module('../CsvModule.pl').
:- use_module('../UserModule.pl').
:- use_module('../BookModule.pl').

printHistoricMenu(User, Book) :-
    nth1(7, User, Historic),
    nth1(2, User, ActualEmail),
    
    
    writeln('Voce leu esse livro?\n'),
    write('Digite <1> para Sim ou <2> para Não: '),
    read(IsRead),
    (IsRead =:= 1 -> checkIsValidSize(Historic, ActualHistoric), write(ActualHisteoric);ActualHistoric = Historic),
    attUserHistoric(User, ActualHistoric),
    getUsers(Users),
    checkUserRegister(ActualEmail, Users, NewUsers),
    nth1(1,NewUsers, NewUser),
    nth1(1, Book, Id),
    bookHistoric(NewUser, Id, IsRead),!.

checkIsValidSize([H|T], T) :-
    length([H|T], Size),
    Size =:= 10, !.
checkIsValidSize(Historic, Historic):-
    length(Historic, Size),
    Size =< 9,!.
checkIsValidSize(_,_):-!.

printBookHistoric(User) :-
    centeredText("Historico de leitura", 60),write("\n"), 
    nth1(7, User, Historic),
    nth1(1, Historic, First),
    split_string(First,",","", FormatedHistoric),
    listToInt(FormatedHistoric, IntList),
    listToBooks(IntList, FinalList),
    printBooks(FinalList).%todo wait on screen

