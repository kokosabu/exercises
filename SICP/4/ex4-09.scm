(load "./4.scm")

;; (for (変数 初期値 終了判定式 更新方法)
;;      式
;;      式
;;      ...)
;; ->
;; ((lambda ()
;;    (define (for 変数) ; doは多分衝突しない手続き名
;;      (if (終了判定式)
;;          式
;;          式
;;          ...
;;          (for 更新方法)
;;    (for 初期値)))

;; (for (i 0 (< i 10) (+ i 1))
;;     (display i))
;; (for->combination '(for (i 0 (< i 10) (+ i 1)) (display i)))
;; ((lambda () (define (for i) (if (< i 10) (begin (display i) (for (+ i 1))))) (for 0)))
;; ((lambda () (define (for i) (if (< i 10) (begin (display i)) (for (+ i 1)))) (do 0)))
(define (for->combination exp)
  (let ((var-list (cadr exp)))
    (let ((var (car var-list))
          (initial (cadr var-list))
          (check (caddr var-list))
          (update (cadddr var-list))
          (exps (cddr exp)))
      (list (make-lambda
             '()
             (list
              (list 'define
                    (list 'for var)
                    (list 'if
                          check
                          exps
                          (list 'for update)))
              (list 'for initial)))))))

;; ((display i))
;; (cons (cons 'display (cons 'i '())) '())

;; ((display i) (display j))
;; (cons (cons 'display (cons 'i '()))
;;       (cons (cons 'display (cons 'i '()))
;;             '()))