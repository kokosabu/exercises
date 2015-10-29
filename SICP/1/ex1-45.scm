(load "./1.scm")

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated proc n)
  (define (iter i result)
    (if (= i n)
        result
        (iter (+ 1 i) (compose proc result))))
  (iter 1 proc))

(define (n-fold-smoothed f n)
  ((repeated smooth n) f))

(lambda (y) (/ x y))

(define (root n x)
  (fixed-point ((repeated average-damp (- n 2))
                (repeated (lambda (y) (/ x y)) (- n 1)))
               1.0))

(define (nth-root-test x n k)
  (fixed-point ((repeated average-damp k)
                (lambda (y) (/ x (fast-expt y (- n 1)))))
               1.0))
