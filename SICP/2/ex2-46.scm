;(load "./2.scm")

(define make-vect cons)
(define xcor-vect car)
(define ycor-vect cdr)

(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1)
				(xcor-vect v2))
			 (+ (ycor-vect v1)
				(ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1)
				(xcor-vect v2))
			 (- (ycor-vect v1)
				(ycor-vect v2))))

(define (scale-vect s v)
  (make-vect (* s (xcor-vect v))
			 (* s (ycor-vect v))))

(define v1 (make-vect 0 0))
(define v2 (make-vect 1 1))
