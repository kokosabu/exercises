(define a (list 1 3 (list 5 7) 9))
(define b (list (list 7)))
(define c (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))


(define (get-7a a) (car (cdr (car (cdr (cdr a))))))
(define (get-7b b) (car (car b)))
(define (get-7c c) (car (cdr
                   (car (cdr
                   (car (cdr
                   (car (cdr
                   (car (cdr
                   (car (cdr c)))))))))))))
