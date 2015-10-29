(load "./ex3-60.scm")

(define (invert-unit-series s)
  (define x (cons-stream 1
			 (mul-stream (stream-map - (stream-cdr s))
				     x)))
  x)