(load "./3.scm")

(define (make-semaphore n)
  ; false list
  (define (init cell n count)
    (if (= count n)
        cell
        (init (cons #f cell) n (+ count 1))))
  (let ((cell (init '() n 0))
        (count 0))
    (define (the-semaphore m)
      (cond ((eq? m 'acquire)
	     (if (test-and-semaphoreet-all! cell)
		 (the-semaphore 'acquire))) ; retry
	    ((eq? m 'release) (clear! cell))))
    the-semaphore))

(define (test-and-test-all! cell)
  (cond ((null? cell) #t)
        ((test-and-test! cell) (test-and-test-all! (cdr cell)))
        (else #f)))
