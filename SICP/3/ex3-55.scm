(load "./3.scm")

(define (partial-sums s)
  (define new-s (cons-stream (stream-car s)
                             (add-streams new-s (stream-cdr s))))
  new-s)
