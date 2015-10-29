(load "./stream.scm")

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))
(define integers (integers-starting-from 1))

(define (stream-append s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
		   (stream-append (stream-cdr s1) s2))))

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
		   (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t)) ; (1 1)
   (interleave
    (cons-stream
     (stream-car (stream-map (lambda (x) (list (stream-car s) x))
                             (stream-cdr t))) ; (1 2) (1 3) (1 4) ...
     (stream-map (lambda (x) (list x (stream-car s)))
                 (stream-cdr t))) ; (2 1) (3 1) (4 1) ...
    (pairs (stream-cdr s) (stream-cdr t)))))

(define int-pairs
  (pairs integers integers))