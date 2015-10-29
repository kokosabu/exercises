(define (cycle-check x)
  (cycle-check-iter x (cons 'dummy '())))
(define (cycle-check-iter x l)
  (if (null? (filter (lambda (y) (eq? x y)) l))
      (if (pair? x)
          ; cdrにいままで出たポインタがあれば巡回
          (if (null? (filter (lambda (y) (eq? (cdr x) y)) l))
              (begin
                (set-cdr! (last-pair l) (cons x '()))
                (if (or (equal? "yes" (cycle-check-iter (car x) l))
                        (equal? "yes" (cycle-check-iter (cdr x) l)))
                    "yes"
                    "no"))
              "yes"))
      "no"))

(define (filter predicate sequence)
  (cond ((null? sequence) '())
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

; テストデータ

(define three (cons 'a (cons 'b (cons 'c '()))))

(define four (cons 'dummy (cons 'a '())))
(set-car! four (cons 'b (cdr four)))

(define seven (cons 'a (cons 'b (cons 'c '()))))
(set-car! (cdr seven) (cdr (cdr seven)))
(set-car! seven (cdr seven))

(define no_return (make-cycle (list 'a 'b 'c)))
