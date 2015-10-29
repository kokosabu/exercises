(load "./2.scm")
(load "./ex2-48.scm")

;a
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
			(make-segment (make-vect 0.25 0.50) (make-vect 0.00 0.40))
			(make-segment (make-vect 0.45 0.80) (make-vect 0.50 0.80))
			(make-segment (make-vect 0.55 0.80) (make-vect 0.60 0.80)))))

;b
(define (corner-split painter n)
  (if (= n 0)
	  painter
	  (let ((up     (up-split painter (- n 1)))
            (right  (right-split painter (- n 1)))
		    (corner (corner-split painter (- n 1))))
	    (beside (below painter up)
    			(below right corner)))))

;c
(define (square-limit painter n)
  (let ((combine4 (square-of-four flip-horiz rotate180
								  identity flip-vert)))
    	(combine4 (corner-split painter n))))
