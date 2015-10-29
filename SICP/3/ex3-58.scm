(load "./3.scm")

(define (expand num den radix)
  (cons-stream
   (quotient (* num radix) den)
   (expand (remainder (* num radix) den) den radix)))

; radix 進数で num を den で割った結果のストリーム
; 2番目の要素から少数点以下の値。

; (expand 1 7 10)は
; ルート2

; (expand 3 8 10)は
; 3 7 5 0 0 ...
