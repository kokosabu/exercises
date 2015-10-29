(load "./ex2-38.scm")

(define (reverse sequence)
  (fold-right (lambda (x y) (append y (cons x '()))) '() sequence))

(define (reverse sequence)
  (fold-left (lambda (x y) (cons y x)) '() sequence))
