(load "./ex2-11.scm")

(define (make-center-percent c p)
  (make-interval (/ (* (- 100 p) c) 100)
                 (/ (* (+ 100 p) c) 100)))

(define (percent i)
  (/ (* (- (upper-bound i) (center i)) 100) (center i)))
