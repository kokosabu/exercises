(load "./ex3-61.scm")

(define (div-series s1 s2)
  (mul-stream s1 (invert-unit-series s2)))

(define tangent-series
  (div-series sine-series cons-stream))