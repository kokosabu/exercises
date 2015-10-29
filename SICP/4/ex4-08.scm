(load "./ex4-06.scm")

;; gosh> (let->combination '(let ((a 10) (b 20)) (display a)))
;; ((lambda (a b) display a) 10 20)
;; gosh> (let->combination '(let fib-iter ((a 1) (b 0) (count n)) (if (= count 0) b (fib-iter (+ a b) a (- count 1)))))
;; ((lambda () (define (fib-iter a b count) (if (= count 0) b (fib-iter (+ a b) a (- count 1)))) (fib-iter 1 0 n)))
(define (let->combination exp)
  (if (symbol? (cadr exp))
      ;; 名前つきlet
      (let ((var (cadr exp))
            (bindings (caddr exp))
            (body (cadddr exp)))
        (list (make-lambda
               '()
               (list
                (list 'define
                      (cons var (let-var-list bindings))
                      body)
                (cons var (let-exp-list bindings))))))
      ;; 通常のlet
      (let ((parameters (cadr exp))
            (body (caddr exp)))
        (cons
         (make-lambda (let-var-list parameters)
                      body)
         (let-exp-list parameters)))))
