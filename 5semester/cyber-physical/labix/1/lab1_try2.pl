parent("Alexandr","Olya").
parent("Masha","Olya").
parent("Alexandr","Alina").
parent("Masha","Alina").
parent("Alexandr","Leha").
parent("Masha","Leha").
parent("Leha","Gleb").
parent("Dasha","Gleb").
parent("Alina","Maks").
parent("Leha","Maks").

man("Alexandr").
man("Leha").
man("Pavel").
man("Dima").

woman("Olya").
woman("Alina").
woman("Masha").

married("Masha","Pavel").
married("Alina","Dima").

check_married(X, Y):-
  married(X, Y); married(Y, X).

father(X,Y):-
  parent(X,Y),man(X).

mother(X,Y):-
  parent(X,Y),woman(X).

sister(X,Y):-
  parent(Z,X), parent(Z,Y), woman(X), X\=Y.

brother(X,Y):-
  parent(Z,Y),parent(Z,X),man(X), X\=Y.

son(X,Y):-
  parent(Y,X),man(X).

daughter(X,Y):-
  parent(Y,X),woman(X).

wife(X,Y):-
  check_married(X,Y), woman(X).

husband(X,Y):-
  check_married(X,Y), man(X).

brother_in_law(X, Y):-
  wife(Y, Wife),
  brother(X, Wife).

mother_in_law(X,Y):-
  wife(Y, Wife),
  mother(X, Wife).

uncle(X, Y):-
  parent(Parent, Y), 
  brother(X, Parent).

dever(X,Y) :-
  man(X),
  husband(Z,Y),
  brother(X,Z)
  woman(Y).

?-father(X,"Olya"),write(X),write(" ").
?-mother(X,"Alina"),write(X),write(" ").
?-married("Alina","Dima"),write(" ").
?-husband(X,"Masha"),write(X),write(" ").
?-wife(X,"Pavel"),write(X),write(" ").
?-sister("Olya","Alina"),write(" ").
?-brother_in_law(X,"Dima"),write(X),write(" ").
?-mother_in_law(X,"Dima"),write(X),write(" ").
?-uncle(X,"Maks"),write(X),write(" ").
?-dever(X,)



