(load "./stream.scm")

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))
(define integers (integers-starting-from 1))


(define (merge-weighted s1 s2 weight)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (let ((s1weight (weight (car s1car) (cadr s1car)))
                 (s2weight (weight (car s2car) (cadr s2car))))
             (cond ((<= s1weight s2weight)
                    (cons-stream s1car (merge-weighted (stream-cdr s1) s2 weight)))
                   ((> s1weight s2weight)
                    (cons-stream s2car (merge-weighted s1 (stream-cdr s2) weight)))))))))
;                    (cons-stream s2car (merge-weighted s1 (stream-cdr s2) weight)
;                   (else
;                    (cons-stream s1car
;                                 (merge-weighted (stream-cdr s1)
;                                                 (stream-cdr s2)
;                                                 weight)))))))

(define (weighted-pairs s t weight)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (merge-weighted
    (stream-map (lambda (x) (list (stream-car s) x))
                (stream-cdr t))
    (weighted-pairs (stream-cdr s) (stream-cdr t) weight)
    weight)))


; a.
(define (add-weight i j)
  (+ i j))

(define add-weight-stream
  (weighted-pairs integers integers add-weight))

; b.
(define (integers-2-3-5 x)
  (not (or (= 0 (remainder x 2))
           (= 0 (remainder x 3))
           (= 0 (remainder x 5)))))

(define (add-weight2 i j)
  (+ (* 2 i) (* 3 j) (* 5 i j)))

(define add-weight2-stream
  (weighted-pairs (stream-filter integers-2-3-5 integers)
                  (stream-filter integers-2-3-5 integers)
                  add-weight2))