(load "./2.scm")

(define (get-record name file)
  ((get 'get-record (tag file)) name))

(define (get-salary record)
  (apply-generic 'get-salary record))

(define (find-employee-record name lists)
  (map (lambda (file) (get-record name file)) lists))
