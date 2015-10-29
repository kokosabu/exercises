(define (cube x) (* x x x))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (simpson f a b n)
  (define h (/ (- b a) n))
  (define (next i) (+ i 1))
  (define (term i)
    (+      (f (+ a (* (- (* 2 i) 2) h)))
       (* 4 (f (+ a (* (- (* 2 i) 1) h))))
            (f (+ a (* (* 2 i)       h)))))
  (/ (* h (sum term 1 next (/ n 2))) 3))
