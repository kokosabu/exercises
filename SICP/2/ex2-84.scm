(load "./ex2-83.scm")

(define (taller-type type1 type2)
  (define (sub type1 type2)
    (cond (type2 #f)
          ((eq? type1 type2) #t)
          (else (sub type1 (raise type2)))))
  (if (sub type1 type2)
      type1
      type2))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2))
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (let ((tall (taller-type type1 type2)))
                  (if (eq? tall type1)
                      (apply-generic op a1 (raise a2))
                      (apply-generic op (raise a1) a2))))
              (error "No method for these types"
                     (list op type-tags))))))
