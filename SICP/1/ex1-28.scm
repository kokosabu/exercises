(define (square x) (* x x))

(define (expmod base exp m)
  (define (check-nontrival-sqrt-1 n1)
    (define (check-if-1 n2)
      (if (and (= n2 1)
               (not (or (= n1 1) (= n1 (- m 1)))))
          0
          n2))
    (check-if-1 (remainder (square n1) m)))
  (cond ((= exp 0) 1)
        ((even? exp)
         (check-nontrival-sqrt-1 (expmod base (/ exp 2) m)))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (miller-test n)
  (define (try-it a)
    (= (expmod a (- n 1) n) 0))
  (use srfi-27)
  (try-it (+ 1 (random-integer (- n 1)))))
