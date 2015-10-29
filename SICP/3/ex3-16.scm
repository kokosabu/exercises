(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

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
