(define (car-check l x)
  (cond ((not (pair? l)) #f)
        ((null? l) #f)
        ((eq? l x) #t)
        (else (car-check (car l) x))))

(define (cdr-check l x)
  (cond ((not (pair? l)) #f)
        ((null? l) #f)
        ((eq? l x) #t)
        (else (cdr-check (cdr l) x))))

(define (cycle-list? l)
  (if (pair? l)
      (or (car-check (car l) l) (cdr-check (car l) l)
          (car-check (cdr l) l) (cdr-check (cdr l) l)
          (cycle-list? (car l)) (cycle-list? (cdr l)))
      #f))


; テストデータ用
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
