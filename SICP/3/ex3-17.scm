(define (count-pairs x)
  (count-pairs-iter x (cons 'dummy '())))
(define (count-pairs-iter x l)
  (if (null? (filter (lambda (y) (eq? x y)) l))
    (if (pair? x)
        (begin
          (set-cdr! (last-pair l) (cons x '()))
          (+ (count-pairs-iter (car x) l)
             (count-pairs-iter (cdr x) l)
             1))
        0)
    0))

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

(define three (cons 'a (cons 'b (cons 'c '()))))

(define four (cons 'dummy (cons 'a '())))
(set-car! four (cons 'b (cdr four)))

(define seven (cons 'a (cons 'b (cons 'c '()))))
(set-car! (cdr seven) (cdr (cdr seven)))
(set-car! seven (cdr seven))

(define no_return (make-cycle (list 'a 'b 'c)))
