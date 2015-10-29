(use srfi-27)
(define random random-real)
(define (square x) (* x x))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (* (random) range))))

(define (estimate-integral P x1 x2 y1 y2 trials)
  (define (test-func)
    (P (random-in-range x1 x2)
       (random-in-range y1 y2)))
  (* (* (abs (- x1 x2)) (abs (- y1 y2)))
     (monte-carlo trials test-func)))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
	   (/ trials-passed trials))
	  ((experiment)
	   (iter (- trials-remaining 1) (+ trials-passed 1)))
	  (else
	   (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

(define (P1 x y)
  (<= (+ (square (- x 5.0))
	 (square (- y 7.0)))
      (square 3)))
