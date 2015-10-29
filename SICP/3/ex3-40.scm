(define x 10)
(parallel-execute (lambda () (set! x (* x x)))
		  (lambda () (set! x (* x x x))))

; x を   x*x に設定するP1
; x を x*x*x に設定するP2
;
; 1000000: P1がxを100に設定し、次にP2がx*x*xに設定する。
;          もしくは、P2がxを1000に設定し、次にP1がx*xに設定する。
; 10000: P1がxに一回アクセスし、P2がxを1000に設定し、P1がxにアクセスしxを設定する
; 100: P1がxに二回アクセスし、P2がxを1000に設定し、P1がxを設定する
; 100000: P2がxに一回アクセスし、P1がxを100に設定し、P2がxに二回アクセスしxを設定する
; 10000: P2がxに二回アクセスし、P1がxを100に設定し、P2がxにアクセスしxを設定する
; 1000: P2がxに三回アクセスし、P1がxを100に設定し、P2がxを設定する

(define x 10)
(define x (make-serializer))
(parallel-execute (s (lambda () (set! x (* x x))))
		  (s (lambda () (set! x (* x x x)))))

; 1000000のみ残る