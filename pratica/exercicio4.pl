nota(joao, 50).
nota(maria, 60).
nota(joana, 80).
nota(mariana, 90).
nota(cleuza, 85).
nota(jose, 65).
nota(joaquim, 45).
nota(mara, 40).
nota(mary, 100).

aprovados(X) :- nota(X,N) , N > 70.
reprovados(X) :- nota(X,N) , N < 49. 
recuperacao(X) :- nota(X,N) , N >= 50 , N < 69. 
