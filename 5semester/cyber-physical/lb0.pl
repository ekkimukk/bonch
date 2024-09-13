situ(X) :-
  gorod(X);
  strana(X).

situ(london, england).
situ(lids, england).
situ(lester, england).
situ(petersburg, russia).
situ(moscow, russia).
situ(blagoveshensk, russia).
situ(kiev, ukraine).
situ(odessa, ukraine).
situ(pekin, asia).
situ(kair, egypt).
situ(osaka, japan).
situ(kioto, japan).
situ(tanta, egypt).
situ(vonsan, "north korea").
situ(warszawa, poland).
situ(berlin, europe).
situ(los-angeles, usa).
situ(X, europe):- situ(X, russia).
situ(X, europe):- situ(X, poland).
situ(X, europe):- situ(X, germany).
situ(X, africa):- situ(X, egypt).
situ(X, africa):- situ(X, niger).
situ(X, asia):- situ(X, chine).
situ(X, asia):- situ(X, "north korea").
situ(X, asia):- situ(X, japan).
situ(X, "north america"):- situ(X, usa).

situ(canberra, australia).
situ(X, aaustralia) :- situ(X, canberra).

