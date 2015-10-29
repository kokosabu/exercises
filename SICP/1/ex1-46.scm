(load "./1.scm")

(define (iterative-improve guess)
  (define (iter enough? improve guess)
    (if (enough? guess)
        guess
        (iter enough? improve (improve guess))))
  (lambda (enough? improve) (iter enough? improve guess)))

(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  ((iterative-improve x) good-enough? improve))

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? guess)
    (< (abs (- guess (next guess))) tolerance))
  (define (next guess) (f guess))
  ((iterative-improve first-guess) close-enough? next))
