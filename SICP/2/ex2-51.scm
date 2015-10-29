(load "./ex2-50.scm")

(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
	(let ((paint-low
		   (transform-painter painter1
							  (make-vect 0.0 0.0)
							  (make-vect 1.0 0.0)
							  split-point))
		  (paint-up
		   (transform-painter painter2
							  split-point
							  (make-vect 1.0 0.5)
							  (make-vect 0.0 1.0))))
	  (lambda (frame)
		(paint-low frame)
		(paint-up frame)))))


(define (below painter1 painter2)
  (rotate270 (beside (rotate90 painter2)
					 (rotate90 painter1))))
