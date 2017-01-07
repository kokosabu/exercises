(define (make-table = < >)
  (let ((local-table (list '*table*)))
    (define (entry tree) (car tree))
    (define (left-branch tree) (cadr tree))
    (define (right-branch tree) (caddr tree))
    (define (make-tree entry left right)
      (list entry left right))

    (define (assoc key records)
      (cond ((null? records) #f)
            ((= key (car (entry records))) (entry records))
            ((< key (car (entry records)))
             (assoc key (left-branch records)))
            ((> key (car (entry records)))
             (assoc key (right-branch records)))))
    (define (lookup key)
      (lookup-iter key local-table))
    (define (lookup-iter key local-table)
      (if (pair? key)
          (let ((subtable (assoc (car key) (cdr local-table))))
            (if subtable
                (if (null? (cdr key))
                    (cdr subtable)
                    (lookup-iter (cdr key) subtable))
                #f))
          (error "key error" key)))

    (define (insert! key value)
      (insert-iter! key value local-table))
    (define (insert-iter! key value local-table)
      (if (pair? key)
          (let ((subtable (assoc (car key) (cdr local-table))))
            (if subtable
                (if (null? (cdr key))
                    (set-cdr! subtable value)
                    (insert-iter! (cdr key) value subtable))
                (if (null? (cdr local-table))
                    (set-cdr! local-table (insert-iter key value))
                    (set-car! (search (car key) (cdr local-table))
                              (insert-iter key value)))))
          (error "key error" key)))
    (define (search key records)
      (if (< key (car (entry records)))
          (if (null? (left-branch records))
              (cdr records)
              (search key (left-branch records)))
          (if (null? (right-branch records))
              (cddr records)
              (search key (right-branch records)))))
    (define (insert-iter key value)
      (if (null? key)
          value
          (make-tree (cons (car key) (insert-iter (cdr key) value))
                     '()
                     '())))

    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define operation-table (make-table string=? string<? string>?))
(define lookup (operation-table 'lookup-proc))
(define insert! (operation-table 'insert-proc!))