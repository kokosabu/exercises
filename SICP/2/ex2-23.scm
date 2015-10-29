(define (for-each func items)
  (func (car items))
  (if (not (null? (cdr items)))
      (for-each func (cdr items))))
