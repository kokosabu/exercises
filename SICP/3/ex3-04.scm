(define (make-account balance password)
  (let ((count 0))
    (define (withdraw amount)
      (if (>= balance amount)
	  (begin (set! balance (- balance amount))
		 balance)
	  "Insufficient funds"))
    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)
    (define (call-the-cops arg) "Call The Cops")
    (define (error-message arg) "Incorrect password")
    (define (dispatch p m)
      (if (eq? p password)
	  (begin (set! count 0)
		 (cond ((eq? m 'withdraw) withdraw)
		       ((eq? m 'deposit) deposit)
		       (else (error "Unknown request -- MAKE-ACCOUNT"
				    m))))
	  (begin (set! count (+ count 1))
		 (if (= count 7)
		     call-the-cops
		     error-message))))
    dispatch))
