(define (power x y)
  (define (iter i result)
    (if (= i y)
        result
        (iter (+ i 1) (* x result))))
  (iter 0 1))

(define (cons a b)
  (* (power 2 a) (power 3 b)))

(define (iter result z x)
  (if (not (= (remainder z x) 0))
      result
      (iter (+ result 1) (/ z x) x)))

(define (car z)
  (iter 0 z 2))

(define (cdr z)
  (iter 0 z 3))
