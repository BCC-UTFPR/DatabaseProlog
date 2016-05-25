aluno(joao, calculo).
aluno(maria, calculo).
aluno(joel, programacao).
aluno(joao, estrutura).

frequenta(joao, uem).
frequenta(maria, uem).
frequenta(joel, utfpr).

professor(carlos, calculo).
professor(ana_paula, estrutura).
professor(pedro, programacao).

funcionario(pedro, utfpr).
funcionario(ana_paula, uem).
funcionario(carlos, uem).

associados(Universidade,Y) :- funcionario(Y,Universidade).
associados(Universidade,Y) :- frequenta(Y,Universidade).

alunosdo(X,Y) :- professor(X,A) , aluno(Y,A).