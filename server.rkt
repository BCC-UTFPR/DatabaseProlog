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
     [("fibonacci" (integer-arg)) chamada-fibonacci] ;certo
     [("fatorial" (integer-arg)) chamada-fatorial]    ;certo
     [("ordena" (string-arg)) chamada-ordena]         ;certo
     [("inverte"(string-arg)) chamada-inverte]        ;certo
     [("membro" (integer-arg) (string-arg)) chamada-membro] ;certo 
     [("uniao" (string-arg) (string-arg)) chamada-uniao] ;certo
     [("inter" (string-arg) (string-arg)) chamada-intersecao];certo 
     [else main]))

#|cada URL diferente deve-se criar um formato de HTML para que apareça na página.
Esta primeira é main que sempre irá ser executado na primeira vez, pode se dizer que é a URL raiz |#
(define (main req) (response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "Para utilizar o servidor utilize a url http://localhost:8080/funcao/parametros"))                                
                                      (body (b, "As funções que tem são:"))
                                      (body (p, "fatorial"))
                                      (body (p, "fibonacci"))
                                      (body (p, "inverte"))
                                      (body (p, "ordena"))
                                      (body (p, "membro"))
                                      (body (p, "uniao"))
                                      (body (p, "interseccao"))
                                      (body (b, "Para funções com lista utiliza virgula para separar os paramêtros 8,7,6")))))
                                      
; Por conseguinte é criado os outros formatos para as URLs respectivas
(define (chamada-fibonacci req fib) (response/xexpr `(html (head (title "Trabalho de LP"))
                                            (body (p, "Execução da função fibonacci com o(s) parâmetro(s) ", (number->string fib) ".")
                                            (p, "Resultado: ", (number->string (fibonacci fib)))))))
;Função para chamada externa para fibonacci
(define (fibonacci fib) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "racket ~/Documentos/LP/LPserver/apps/fibonacci.rkt " (number->string fib))))) "\n")) 
                              (string->number (first resultado)))


;FATORIAL
(define (chamada-fatorial req fat) (response/xexpr `(html (head (title "Trabalho de LP"))
                                      (body (p, "Execução da função fatorial com o(s) parâmetro(s) ", (number->string fat) ".")
                                            (p, "Resultado: ",(number->string(fatorial fat)))))))

;função de chamada externa para fatorial
(define (fatorial fat) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "racket ~/Documentos/LP/LPserver/apps/fatorial.rkt " (number->string fat))))) "\n")) 
                              (string->number (first resultado)))



;INVERTE
(define (chamada-inverte req inv) (response/xexpr `(html (head (title "Trabalho de LP"))
                                        (body (p, "Execução da função inverte com o(s) parâmetro(s) ", inv ".")
                                              (p, "Resultado: ", (inverte inv))))))

;função de chamada externa INVERTE
(define (inverte inv) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "racket ~/Documentos/LP/LPserver/apps/inverte.rkt "inv)))) "\n"))
                              (first resultado))

;ORDENA
(define (chamada-ordena req ord) (response/xexpr `(html (head (title "Trabalho de LP"))
                                       (body (p, "Execução da função ordena com o(s) parâmetro(s) ", ord ".")
                                             (p, "Resultado: ", (ordena ord))))))

;função de chamada externa da ordenação
(define (ordena ord) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "racket ~/Documentos/LP/LPserver/apps/ordena.rkt "ord)))) "\n"))
                              (first resultado))

;MEMBRO
(define (chamada-membro req memb lista) (response/xexpr `(html (head (title "Trabalho de LP"))
                                       (body (p, "Execução da função membro com o(s) parâmetro(s) ", (number->string memb)  " possui na lista ", lista ".")
                                             (p, "Resultado: ",(membro memb lista ))))))

;função para chamada de membro
(define (membro memb lista) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "racket ~/Documentos/LP/LPserver/apps/membro.rkt "(number->string memb)" "lista)))) "\n"))
                              (first resultado))

;UNIÃO
(define (chamada-uniao req lista1 lista2) (response/xexpr `(html (head (title "Trabalho de LP"))
                                           (body (p, "Execução da função união com o(s) parâmetro(s) ", lista1 " e ", lista2 ".")
                                                 (p, "Resultado: ", (uniao lista1 lista2))))))

;função chamada união
(define (uniao list1 list2) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "racket ~/Documentos/LP/LPserver/apps/uniao.rkt "list1" "list2)))) "\n"))
                              (first resultado))


;INTERSECÇÃO
(define (chamada-intersecao req listau listad) (response/xexpr `(html (head (title "Trabalho de LP"))
                                           (body (p, "Execução da função união com o(s) parâmetro(s) ", listau " e ", listad ".")
                                                 (p, "Resultado: ", (inter listau listad))))))

;função chamada intersecção
(define (inter listu1 listd2) (define resultado 
                            (string-split 
                             (with-output-to-string 
                              (lambda() (system (string-append "racket ~/Documentos/LP/LPserver/apps/inter.rkt "listu1" "listd2)))) "\n"))
                              (first resultado))

(serve/servlet servidor
               #:port 8080
               #:servlet-regexp #rx".*"
               #:servlet-path "/")
