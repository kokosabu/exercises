(load "./2.scm")

(define (make-interval a b) (cons a b))
(define (lower-bound z) (car z))
(define (upper-bound z) (cdr z))

(define R1 (make-interval 6.12 7.48))
(define R2 (make-interval 4.465 4.935))
