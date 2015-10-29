(define (square x) (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))


(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (use srfi-27)
  (try-it (+ 1 (random-integer (- n 1)))))


(define (check n)
  (check-iter n (- n 1)))

(define (try-it n a)
  (= (expmod a n n) a))

(define (check-iter n a)
  (cond ((= a 0) #t)
        ((try-it n a) (check-iter n (- a 1)))
        (else #f)))
