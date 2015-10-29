(load "./4.scm")


(define (eval-let exp nev)
  (eval (let->combination exp) env))

(define (let? exp)
  (tagged-list? exp 'let))

;; gosh> (let->combination '(let ((a 10) (b 20)) (display a)))
;; ((lambda (a b) (display a)) (10 20))
(define (let->combination exp)
  (cons
   (make-lambda (let-var-list (let-parameters exp))
                (let-body exp))
   (let-exp-list (let-parameters exp))))

(define (let-parameters exp) (cadr exp))

(define (let-body exp) (caddr exp))

(define (let-var-list parameters)
  (if (null? parameters)
      '()
      (cons (caar parameters) (let-var-list (cdr parameters)))))

(define (let-exp-list parameters)
  (if (null? parameters)
      '()
      (cons (cadar parameters) (let-exp-list (cdr parameters)))))


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
        ((let? exp) (eval-let exp env)) ; added
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type -- EVAL" exp))))
