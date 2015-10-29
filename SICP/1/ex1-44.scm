(load "./1.scm")

(define (compose f g)
  (lambda (x) (f (g x))))

;(define (repeated proc n)
;  (if (= n 1)
;      proc
;      (compose proc (repeated proc (- n 1)))))

(define (repeated proc n)
  (define (iter i result)
    (if (= i n)
        result
        (iter (+ 1 i) (compose proc result))))
  (iter 1 proc))

(define (smooth f)
  (let ((dx 0.001))
    (lambda (x) (/ (+ (f (- x dx))
                      (f x)
                      (f (+ x dx)))
                 3))))

(define (n-fold-smoothed f n)
  ((repeated smooth n) f))
