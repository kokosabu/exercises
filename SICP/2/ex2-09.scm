(load "./ex2-08.scm")

(define (width z)
  (/ (+ (lower-bound z) (upper-bound z)) 2))

(define R3 (make-interval -3 -1))
