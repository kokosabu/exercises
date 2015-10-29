(load "./ex3-59.scm")

(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1) (stream-car s2))
	       (add-streams (stream-map
			     (lambda (x) (* (stream-car s1) x))
			     (stream-cdr s2))
			    (mul-series (stream-cdr s1) s2))))