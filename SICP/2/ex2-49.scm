(load "./2.scm")
(load "./ex2-48.scm")

(define a (segments->painter (list
			(make-segment (make-vect 0 0) (make-vect 0 1))
			(make-segment (make-vect 0 1) (make-vect 1 1))
			(make-segment (make-vect 1 1) (make-vect 1 0))
			(make-segment (make-vect 1 0) (make-vect 0 0)))))

(define b (segments->painter (list
			(make-segment (make-vect 0 0) (make-vect 1 1))
			(make-segment (make-vect 0 1) (make-vect 1 0)))))

(define c (segments->painter (list
			(make-segment (make-vect   0 0.5) (make-vect 0.5   0))
			(make-segment (make-vect 0.5   0) (make-vect   1 0.5))
			(make-segment (make-vect   1 0.5) (make-vect 0.5   1))
			(make-segment (make-vect 0.5   1) (make-vect   0 0.5)))))

(define d (segments->painter (list
			(make-segment (make-vect 0.00 0.80) (make-vect 0.15 0.65))
			(make-segment (make-vect 0.15 0.65) (make-vect 0.25 0.70))
			(make-segment (make-vect 0.25 0.70) (make-vect 0.35 0.70))
			(make-segment (make-vect 0.35 0.70) (make-vect 0.30 0.80))
			(make-segment (make-vect 0.30 0.80) (make-vect 0.35 1.00))
			(make-segment (make-vect 0.65 1.00) (make-vect 0.70 0.80))
			(make-segment (make-vect 0.70 0.80) (make-vect 0.65 0.70))
			(make-segment (make-vect 0.65 0.70) (make-vect 0.75 0.70))
			(make-segment (make-vect 0.75 0.70) (make-vect 1.00 0.40))
			(make-segment (make-vect 1.00 0.20) (make-vect 0.65 0.45))
			(make-segment (make-vect 0.65 0.45) (make-vect 0.70 0.00))
			(make-segment (make-vect 0.65 0.00) (make-vect 0.50 0.20))
			(make-segment (make-vect 0.50 0.20) (make-vect 0.35 0.00))
			(make-segment (make-vect 0.25 0.00) (make-vect 0.35 0.55))
			(make-segment (make-vect 0.35 0.55) (make-vect 0.30 0.60))
			(make-segment (make-vect 0.30 0.60) (make-vect 0.25 0.50))
			(make-segment (make-vect 0.25 0.50) (make-vect 0.00 0.40)))))
