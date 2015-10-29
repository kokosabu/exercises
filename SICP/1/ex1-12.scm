(define (pascal x y)
  (if (not (< x y))
      (cond ((or (= y 0) (= x y)) 1)
	    (else (+ (pascal (- x 1) (- y 1))
		     (pascal (- x 1) y))))
      (error x y)))

(define (pascal n k)
  (if (or (= k 1) (= k n))
      1
      (+ (pascal (- n 1) (- k 1)) (pascal (- n 1) k))))

(define (pascal x y)
  (if (or (= x 1) (= y 1))
      1
      (+ (pascal x (- y 1)) (pascal (- x 1) y))))

(define (pascal x y)
  (if (or (= x 1) (= x y))
      1
      (+ (pascal (- x 1) (- y 1))
         (pascal x (- y 1)))))

(define (pascal-graph n)
  (define (pascal x y)
    (cond ((or (= y 0) (= x y)) 1)
	  (else (+ (pascal (- x 1) (- y 1))
		   (pascal (- x 1) y)))))
  (define (pascal-line line n)
    (cond ((= n 0)
	   (print (pascal line n)))
	  (else
	   (display (pascal line n))
	   (display " ")
	   (pascal-line line (- n 1)))))
  (define (iter n m)
    (cond ((= n m) (pascal-line m m))
	  (else (pascal-line m m)
		(iter n (+ m 1)))))
  (iter n 0))