(load "./1.scm")

(define (inc x) (+ x 1))

(define (compose f g)
  (lambda (x) (f (g x))))
