%exercicio de prática do trabalho de LP, utilizando predicados.
passaro(joao).
peixe(pedro).
minhoca(maria).
gostam(gato,peixe).
gostam(gato,passaro).
gostam(passaro,minhoca).
gato(chucknoris).
pessoa(eu).
amigos(X,eu) :- gato(X).
amigos(X,Y) :- gostam(X,Y).
come(X,Y) :- gostam(X,Y).