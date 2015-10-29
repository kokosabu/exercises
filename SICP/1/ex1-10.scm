(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))


(define (f n) (A 0 n))
; 2n
(define (g n) (A 1 n))
; 2^n
; g(n) = A 1 n
; g(n) = 2^n
; (i)
;        n = 1
;     g(1) = A 1 1
;          = 2
; (ii)
; n=kのときO.K.だとする
; (n=k+1でもO.K.であることを示す)
; g(k+1) = A 1 (k + 1)
; A 0 (A 1 k)
; A 0 (g(k))
; A 0 2^k
; 2 * 2^k
; 2^k+1
(define (h n) (A 2 n))
; 2^h n
; 2↑↑n
; クヌースのタワー記法
(define (k n) (* 5 n n))
; 5*2n

; (A 1 10)
; -> 1024

; (A 2 4)
; -> 65536

; (A 3 3)
; -> 65536
