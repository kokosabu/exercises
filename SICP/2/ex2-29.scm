(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

; a.
(define left-branch car)
(define right-branch (lambda (x) (car (cdr x))))
(define branch-length car)
(define branch-structure (lambda (x) (car (cdr x))))

; b.
(define (total-weight l)
  (if (pair? l)
      (+ (total-weight (branch-structure (left-branch  l)))
         (total-weight (branch-structure (right-branch l))))
      l))

; c.
(define (balanced? l)
  (define (left-size l)
    (if (balanced? (branch-structure (left-branch  l)))
        (* (branch-length (left-branch  l))
           (balanced?-sub (branch-structure (left-branch  l))))
         #f))
  (define (right-size l)
    (if (balanced? (branch-structure (right-branch l)))
        (* (branch-length (right-branch l))
           (balanced?-sub (branch-structure (right-branch l))))
        #f))
  (define (balanced?-sub l)
    (if (pair? l)
        (if (and (left-size l) (right-size l)
                 (= (left-size l) (right-size l)))
            (+ (left-size l) (right-size l))
            #f)
        l))
  (if (balanced?-sub l)
      #t
      #f))

(define x (make-mobile
            (make-branch 6 30)
            (make-branch 5 (make-mobile
                             (make-branch 3 5)
                             (make-branch 6 3)))))
(define y (make-mobile
            (make-branch 6 30)
            (make-branch 5 (make-mobile
                             (make-branch 3 6)
                             (make-branch 6 3)))))
