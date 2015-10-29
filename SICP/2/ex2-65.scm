(load "./ex2-63.scm")
(load "./ex2-64.scm")

(define (union-set tree1 tree2)
  (define (sub-union-set set1 set2)
    (cond ((null? set1) set2)
		  ((null? set2) set1)
		  (else
		   (let ((x1 (car set1))
			     (x2 (car set2)))
		     (cond ((= x1 x2)
				    (cons x1
						  (sub-union-set (cdr set1) (cdr set2))))
				   ((< x1 x2)
				    (cons x1
						  (sub-union-set (cdr set1) set2)))
				   ((> x1 x2)
				    (cons x2
						  (sub-union-set set1 (cdr set2)))))))))
  (list->tree (sub-union-set (tree->list-1 tree1) (tree->list-2 tree2))))

(define (intersection-set tree1 tree2)
  (define (sub-intersection-set set1 set2)
    (if (or (null? set1) (null? set2))
	    '()
	    (let ((x1 (car set1)) (x2 (car set2)))
		  (cond ((= x1 x2)
			     (cons x1
					   (sub-intersection-set (cdr set1)
									     (cdr set2))))
			    ((< x1 x2)
			     (sub-intersection-set (cdr set1) set2))
			    ((< x2 x1)
			     (sub-intersection-set set1 (cdr set2)))))))
  (list->tree (sub-intersection-set (tree->list-1 tree1) (tree->list-2 tree2))))


(define a (list->tree '(1 3 5 7)))
(define b (list->tree '(1 2 5 9)))
