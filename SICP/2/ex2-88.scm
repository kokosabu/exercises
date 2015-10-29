(define (install-scheme-number-package)
  ; ...
  (put 'negate '(scheme-number)
       (lambda (x) (tag (- x))))
  ; ...
  'done)

(define (install-rational-package)
  ; ...
  (put 'negate '(rational-number)
       (lambda (x) (tag (make-rat (- (numer x)) (denom x)))))
  ; ...
  'done)

(define (install-complex-package)
  ; ...
  (put 'negate '(complex)
       (lambda (z) (tag (make-from-real-imag (negate (real-part z))
                                             (negate (imag-part z))))))
  ; ...
  'done)

(define (install-polynomial-package)
  ; ...
  (define (negate-poly p)
    (make-poly (variable p) (negate-term #?=(term-list p))))
  (define (negate-term L)
    (if (empty-termlist? L)
        (the-empty-termlist)
        (let ((t (first-term L)))
             (adjoin-term
               (make-term (order t) #?=(negate (coeff t)))
               (negate-term (rest-terms L))))))

  (put 'negate '(polynomial)
       (lambda (p) (tag (negate-poly p))))
  (put 'sub '(polynomial polynomial) 
       (lambda (p1 p2) (tag (sub-poly p1 p2))))
  ; ...
  'done)
