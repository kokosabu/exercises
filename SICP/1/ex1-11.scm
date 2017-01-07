;; 再帰
(define (f n)
  (cond ((< n 3) n)
        (else (+ (f (- n 1))
                 (* 2 (f (- n 2)))
                 (* 3 (f (- n 3)))))))

;; 反復
(define (f-iter n)
  (define (iter a b c count)
    (cond ((= count 0) c)
	  ((= count 1) b)
	  (else (iter (+ a (* 2 b) (* 3 c)) a b (- count 1)))))
  (iter 2 1 0 n))

; (f 5)
; ->
; (+ (f 4)
;    (* 2 (f 3))
;    (* 3 (f 2)))
; ->
; (+ (+ (f 3)
;       (* 2 (f 2))
;       (* 3 (f 1)))
;    (* 2 (+ (f 2)
;            (* 2 (f 1))
;            (* 3 (f 0))))
;    (* 3 2))
; ->
; (+ (+ (+ (f 2)
;          (* 2 (f 1))
;          (* 3 (f 0)))
;       4
;       3)
;    (* 2 (+ 2
;            2
;            0))
;    6
; ->
; (+ (+ (+ 2
;          2
;          0
;       4
;       3)
;    8
;    6)
; ->
; (+ (+ 4
;       4
;       3)
;    8
;    6)
; ->
; (+ 11
;     8
;     6)
; ->
; 25