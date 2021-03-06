(load "./3.scm")

(define (make-semaphore n)
  (let ((mutexes '())
        (count 0))
    (define (the-semaphore m)
      (cond ((eq? m 'acquire)
	     (set! count (+ count 1))
	     (if (< count n)
		 (set! mutexes (cons (make-mutex) mutexes)))
	     ((car mutexes) 'acquire))
	    ((eq? m 'release)
	     ((car mutexes) 'release)
	     (set! count (- count 1))
	     (if (>= count n)
		 (set! mutexes (cdr mutexes))))))
    the-semaphore))
