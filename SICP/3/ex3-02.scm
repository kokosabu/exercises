(define (make-monitored func)
  (define count 0)
  (lambda (arg)
    (if (eq? arg 'how-many-calls?)
	count
	(begin (set! count (+ count 1))
	       (func arg)))))