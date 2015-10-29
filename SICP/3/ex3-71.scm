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

(define (weighted-pairs s t weight)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (merge-weighted
    (stream-map (lambda (x) (list (stream-car s) x))
                (stream-cdr t))
    (weighted-pairs (stream-cdr s) (stream-cdr t) weight)
    weight)))

(define (my-merge s1 s2 weight)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (let ((s1weight (weight (car s1car) (cadr s1car)))
                 (s2weight (weight (car s2car) (cadr s2car))))
             (if (= s1weight s2weight)
                 (cons-stream s1car (my-merge (stream-cdr s1) (stream-cdr s2) weight))
                 (my-merge (stream-cdr s1) (stream-cdr s2) weight)))))))

(define (cube-weight i j)
  (+ (* i i i)
     (* j j j)))

(define cube-weight-stream
  (weighted-pairs integers integers cube-weight))

(define ramanujan-stream-inner
  (my-merge cube-weight-stream (stream-cdr cube-weight-stream) cube-weight))

(define (ramanujan-stream-inner2 s)
  (cons-stream
   (cube-weight (car (stream-car s))
                (car (cdr (stream-car s))))
   (ramanujan-stream-inner2 (stream-cdr s))))


(define ramanujan-stream
  (ramanujan-stream-inner2 ramanujan-stream-inner))