filme(amnesia, suspense, nolan, 2000, 113).
filme(babel, drama, inarritu, 2006, 142).
filme(capote, drama, miller, 2005, 98).
filme(casablanca, romance, curtiz, 1942, 102).
filme(matrix, ficcao, wachowsk, 1999, 136).
filme(rebecca, suspense, hitchcock, 1940, 130).
filme(shrek, aventura, adamson, 2001, 90).
filme(sinais, ficcao, shymalan, 2002, 106).
filme(spartacus, acao, kubrik, 1960, 184).
filme(superman, aventura, donner, 1978, 143).
filme(titanic, romance, cameron, 1997, 194).
filme(tubarao, suspense, spielberg, 1975, 124).
filme(volver, drama, almodovar, 2006, 121).

dirigiu(X,Y) :- filme(X,_,Y,_,_). %6
suspense(X) :- filme(X,suspense,_,_,_). %3
lancamento(X,Y) :- filme(X,_,_,Y,_). %7
duracaomenor100(X) :- filme(X,_,_,_,N) , N < 100. %4
lancamentoentre(X) :- filme(X,_,_,N,_), N > 1999 , N < 2005. %5

classico(X) :- filme(X,_,_,N,_), N < 1980.  %1
genero(X,Y) :- filme(X,Y,_,_,_). %8

classicosuspense(X) :- classico(X) , genero(X,suspense). %2