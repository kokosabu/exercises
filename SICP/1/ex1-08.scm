(define (square x) (* x x))
(define (cubic x) (* x x x))

(define (cubic-root-iter old new x)
  (if (good-enough? old new)
      new
      (cubic-root-iter new 
                       (improve new x)
                       x)))

(define (improve guess x)
  (/ (+ (* 2 guess) (/ x (square guess))) 3))

(define (good-enough? old new)
  (< (abs (- 1.0 (/ old new))) 0.001))

(define (cubic-root x)
  (cubic-root-iter 1.0 x x))
