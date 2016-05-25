bonita(cassia).
bonito(marcos).
bonito(fabiano).

rico(marcos).
rica(ana).

forte(ana).
forte(fabiano).
forte(silvio).

amavel(silvio).

homens(marcos).
homens(fabiano).
homens(silvio).

mulheres(cassia).
mulheres(ana).

homensgostam(X):- bonita(X).
homemfeliz(X):- rico(X).

gosta(cassia,X):- rico(X),amavel(X),forte(X).


