(define x (list (list 1 2) (list 3 4)))

(define (fringe l)
  (cond ((null? l) l)
        ((pair? (car l))
         (append (fringe (car l)) (fringe (cdr l))))
        (else
         (cons (car l) (fringe (cdr l))))))

; 反復失敗版
;(define (fringe l)
;  (define (fringe-iter r l)
;    (cond ((null? l) r)
;          ((pair? (car l))
;           (fringe-iter (append r (fringe (car l))) (cdr l)))
;          (else
;           (fringe-iter (cons r (list (car l))) (cdr l)))))
;  (fringe-iter '() l))
