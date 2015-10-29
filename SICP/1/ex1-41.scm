(load "./1.scm")

(define (inc x) (+ x 1))

(define (double f)
  (lambda (x) (f (f x))))
