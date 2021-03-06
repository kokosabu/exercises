(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))

(define (filter predicate sequence)
  (cond ((null? sequence) '())
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))


(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))


#|
(define (adjoin-position new-row k rest-of-queens)
  (cons new-row rest-of-queens))

(define empty-board '())

(define (safe? k positions)
  (define (iter k left-upper left left-lower rest)
    (if (= k 0)
        #t
        (let ((target (car rest)))
          (if (or (= target left-upper)
                  (= target left)
                  (= target left-lower))
              #f
              (iter (- k 1) (- left-upper 1) left (+ left-lower 1)
                    (cdr rest))))))
  (let ((new (car positions))
        (rest (cdr positions)))
    (iter (- k 1) (- new 1) new (+ new 1) rest)))
|#


(define (adjoin-position new-row k rest-of-queens)
  (cons (list k new-row) rest-of-queens))

(define empty-board '())

(define (safe? k positions)
  (define (iter k left-upper left left-lower rest)
    (if (= k 0)
        #t
        (let ((target (cadr (car rest))))
          (if (or (= target left-upper)
                  (= target left)
                  (= target left-lower))
              #f
              (iter (- k 1) (- left-upper 1) left (+ left-lower 1)
                    (cdr rest))))))
  (let ((new (cadr (car positions))))
    (iter (- k 1) (- new 1) new (+ new 1) (cdr positions))))
