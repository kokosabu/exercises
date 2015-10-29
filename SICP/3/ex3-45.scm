(load "./3.scm")

(define (make-account-and-serializer balance)
  (define (withdraw amount)
    (if (>= balance amount)
	(begin (set! balance (- balance amount))
	       balance)
	"Insufficient funcs"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((balance-serializer (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) (balance-serializer withdraw))
	    ((eq? m 'deposit) (balance-serializer deposit))
	    ((eq? m 'balance) balance)
	    ((eq? m 'serializer) balance-serializer)
	    (else (error "Unknown request -- MAKE-ACCOUNT"
			 m))))
    dispatch))

(define (deposit account amount)
  ((account 'deposit) amount))

; exchangeの途中で以下のような形になる。
;  (serializer1 (serializer2 (serializer1 (withdraw amount))))
; 直列化したものをさらに直列化する事になる。
; デッドロックにより止る。
