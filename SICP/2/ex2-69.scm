(load "./ex2-68.scm")

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leafs)
  (define (insert new before after)
	(cond ((not (pair? after))
		   (append (append before (list new)) after))
		  ((< (weight new) (weight (car after)))
	       (append (append before (list new)) after))
		  (else
		   (insert new (append before (list (car after))) (cdr after)))))
  (let ((len (length leafs)))
    (if (= len 1)
	    (car leafs)
	    (successive-merge (insert (make-code-tree (car leafs) (cadr leafs))
								  '()
								  (if (>= len 3)
									  (cddr leafs)
									  '()))))))

(define (generate-huffman-tree-1 pairs)
  (successive-merge-1 (make-leaf-set pairs)))
(define (successive-merge-1 leaf-set)
  (if (null? (cdr leaf-set))
	  (car leaf-set)
	  (successive-merge-1 (adjoin-set (make-code-tree (car leaf-set)
		                                            (cadr leaf-set))
		                            (cddr leaf-set)))))



(define x '((A 4) (B 2) (C 1) (D 1)))
(define test '((A 8) (B 3) (C 2) (D 1)))
(define pairs '((A 8) (B 3) (C 1) (D 1) (E 1) (F 1) (G 1) (H 1)))
