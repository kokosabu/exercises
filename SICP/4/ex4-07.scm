(load "./ex4-06.scm")


;; let*をletの入れ子に置き換え
;; (let* ((x 3)
;;        (y (+ x 2))
;;        (z (+ x y 5)))
;;   (* x z))
;; ->
;; (let ((x 3))
;;   (let ((y (+ x 2)))
;;     (let ((z (+ x y 5)))
;;       (* x z))))
;; ->
;; ((lambda (x)
;;   ((lambda (y)
;;     ((lambda (z)
;;       (* x z))
;;     (+ x y 5)))
;;   (+ x 2)))
;; 3)



;; gosh> (let*->nested-lets '(let* ((x 3) (y (+ x 2)) (z (+ x y 5))) (* x z)))
;; (let ((x 3)) (let ((y (+ x 2))) (let ((z (+ x y 5))) (* x z))))
;; gosh> (let ((x 3)) (let ((y (+ x 2))) (let ((z (+ x y 5))) (* x z))))
;; 39
(define (let*? exp)
  (tagged-list? exp 'let*))

(define (let*->nested-lets exp)
  (let*-expand (let*-parameters exp) (let*-body exp)))

(define (let*-parameters exp) (cadr exp))

(define (let*-body exp) (caddr exp))

(define (let*-expand parameters body)
  (if (null? parameters)
      body
      (cons
       'let
       (cons (list (car parameters))
             (list (let*-expand (cdr parameters) body))))))



;; ex4-06.scmのままではlet*の評価ができないので
;; let式の中でlet式を評価するように変更する
(define (eval-let exp env)
  (eval (let->combination exp env) env))

(define (let->combination exp env)
  (cons
   (make-lambda (let-var-list (let-parameters exp))
                (let-body exp env))
   (let-exp-list (let-parameters exp))))

(define (let-body exp env)
  (let ((body (caddr exp)))
    (if (let? #?=body)
        (eval (let->combination body env) env)
        body)))

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
        ((let? exp) (eval-let exp env))
        ((let*? exp) (eval (let*->netsted-lets exp) env)) ; added
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type -- EVAL" exp))))