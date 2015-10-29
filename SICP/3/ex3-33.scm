(load "./3.scm")

(define (averager a b c)
  (let ((u (make-connector))
	(v (make-connector)))
    (multiplier c v u)
    (adder a b u)
    (constant 2 v)
    'ok))

(define a (make-connector))
(define b (make-connector))
(define c (make-connector))
(averager a b c)

(probe "data1" a)
(probe "data2" b)
(probe "average" c)