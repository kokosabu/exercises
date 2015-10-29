(load "./2.scm")

(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+)))
(define (addend s) (car s))
(define (augend s) (caddr s))
;  (if (null? (cddr s))
;	  (caddr s)
;	  (cons 

(define (product? x)
  (and (pair? x) (eq? (cadr x) '*)))
(define (multiplier p) (car p))
(define (multiplicand p) (caddr p))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
		((=number? a2 0) a1)
		((and (number? a1) (number? a2)) (+ a1 a2))
		(else (list a1 '+ a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
		((=number? m1 1) m2)
		((=number? m2 1) m1)
		((and (number? m1) (number? m2)) (* m1 m2))
		(else (list m1 '* m2))))


; (x), ((x)),... -> x
(define (strip x)
  (define (simple-term? x)
    (and (pair? x) (null? (cdr x))))
  (if (simple-term? x) (strip (car x)) x))

(define (sum? x)
  (if (not (pair? x)) ;リストではないなら false
      #f
      (memq '+ x))) ; リストなら、+ が含まれていれば true
(define (addend x) (strip (before-item '+ x)))
(define (augend x) (strip (cdr (memq '+ x))))
(define (before-item item x)
  (define (iter rest result)
    (cond ((null? rest) x)
	      ((eq? (car rest) item) (reverse result))
	      (else (iter (cdr rest) (cons (car rest) result)))))
  (iter x '()))
(define (product? x)
  (if (not (pair? x)) ;リストではないなら false
      #f
      (not (memq '+ x)))) ; リストなら、+ が含まれていれば false
(define (multiplier x) (car x))
(define (multiplicand x) (strip (cddr x)))
