(define f
  (let ((save0 0)
	(save1 0))
    (lambda (num)
      (begin (set! save0 save1)
	     (set! save1 num)
	     save0))))
