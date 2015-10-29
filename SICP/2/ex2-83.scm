(load "./2.scm")

(define (install-raise-package)
  (define (scheme-number->complex n)
    (make-complex-from-real-imag (contents n) 0))
  ; ...

  (put-coerion 'scheme-number 'complex scheme-number->complex)
  ; ...

  (put 'raise 'scheme-number 'complex)
  (put 'raise 'ration 'schme-number)
  (put 'raise 'int 'ration)
  'done)

(define (raise x)
  (let ((type (type-tag x)))
    ((get-coerion type (get 'raise type)) x)))
