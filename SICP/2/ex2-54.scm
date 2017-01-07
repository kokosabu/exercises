(load "./2.scm")

(define (equal? a b)
  (cond ((and (not (pair? a)) (not (pair? b))
		      (eq? a b))
		 #t)
		((and (pair? a) (pair? b)
			  (equal? (car a) (car b))
			  (equal? (cdr a) (cdr b)))
		 #t)
		(else #f)))