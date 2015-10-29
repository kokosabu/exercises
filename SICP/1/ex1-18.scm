(define (even? n)
  (= (remainder n 2) 0))
(define (double n) (* n 2))
(define (halve n) (/ n 2))

(define (* a b) (multi a b 0))

(define (multi a b c)
  (cond ((= b 0)   c)
        ((even? b) (multi (double a) (halve b) c))
        (else      (multi a          (- b 1)   (+ a c)))))
