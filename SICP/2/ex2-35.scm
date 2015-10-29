(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

; 2.2.2節のやつ
(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

(define (count-leaves tree)
  (accumulate (lambda (x y) (+ (if (not (pair? x))
                                   1
                                   (count-leaves x))
                               y))
              0
              tree))

(define x (cons (list 1 2) (list 3 4)))
