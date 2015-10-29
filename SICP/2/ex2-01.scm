(load "./2.scm")

(define (make-rat n d)
  (let ((g (gcd (abs n) (abs d))))
    (if (< d 0)
      (cons (/ n g -1) (/ d g -1))
      (cons (/ n g) (/ d g)))))

(define a (make-rat  2  3))
(define b (make-rat -2  3))
(define c (make-rat -2 -3))
(define d (make-rat  2 -3))
