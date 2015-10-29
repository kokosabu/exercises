(define x 10)
(define s (make-serializer))
(parallel-execute (lambda () (set! x ((s (lambda () (* x x))))))
		  (s (lambda () (set! x (+ x 1)))))

; 101: P_1がxを100に設定し、次にP_2がxを101に増加する
; 121: P_2がxを11に設定し、次にP_1がxをx*xに設定する
; 100: P_1がxにアクセスし100を求め、P_2がxを11に設定し、P_1がxを100に設定する