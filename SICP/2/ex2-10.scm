(load "./ex2-09.scm")

(define R4 (make-interval -1 1))
(define R5 (make-interval -1 0))
(define R6 (make-interval 0 1))

(define RA (make-interval 1 3))
(define RB (make-interval -1 3))
(define RC (make-interval 0.01 2.01))

(define (div-interval x y)
  (if (and (<= (lower-bound y) 0)
           (<= 0 (upper-bound y)))
      (error "error")
      (mul-interval x
                    (make-interval (/ 1.0 (upper-bound y))
                                   (/ 1.0 (lower-bound y))))))
