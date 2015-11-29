%pag 25 apostila de prolog
uniao([],B,B).
uniao([X|A], B, [X|C]) :- uniao(A,B,C).