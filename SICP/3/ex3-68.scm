(load "./stream.scm")

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))
(define integers (integers-starting-from 1))

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
		   (interleave s2 (stream-cdr s1)))))

;original
;(define (pairs s t)
;  (cons-stream
;   (list (stream-car s) (stream-car t))
;   (interleave
;    (stream-map (lambda (x) (list (stream-car s) x))
;		(stream-cdr t))
;    (pairs (stream-cdr s) (stream-cdr t)))))

(define (pairs s t)
  (interleave
   (stream-map (lambda (x) (list (stream-car s) x))
	       t)
   (pairs (stream-cdr s) (stream-cdr t))))

(define int-pairs
  (pairs integers integers))

; interleave 手続きが二つのストリームを交互に取り続ける。
; そのため (pairs integers integers) を評価すると無限ループに入ってしまう。