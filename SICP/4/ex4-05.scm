(define (cond? exp) (tagged-list? exp 'cond))

(define (cond-clauses exp) (cdr exp))

(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))

(define (cond-predicate clause) (car clause))

(define (cond-actions clause) (cdr clause))

(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))



;;; added
(define (cond-test clause) (car clause))

(define (cond-recipient clause) (cdr (cond-actions clause)))

(define (cond-arrow-clause? clause)
  (eq? (car (cond-actions clause)) '=>))

;; (<test> => <recipient>)
;; ->
;; (lambda (t)
;;   (if t
;;       (recipient t)
;;       alternative)
;;   test)
(define (make-arrow test recipient alternative)
  (list
   (make-lambda (list 't)
                (list
                 (make-if (list 't)
                          (list recipient 't)
                          alternative)))
   test))

(define (expand-clauses clauses)
  (if (null? clauses)
      'false ; else節なし
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "ELSE clause isn't last -- COND->IF"
                       clauses))
            (if (cond-arrow-clause? first)
                (make-arrow (cond-predicate first)
                            (sequence->exp (cond-recipient first))
                            (expand-clauses rest))
                (make-if (cond-predicate first)
                         (sequence->exp (cond-actions first))
                         (expand-clauses rest)))))))