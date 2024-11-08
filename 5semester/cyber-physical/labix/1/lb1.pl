parent("Sasha","Sergey").
parent("Sasha","Toma").
parent("Nastya","Sergey").
parent("Nastya","Toma").

married("Sasha","Nastya").

parent("Andrey","Danya").
parent("Andrey","Nina").
parent("Ira","Danya").
parent("Ira","Nina").

married("Andrey","Ira").

parent("Vladimir","Andrey").
parent("Vladimir","Sasha").
parent("Valentina","Andrey").
parent("Valentina","Sasha").

married("Vladimir","Valentina").

man("Andrey").
man("Sasha").
man("Danya").
man("Sergey").
man("Vladimir").

woman("Toma").
woman("Nina").
woman("Nastya").
woman("Ira").
woman("Valentina").


check_married(X,Y):-
  married(X,Y);
  married(Y,X).

father(X,Y) :-
  parent(X,Y),
  man(X).

mother(X,Y) :-
  parent(X,Y),
  woman(X).

sibling(X,Y) :-
  parent(Z,X),
  parent(Z,Y),
  X\=Y.

sister(X,Y) :-
  sibling(X,Y),
  woman(X).

brother(X,Y) :-
  sibling(X,Y),
  man(X).

son(X,Y) :-
  parent(Y,X),
  man(X).

daughter(X,Y) :-
  parent(Y,X),
  woman(X).

wife(X,Y) :-
  check_married(X,Y),
  woman(X).

husband(X,Y) :-
  check_married(X,Y),
  man(X).

aunt(X,Y) :-
  parent(Z,Y),
  sibling(Z,X),
  woman(X).

uncle(X,Y) :-
  parent(Z,Y),
  sibling(X,Z),
  man(X).

grandmother(X,Y) :-
  parent(X,Z),
  parent(Z,Y),
  woman(X).

grandfather(X,Y) :-
  parent(X,Z),
  parent(Z,Y),
  man(X).

shurin(Y,X) :-
  wife(Z,X),
  brother(Y,Z),
  man(Y).

dever(X,Y) :-
  husband(Z,Y),
  brother(X,Z),
  man(X),
  woman(Y).

?-father(X,"Nina"),write(X),write("\n").
?-mother(X,"Danya"),write(X),write("\n").
?-married("Vladimir","Valentina"),write("\n").
?-husband(X,"Ira"),write(X),write("\n").
?-wife(X,"Sasha"),write(X),write("\n").
?-sister("Nina","Danya"),write("YES\n").
?-grandfather(X,"Danya"),write(X),write("\n").
?-grandmother(X,"Danya"),write(X),write("\n").
?-dever(X,"Ira"),write(X),write("\n").
?-sister("Toma","Danya"),write("YEAH!\n").
