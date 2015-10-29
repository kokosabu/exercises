(define (cont-frac n d k)
  (define (try i)
    (if (= i k)
        (d i)
        (/ (n i) (+ (d i) (try (+ i 1))))))
  (try 1))

(define (cont-frac n d k)
  (define (iter i result)
    (if (= i 0)
        result
        (iter (- i 1) (/ (n i) (+ (d i) result)))))
  (iter (- k 1) (d k)))

(define (test k)
  (cont-frac (lambda (i) 1.0)
             (lambda (i) 1.0)
             k))
