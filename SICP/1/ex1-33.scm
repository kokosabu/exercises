(define (square x) (* x x))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

;---------------------------------------

; 再帰
(define (filtered-accumulate filter? combiner null-value term a next b)
  (cond ((> a b)     null-value)
        ((filter? a) (combiner (term a)
                     (filtered-accumulate filter? combiner null-value
                     term (next a) next b)))
        (else        (filtered-accumulate filter? combiner null-value
                     term (next a) next b))))

(define (filtered-accumulate filter? combiner null-value term a next b)
  (define (iter x result)
    (cond ((> x b)      result)
          ((filter? x) (iter (next x) (combiner result (term x))))
          (else        (iter (next x) (combiner result)))))
  (iter a null-value))

; a
(define (add-square-prime a b)
  (define (next x) (+ x 1))
  (filtered-accumulate prime? + 0 square a next b))

; b
(define (factorial2 n)
  (define (gcd-test x) (= 1 (gcd x n)))
  (define (term x) x)
  (define (next x) (+ x 1))
  (filtered-accumulate gcd-test * 1 term 1 next n))
