%tenho que pesquisar as seguintes funções.
%select e member
maximolista(Lista, V) :- select(V,Lista, R), \+((member(X,R), X>V)).