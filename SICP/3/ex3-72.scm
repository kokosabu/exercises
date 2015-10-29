(load "./stream.scm")

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))
(define integers (integers-starting-from 1))

(define (square-integers-starting-from n)
  (cons-stream (* n n) (square-integers-starting-from (+ n 1))))
(define square-integers (square-integers-starting-from 1))

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (stream-map (lambda (x) (list (stream-car s) x))
                (stream-cdr t))
    (pairs (stream-cdr s) (stream-cdr t)))))

(define (merge-weighted s1 s2 weight)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (let ((s1weight (weight (car s1car) (cadr s1car)))
                 (s2weight (weight (car s2car) (cadr s2car))))
             (cond ((< s1weight s2weight)
                    (cons-stream s1car (merge-weighted (stream-cdr s1) s2 weight)))
                   ((> s1weight s2weight)
                    (cons-stream s2car (merge-weighted s1 (stream-cdr s2) weight)))
                   (else
                    (cons-stream s1car (merge-weighted (stream-cdr s1)
                                                       (stream-cdr s2)
                                                       weight)))))))))

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

(define (square-weight i j)
  (+ (* i i) (* j j)))

;;; 問題3.71と同様の方法, 整列されている
(define square-weight-stream
  (weighted-pairs integers integers square-weight))
(define square-number-stream-inner-inner
  (merge-weighted square-weight-stream (stream-cdr square-weight-stream) square-weight))
(define (square-number-stream1-inner s)
  (cons-stream
   (square-weight (car (stream-car s))
                  (car (cdr (stream-car s))))
   (square-number-stream-inner (stream-cdr s))))
(define square-number-stream1
  (square-number-stream1-inner square-number-stream-inner-inner))

;;; 平方数のペアをすべて列挙し足していく。重複していないはず
(define (square-number-stream2-inner s)
  (cons-stream
   (+ (car (stream-car s))
      (cadr (stream-car s)))
   (square-number-stream2-inner (stream-cdr s))))
(define square-number-stream2
  (square-number-stream2-inner (pairs square-integers square-integers)))

;;; 整数のペアを列挙し、平方数の和のストリームをつくる
(define integers-pair
  (pairs integers integers))
(define (square-stream s)
  (cons-stream
   (square-weight (car (stream-car s))
                  (cadr (stream-car s)))
   (square-stream (stream-cdr s))))
(define square-number-stream3
  (square-stream integers-pair))