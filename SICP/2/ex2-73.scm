(define (deriv exp var)
  (cond ((number? exp) 0)
		((variable? exp) (if (same-variable? exp var) 1 0))
		(else ((get 'deriv (operator exp)) (operands exp)
										   var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))


(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (install-deriv-package)
  (define (=number? exp num)
    (and (number? exp) (= exp num)))
  (define (addend s) (car s))
  (define (augend s) (cadr s))
  (define (multiplier p) (car p))
  (define (multiplicand p) (cadr p))
  (define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
		  ((=number? a2 0) a1)
		  ((and (number? a1) (number? a2)) (+ a1 a2))
		  (else (list '+ a1 a2))))
  (define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
		  ((=number? m1 1) m2)
		  ((=number? m2 1) m1)
		  ((and (number? m1) (number? m2)) (* m1 m2))
		  (else (list '* m1 m2))))
  (define (base e) (car e))
  (define (exponent e) (cadr e))

  (define (make-exponentiation base exponent)
    (cond ((=number? exponent 0) 1)
		  ((=number? exponent 1) base)
		  (else (list '** base exponent))))

  (put 'deriv '+
  ; (put '+ 'deriv
	   (lambda (op var)
	     (make-sum (deriv (addend op) var)
		  	       (deriv (augend op) var))))
  (put 'deriv '*
  ; (put '* 'deriv
	   (lambda (op var)
	     (make-sum
	       (make-product (multiplier op)
					     (deriv (multiplicand op) var))
	       (make-product (deriv (multiplier op) var)
					     (multiplicand op)))))
  (put 'deriv '**
  ; (put '** 'deriv
	   (lambda (op var)
		 (make-product
		   (make-product (exponent exp)
						 (make-exponentiation (base exp)
											  (make-sum (exponent exp) -1)))
		   (deriv (base exp) var))))
  'done)

; higepon's code
(define deriv-table (make-hash-table))
(define (put op type item) ;; なんとopを無視するよ！
    (hash-table-put! deriv-table type item))

(define (get op type)
    (hash-table-get deriv-table type)) ;; 同じくopを無視
