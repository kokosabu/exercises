(define (square x) (* x x))

(define (sqrt-iter old-guess guess x)
  (if (good-enough? old-guess guess)
      guess
      (sqrt-iter guess
                 (improve guess x)
                 x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? old-guess guess)
  (< (abs (- 1.0 (/ old-guess guess))) 0.001))

(define (sqrt x)
  (sqrt-iter 1.0 x x))
