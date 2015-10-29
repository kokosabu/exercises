(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((and? exp) (eval-and exp env)) ; added
        ((or? exp) (eval-or exp env)) ; added
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type -- EVAL" exp))))

;;; and
;;;
;;; (and (>= x 0) (<= x 255))
;;; ->
;;; (if (>= x 0)
;;;     (if (<= x 255)
;;;         true
;;;         false
;;;     false
;;;
;;; (and)
;;; ->
;;; true
(define (and? exp)
  (tagged-list? exp 'and))

(define (and-eval exp env)
  (expand-and (cdr exp)))

(define (expand-and exps))
  (if (null? exps)
      'true
      (let ((first (car exps))
            (rest (cdr exps)))
        (make-if first
                 (expand-and rest)
                 'false))))

;;; or
;;;
;;; (or (> x 0) (> y 0))
;;; ->
;;; (if (> x 0)
;;;     true
;;;     (if (> y 0)
;;;         true
;;;         false))
;;;
;;; (or)
;;; ->
;;; false
(define (or? exp)
  (tagged-list? exp 'or))

(define (or-eval exp env)
  (expand-or (cdr exp)))

(define (expand-or exps)
  (if (null? exps)
      'false
      (let ((first (car exps))
            (rest (cdr exps)))
        (make-if first
                 'true
                 (expand-or rest)))))
