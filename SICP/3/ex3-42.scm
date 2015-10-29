(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
	(begin (set! balance (- balance amount))
	       balance)
	"Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((protected (make-serializer)))
    (let ((protected-withdraw (protected withdraw))
	  (protected-deposit (protected deposit)))
      (define (dispatch m)
	(cond ((eq? m 'withdraw) protected-withdraw)
	      ((eq? m 'deposit) protected-deposit)
	      ((eq? m 'balance) balance)
	      (else (error "Unknown request -- MAKE-ACCOUNT"
			   m))))
    dispatch)))

; (let ((<var> <exp>)) <body>)は
; ((lambda (<var>) <body>) <exp>)。
; 書換えてみる。あんまり意味なかった。
((lambda (protected)
   ((lambda (protected-withdraw protected-deposit)
      (define (dispatch m)
	(cond ((eq? m 'withdraw) protected-withdraw)
	      ((eq? m 'deposit) protected-deposit)
	      ((eq? m 'balance) balance)
	      (else (error "Unknown request -- MAKE-ACCOUNT"
			   m))))
      dispatch) ((protected withdraw) (protected deposit)))
   (make-serializer)))

; 安全な変更。
; 並列性に違いはでない。