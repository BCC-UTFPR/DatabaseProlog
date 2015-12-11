#lang web-server

(require web-server/dispatch)
(require xml net/url)
(require web-server/http)
(require web-server/servlet-env)

;regra de despacho para determinados tipos de URL
;http://docs.racket-lang.org/web-server/dispatch.html
(define-values (servidor servidor-url)
    (dispatch-rules
     [("") main]
     [("fatorial" (integer-arg)) chamada-fatorial]
     [("fibonacci" (integer-arg)) chamada-fibonacci]
     [("maximo" (string-arg)) chamada-maximo]
     [("uniao" (string-arg) (string-arg)) chamada-uniao] ;certo
     [("passaro" (string-arg)) chamada-passaro]
     [("peixe" (string-arg)) chamada-peixe]
     [("minhoca" (string-arg)) chamada-minhoca]
     [("amigos" (string-arg)) chamada-amigos]
     [("meusamigos" (string-arg)) chamada-meusamigos]
     [("come" (string-arg)) chamada-come]
     [("homemfeliz" (string-arg)) chamada-homemfeliz]
     [("bonita" (string-arg)) chamada-bonita]
     [("bonito" (string-arg)) chamada-bonito]
     [("rico" (string-arg)) chamada-rico]
     [("rica" (string-arg)) chamada-rica]
     [("forte" (string-arg)) chamada-forte]
     [("amavel" (string-arg)) chamada-amavel]
     [("homens" (string-arg)) chamada-homens]
     [("mulheres" (string-arg)) chamada-mulheres]
     [("homensgostam" (string-arg)) chamada-homemgosta]
     [("cassiagosta" (string-arg)) chamada-cassia]
     [("nota" (string-arg)) chamada-nota]
     [("aprovados" (string-arg)) chamada-aprovados]
     [("reprovados" (string-arg)) chamada-reprovados]
     [("recuperacao" (string-arg)) chamada-recuperacao]
     [("filmesclassico" (string-arg)) chamada-classico]
     [("filmesclassicosuspense" (string-arg)) chamada-classicosuspense]
     [("filmessuspense" (string-arg)) chamada-suspense]
     [("filmesmenor100" (string-arg)) chamada-menor]
     [("filmeslancamentoentre" (string-arg)) chamada-lancamentoentre]
     [("filmesdiretor" (string-arg)) chamada-diretor]
     [("filmeslancamento" (string-arg)) chamada-lancamento]
     [("filmesporgenero" (string-arg)) chamada-genero]
     [else main]))

#|cada URL diferente deve-se criar um formato de HTML para que apareça na página.
Esta primeira é main que sempre irá ser executado na primeira vez, pode se dizer que é a URL raiz |#
(define (main req) (response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "Para utilizar o servidor utilize a url http://localhost:8080/funcao/parametros"))                                
                                      (body (b, "As funções que tem são:"))
                                      (body (p, "/fatorial"))  ;CERTO
                                      (body (p, "/fibonacci")) ;CERTO
                                      (body (p, "/uniao, exemplo /uniao/1,2,3,4/6,7,8"))
                                      (body (p, "/maximo, exemplo /maximo/1,2,3,4"))
                                      (body (p, "/passaro , para pesquisar o nome do passaro no banco de dados, exemplo /passaro/X"));CERTO
                                      (body (p, "/peixe , para pesquisar o nome do peixe no banco de dados, exemplo /peixe/X"));CERTO
                                      (body (p, "/minhoca, para pesquisar o nome da minhoca no banco de dados, exemplo /minhoca/X"));CERTO
                                      (body (p, "/gato, para pesquisar o nome do gato no banco de dados, exemplo /gato/X"));CERTO
                                      (body (p, "/gostam, para pesquisar o que um determinado animal gosta, exemplo /gostam/gato"));CERTO
                                      (body (p, "/amigos, para pesquisar utilize como parametro o nome do respectivo animal \"gato,passaro,peixe e minhoca,\"")) ;CERTO
                                      (body (p, "/meusamigos, para pesquisar utilize como parametro o nome \"eu\"")) ;CERTO
                                      (body (p, "/come , para pesquisar utilize como exemplo /passaro -> passaro come X")) ;CERTO
                                      (body (p, "/bonita, para pesquisar no banco de dados quem é bonita, exemplo /bonita/X, quem é bonita?")) ;CERTO
                                      (body (p, "/bonito, para pesquisar no banco de dados quem é bonito, exemplo /bonito/X, quem é bonito?")) ; CERTO
                                      (body (p, "/rico , para pesquisar no banco de dados quem é rico, exemplo /rico/X, quem é rico?")) ; CERTO
                                      (body (p, "/forte, para pesquisar no banco de dados quem é forte, exemplo /forte/X, quem é forte?")) ;CERTO
                                      (body (p, "/amavel, para pesquisar no banco de dados quem é forte, exemplo, /amavel/X, quem é amavel?")) ;CERTO
                                      (body (p, "/homens, para pesquisar no banco de dados quem é homem, exemplo, /homem/X, quem é homem?")) ;CERTO
                                      (body (p, "/mulheres, para pesquisar no banco de dados quem é mulher, exemplo, /mulher/X, quem é  mulher?")) ;CERTO
                                      (body (p, "/homensgostam, para pesquisar no banco de dados de quem os homens gostam, /homensgostam/X ")) ;CERTO
                                      (body (p, "/cassiagosta, para pesquisar de quem a Cassia gosta, /cassiagosta/X")) ;CERTO
                                      (body (p, "/homemfeliz , para pesquisar homem que é feliz, exemplo /X -> homem que é feliz ?" )) ;CERTO
                                      (body (p, "/nota , para pesquisar nota de um determinado aluno, os alunos são João, Maria, Joana, Creuza, José, Joaquim, Mara e Mary, a pergunta deve ser feita /nota/joao"));CERTO
                                      (body (p, "/aprovados, para pesquisar aprovados da materia, a pesquisa deve ser feita /aprovados/X"));CERTO
                                      (body (p, "/reprovados, para pesquisar reprovados da materia, a pesquisa deve ser feita /reprovados/X"));CERTO
                                      (body (p, "/recuperacao , para pesquisar alunos em recuperacao, a pesquisa deve ser feita /recuperacao/X"));CERTO
                                      (body (p, "/filmesclassico, para pesquisar filmes classicos, exemplo /filmesclassicos/X")) 
                                      (body (p, "/filmesclassicosuspense, para pesquisar filmes de suspense classico, exemplo /filmesclassicosuspense/X"))
                                      (body (p, "/filmessuspense, para pesquisar filmes que são suspense no banco de dados, exemplo /filmessuspense/X"))
                                      (body (p, "/filmesmenor100, para pesquisar filmes menores que 100 minutos, exemplo /filmesmenor100/X"))
                                      (body (p, "/filmeslancamentoentre, para pesquisar filmes que tiveram lançamento entre 1999 a 2005"))
                                      (body (p, "/filmesdiretor, para pesquisar filmes por diretor,os diretores são: Nolan, Inarritu, Miller, Curtiz, Waschowsk, Hithcock, Adamson, Shymalan, Kubrik, Donner, Cameron, Spielberg e Almodovar, exemplo /filmesdiretor/spielberg"))
                                      (body (p, "/filmeslancamento, para pesquisar filme pelo lançamento do filme, exemplo /filmeslancamento/2005"))
                                      (body (p, "/filmesporgenero, para pesquisar filme pelo genero, os generos são suspense, drama, romance, ficcao e aventura, exemplo /filmesporgenero/suspense"))
                                      
                                      ))) ;CERTO
                                      
;FATORIAL
(define (chamada-fatorial req fat) (response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "Execução da função fatorial com o(s) parâmetro(s) :", (number->string fat)))
                                            (p, "Resultado: ",(number->string(fatorial fat))))))

;função de chamada externa para fatorial
(define (fatorial fat) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/apps/fatorial.pl -g \" fat("(number->string fat)",X),write(X).\" -t halt.")))))) 
                              (string->number (first resultado)))

;FIBONACCI
(define (chamada-fibonacci req fib) (response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "Execução da função fibonacci com o(s) parâmetro(s) : ", (number->string fib)))
                                            (p, "Resultado: ",(number->string(fibonacci fib))))))

;função de chamada externa para fibonacci
(define (fibonacci fib) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/apps/fibonacci.pl -g \" fib("(number->string fib)",X),write(X).\" -t halt.")))))) 
                              (string->number (first resultado)))

;UNIÃO
(define (chamada-uniao req lista1 lista2) (response/xexpr `(html (head (title "Trabalho de LP"))
                                           (body (p, "Execução da função união com o(s) parâmetro(s) ", lista1 " e ", lista2 ".")
                                                 (p, "Resultado: ", (uniao lista1 lista2))))))

;função chamada união
(define (uniao list1 list2) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/apps/uniao.pl -g \"uniao(["list1"],["list2"],X),write(X).\" -t halt."))))))
                              (first resultado))


;MAXIMO
(define (chamada-maximo req maximo) (response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "Execução da função fatorial com o(s) parâmetro(s) :",  maximo)
                                            (p, "Resultado: ",(maximoX maximo))))))

;função de chamada externa para MAXIMO
(define (maximoX maximo) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/apps/maximo.pl -g \"maximolista(["maximo"],X),write(X).\" -t halt.")))))) 
                              (first resultado))


;AMIGOS
(define (chamada-amigos req amigo)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(amigos amigo)))))

;função de chamada externa para amigos
(define (amigos amigo) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio1.pl -g \" amigos("amigo",X),write(X).\" -t halt.")))))) 
                              (first resultado))

;MEUSAMIGOS
(define (chamada-meusamigos req amigos)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(meusamigos amigos)))))

;função de chamada externa para amigos
(define (meusamigos amigos) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio1.pl -g \" amigos(X,"amigos"),write(X).\" -t halt.")))))) 
                              (first resultado))

;COME
(define (chamada-come req come)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(comeX come)))))

;função de chamada externa para COME
(define (comeX come) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio1.pl -g \" come("come",X),write(X).\" -t halt.")))))) 
                              (first resultado))

;PASSARO
(define (chamada-passaro req passaro)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(passaroX passaro)))))

;função de chamada externa para COME
(define (passaroX passaro) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio1.pl -g \" passaro("passaro"),write("passaro").\" -t halt.")))))) 
                              (first resultado))

;PEIXE
(define (chamada-peixe req peixe)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(peixeX peixe)))))

;função de chamada externa para PEIXE
(define (peixeX peixe) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio1.pl -g \" peixe("peixe"),write("peixe").\" -t halt.")))))) 
                              (first resultado))

;MINHOCA
(define (chamada-minhoca req minhoca)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(minhocaX minhoca)))))

;função de chamada externa para  MINHOCA
(define (minhocaX minhoca) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio1.pl -g \" minhoca("minhoca"),write("minhoca").\" -t halt.")))))) 
                              (first resultado))

;GATO
(define (chamada-gato req gato)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(gatoX gato)))))

;função de chamada externa para  GATO
(define (gatoX gato) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio1.pl -g \" minhoca("gato"),write("gato").\" -t halt.")))))) 
                              (first resultado))

;BONITA
(define (chamada-bonita req bonita)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(bonitaX bonita)))))

;função de chamada externa para  BONITA
(define (bonitaX bonita) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio2.pl -g \" bonita("bonita"),write("bonita").\" -t halt.")))))) 
                              (first resultado))

;BONITO
(define (chamada-bonito req bonito)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(bonitoX bonito)))))

;função de chamada externa para  BONITO
(define (bonitoX bonito) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio2.pl -g \" bonito("bonito"),write("bonito").\" -t halt.")))))) 
                              (first resultado))

;RICO
(define (chamada-rico req rico)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(ricoX rico)))))

;função de chamada externa para  RICO
(define (ricoX rico) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio2.pl -g \" rico("rico"),write("rico").\" -t halt.")))))) 
                              (first resultado))

;RICA
(define (chamada-rica req rica)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(ricaX rica)))))

;função de chamada externa para  RICA
(define (ricaX rica) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio2.pl -g \" rica("rica"),write("rica").\" -t halt.")))))) 
                              (first resultado))

;FORTE
(define (chamada-forte req forte)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(forteX forte)))))

;função de chamada externa para  FORTE
(define (forteX forte) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio2.pl -g \" forte("forte"),write("forte").\" -t halt.")))))) 
                              (first resultado))

;AMAVEL
(define (chamada-amavel req amavel)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(amavelX amavel)))))

;função de chamada externa para  AMAVEL
(define (amavelX amavel) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio2.pl -g \" amavel("amavel"),write("amavel").\" -t halt.")))))) 
                              (first resultado))

;MULHERES
(define (chamada-mulheres req mulheres)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(mulheresX mulheres)))))

;função de chamada externa para  MULHERES
(define (mulheresX mulheres) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio2.pl -g \" mulheres("mulheres"),write("mulheres").\" -t halt.")))))) 
                              (first resultado))

;HOMENS
(define (chamada-homens req homens)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(homensX homens)))))

;função de chamada externa para HOMENS
(define (homensX homens) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio2.pl -g \" homens("homens"),write("homens").\" -t halt.")))))) 
                              (first resultado))

;HOMENSGOSTAM
(define (chamada-homemgosta req homemgosta)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(homengostaX homemgosta)))))

;função de chamada externa para HOMENSGOSTAM
(define (homengostaX homemgosta) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio2.pl -g \" homensgostam("homemgosta"),write("homemgosta").\" -t halt.")))))) 
                              (first resultado))

;CASSIAGOSTA
(define (chamada-cassia req cassiagosta)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(cassiagostaX cassiagosta)))))

;função de chamada externa para CASSIAGOSTA
(define (cassiagostaX cassiagosta) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio2.pl -g \" gosta(cassia,"cassiagosta"),write("cassiagosta").\" -t halt.")))))) 
                              (first resultado))


;HOMEM FELIZ
(define (chamada-homemfeliz req hfeliz)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(homemfeliz hfeliz)))))

;função de chamada externa para HOMEM FELIZ
(define (homemfeliz hfeliz) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio2.pl -g \" homemfeliz("hfeliz"),write("hfeliz").\" -t halt.")))))) 
                              (first resultado))

;NOTAS
(define (chamada-nota req nota)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(notaX nota)))))

;função de chamada externa para NOTAS
(define (notaX nota) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio4.pl -g \" nota("nota",X),write(X).\" -t halt.")))))) 
                              (first resultado))

;APROVADOS
(define (chamada-aprovados req aprovados)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(aprovadosX aprovados)))))

;função de chamada externa para APROVADOS
(define (aprovadosX aprovados) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio4.pl -g \" aprovados("aprovados"),write("aprovados").\" -t halt.")))))) 
                              (first resultado))

;REPROVADOS
(define (chamada-reprovados req reprovados)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(reprovadosX reprovados)))))

;função de chamada externa para REPROVADOS
(define (reprovadosX reprovados) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio4.pl -g \" reprovados("reprovados"),write("reprovados").\" -t halt.")))))) 
                              (first resultado))

;RECUPERACAO
(define (chamada-recuperacao req recuperacao)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(recuperacaoX recuperacao)))))

;função de chamada externa para RECUPERACAO
(define (recuperacaoX recuperacao) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio4.pl -g \" recuperacao("recuperacao"),write("recuperacao").\" -t halt.")))))) 
                              (first resultado))

;FILMES CLASSICOS
(define (chamada-classico req classico)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(classicoX classico)))))

;função de chamada externa para FILMES CLASSICOS
(define (classicoX classico) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio5.pl -g \" classico("classico"),write("classico").\" -t halt.")))))) 
                              (first resultado))

;FILMES CLASSICOS SUSPENSE
(define (chamada-classicosuspense req classicosuspense)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(classicosuspenseX classicosuspense)))))

;função de chamada externa para FILMES CLASSICOS SUSPENSE
(define (classicosuspenseX classicosuspense) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio5.pl -g \" classicosuspense("classicosuspense"),write("classicosuspense").\" -t halt.")))))) 
                              (first resultado))

;FILMES SUSPENSE
(define (chamada-suspense req suspense)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(suspenseX suspense)))))

;função de chamada externa para FILMES SUSPENSE
(define (suspenseX suspense) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio5.pl -g \" suspense("suspense"),write("suspense").\" -t halt.")))))) 
                              (first resultado))

;FILMES MENOR QUE 100 MINUTOS
(define (chamada-menor req menor)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(menorX menor)))))

;função de chamada externa para FILMES MENOR QUE 100 MINUTOS
(define (menorX menor) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio5.pl -g \" duracaomenor100("menor"),write("menor").\" -t halt.")))))) 
                              (first resultado))

;FILMES LANÇAMENTO ENTRE
(define (chamada-lancamentoentre req lancamentoentre)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(lancamentoentreX lancamentoentre)))))

;função de chamada externa para FILMES LANÇAMENTO ENTRE
(define (lancamentoentreX lancamentoentre) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio5.pl -g \" lancamentoentre("lancamentoentre"),write("lancamentoentre").\" -t halt.")))))) 
                              (first resultado))

;FILMES DIRETOR
(define (chamada-diretor req diretor)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(diretorX diretor)))))

;função de chamada externa para FILMES DIRETOR
(define (diretorX diretor) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio5.pl -g \" dirigiu(X,"diretor"),write(X).\" -t halt.")))))) 
                              (first resultado))

;FILMES LANCAMENTO
(define (chamada-lancamento req lancamento)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(lancamentoX lancamento)))))

;função de chamada externa para FILMES LANCAMENTO
(define (lancamentoX lancamento) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio5.pl -g \" lancamento(X,"lancamento"),write(X).\" -t halt.")))))) 
                              (first resultado))

;FILMES GENERO
(define (chamada-genero req genero)(response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "A busca foi realizada"))
                                            (p, "Resultado: ",(generoX genero)))))

;função de chamada externa para FILMES GENERO
(define (generoX genero) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "swipl -s /home/jfilhogn/Documentos/LP/trabalhoProlog/pratica/exercicio5.pl -g \" genero(X,"genero"),write(X).\" -t halt.")))))) 
                              (first resultado))


(serve/servlet servidor
               #:port 8080
               #:servlet-regexp #rx".*"
               #:servlet-path "/")
