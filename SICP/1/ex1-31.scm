(define (product term a next b)
  (if (< b a)
      1
      (* (term a) (product term (next a) next b))))

(define (product term a next b)
  (define (iter a result)
    (if (< b a)
        result
        (iter (next a) (* (term a) result))))
  (iter a 1))

(define (factorial n)
  (define (term i) i)
  (define (next i) (+ i 1))
  (product term 1 next n))

(define (pi n)
  (define (term-a i)
    (+ 2 (* 2 (if (even? i)
                  (/ i 2)
                  (/ (+ i 1) 2)))))
  (define (term-b i)
    (+ 2 (* 2 (if (even? i)
                  (/ (+ i 1) 2)
                  (/ i 2)))))
  (define (next i) (+ i 1))
  (* 4 (/ (product term-a 0 next (- n 1))
          (product term-b 0 next (- n 1)))))
