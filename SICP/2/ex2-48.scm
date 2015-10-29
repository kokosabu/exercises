(load "./ex2-46.scm")

(define make-segment cons)
(define start-segment car)
(define end-segment cdr)

(define x (make-segment (make-vect 0 1)
						(make-vect 3 2)))
