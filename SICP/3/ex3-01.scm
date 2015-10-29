(define (make-accumulator sum)
  (lambda (arg)
    (begin (set! sum (+ sum arg))
           sum)))
