(load "./ex2-13.scm")

(define (i-print i)
  (display (center i))
  (display "\n")
  (display (percent i))
  0 ;dummy
  )

(define xs (make-center-percent 3 1))
(define xm (make-center-percent 3 10))
(define xl (make-center-percent 3 50))
