(load "./2.scm")

(define (adjoin-set x set)
  (if (null? set)
	  (list x)
   	  (let ((element (car set)))
		(cond ((= x element) set)
		      ((< x element) (cons x set))
		      (else (cons element (adjoin-set x (cdr set))))))))

(define a '())
(define b '(1 3 5))
