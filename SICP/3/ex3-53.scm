(define s (cons-stream 1 (add-stream s s)))

; 2のべき乗のストリーム
; 1 2 4 8 16 32 64 128 ...
