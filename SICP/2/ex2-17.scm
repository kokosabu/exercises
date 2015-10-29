(load "./2.scm")

(define (last-pair l)
  (list (list-ref l (- (length l) 1))))
