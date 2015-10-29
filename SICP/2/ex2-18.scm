(define (reverse l)
  (define (reverse-iter l r)
    (if (null? l)
        r
        (reverse-iter (cdr l)
                      (append (list (car l)) r))))
  (reverse-iter l '())) 
