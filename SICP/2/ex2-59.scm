(load "./2.scm")

(define (union-set set1 set2)
  (cond ((and (null? set1) (null? set2)) '())
		((null? set1) set2)
        ((element-of-set? (car set1) set2)
		 (union-set (cdr set1) set2))
		(else
		 (cons (car set1)
			   (union-set (cdr set1) set2)))))

(define a '())
(define b '(1 2 a b))
(define c '(1 3 b c))
