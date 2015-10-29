(load "./3.scm")

; 同時に
; a1を保護するためにa2の保護が、
; a2を保護するためにa1の保護が
; 必要という状態であるためデッドロックに陥る。
; そこを小さい数字を優先しようとすれば、
; 仮にa1の方が小さいとすればa1を先に保護しようとするので
; デッドロックにはならない。

(define (create-make-account)
  (let ((n 0))
    (define (make-account-and-serializer balance)
      (set! n (+ n 1))
      (let ((id n))
        (define (withdraw amount)
          (if (>= balance amount)
	      (begin (set! balance (- balance amount))
		     balance)
	      "Insufficient funds"))
        (define (deposit amount)
          (set! balance (+ balance amount))
          balance)
        (let ((balance-serializer (make-serializer)))
          (define (dispatch m)
            (cond ((eq? m 'withdraw) withdraw)
		  ((eq? m 'deposit) deposit)
		  ((eq? m 'balance) balance)
		  ((eq? m 'serializer) balance-serializer)
		  ((eq? m 'number) id)
		  (else (error "Unknown request -- MAKE-ACCOUNT"
			       m))))
          dispatch)))
    make-account-and-serializer))
(define make-account (create-make-account))

(define (deposit account amount)
  (let ((s (account 'serializer))
	(d (account 'deposit)))
    ((s d) amount)))

(define (serialized-exchange account1 account2)
  (let ((serializer1 (account1 'serializer))
    	(serializer2 (account2 'serializer))
        (number1     (account1 'number))
        (number2     (account2 'number)))
    (if (> number1 number2)
        ((serializer1 (serializer2 exchange))
         account1
         account2)
        ((serializer2 (serializer1 exchange))
         account2
         account1))))

(define account1 (make-account 100))
(define account2 (make-account 100))