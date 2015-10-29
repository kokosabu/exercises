(load "./ex2-40.scm")

(define (unique-triples n)
  (flatmap (lambda (i) (map (lambda (j) (cons i j))
                       (unique-pairs (- i 1))))
           (enumerate-interval 1 n)))

(define (all-search n x)
  (filter (lambda (y) (= (+ (car y) (cadr y) (caddr y))
                         x))
          (unique-triples n)))
