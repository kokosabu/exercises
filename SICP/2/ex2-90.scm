;; -*- Scheme -*-
;; 
;; Code for Exercise 2.90
;; $Id: ex-2.90.scm,v 1.1 2005/02/24 23:41:11 nobsun Exp $
;;----------------------------------------------------------

(define (square x) (* x x))

(define false #f)
(define true #t)

;;----------------------------------------------------------

(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                  (cdr record)
                  false))
            false)))
    (define (insert! key-1 key-2 value)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))))
            (set-cdr! local-table
                      (cons (list key-1
                                  (cons key-2 value))
                            (cdr local-table)))))
      'ok)    
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

;;----------------------------------------------------------

(define (attach-tag type-tag contents)
  (cond ((eq? type-tag 'scheme-number) contents)
        (else (cons type-tag contents))))

(define (type-tag datum)
  (cond ((pair? datum) (car datum))
        ((number? datum) 'scheme-number)
        (else "Bad tagged datum -- TYPE-TAG" datum)))

(define (contents datum)
  (cond ((pair? datum) (cdr datum))
        ((number? datum) datum)
        (else (error "Bad tagged datum -- CONTENTS" datum))))

;;----------------------------------------------------------

(define (install-rectangular-package)

  (define (real-part-rect z) (car z))
  (define (imag-part-rect z) (cdr z))
  (define (make-from-real-imag x y) (cons x y))
  (define (magnitude-rect z)
    (squareroot (add (square (real-part z))
                     (square (imag-part z)))))
  (define (angle-rect z)
    (arctangent (imag-part z) (real-part z)))
  (define (make-from-mag-ang r a) 
    (cons (mul r (cosine a)) (mul r (sine a))))

  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part '(rectangular) real-part-rect)
  (put 'imag-part '(rectangular) imag-part-rect)
  (put 'magnitude '(rectangular) magnitude-rect)
  (put 'angle '(rectangular) angle-rect)
  (put 'make-from-real-imag 'rectangular
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

(define (install-polar-package)
  ;; internal procedures
  (define (magnitude-pol z) (car z))
  (define (angle-pol z) (cdr z))
  (define (make-from-mag-ang r a) (cons r a))
  (define (real-part-pol z)
    (mul (magnitude z) (cosine (angle z))))
  (define (imag-part-pol z)
    (mul (magnitude z) (sine (angle z))))
  (define (make-from-real-imag x y) 
    (cons (squareroot (add (square x) (square y)))
          (arctangent y x)))

  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'polar x))
  (put 'real-part '(polar) real-part-pol)
  (put 'imag-part '(polar) imag-part-pol)
  (put 'magnitude '(polar) magnitude-pol)
  (put 'angle '(polar) angle-pol)
  (put 'make-from-real-imag 'polar
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'polar
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

;;----------------------------------------------------------

(define (install-scheme-number-package)
  (define (tag x)
    (attach-tag 'scheme-number x))
  (put '=zero? '(scheme-number)
       (lambda (x) (zero? x)))
  (put 'equ? '(scheme-number scheme-number)
       (lambda (x y) (= x y)))
  (put 'add '(scheme-number scheme-number)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(scheme-number scheme-number)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number)
       (lambda (x y) (tag (* x y))))
  (put 'div '(scheme-number scheme-number)
       (lambda (x y) (tag (/ x y))))
  (put 'exp '(scheme-number scheme-number)
       (lambda (x y) (tag (expt x y))))
  (put 'cosine '(scheme-number)
       (lambda (x) (tag (cos x))))
  (put 'sine '(scheme-number)
       (lambda (x) (tag (sin x))))
  (put 'arctangent '(scheme-number)
       (lambda (x) (tag (atan x))))
  (put 'squareroot '(scheme-number)
       (lambda (x) (tag (sqrt x))))
  (put 'square '(scheme-number)
       (lambda (x) (tag (* x x))))
  (put 'negate '(scheme-number)
       (lambda (x) (tag (- x))))
  (put 'make 'scheme-number
       (lambda (x) (tag x)))
  'done)

(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))

(define factor-rational 100000000)
(define (install-rational-package)
  ;; internal procedures
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (make-rat n d)
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))
  (define (equ?-rat x y)
    (= (* (numer x) (denom y))
       (* (denom x) (numer y))))
  (define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))))
  (define (div-rat x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y))))
  (define (cosine-rat x)
    (make-rat
     (inexact->exact (truncate (* factor-rational (cos (/ (numer x) (denom x))))))
     factor-rational))
  (define (sine-rat x)
    (make-rat
     (inexact->exact (truncate (* factor-rational (sin (/ (numer x) (denom x))))))
     factor-rational))
  (define (arctangent-rat x)
    (make-rat
     (inexact->exact (truncate (* factor-rational (atan (/ (numer x) (denom x))))))
     factor-rational))
  (define (squareroot-rat x)
    (make-rat
     (inexact->exact (truncate (* factor-rational (sqrt (/ (numer x) (denom x))))))
     factor-rational))
  (define (square-rat x)
    (make-rat (* (numer x) (numer x)) (* (denom x) (denom x))))
    ;; interface to rest of the system
  (define (tag x) (attach-tag 'rational x))
  (put '=zero? '(rational)
       (lambda (r) (zero? (numer r))))
  (put 'equ? '(rational rational)
       (lambda (x y) (equ?-rat x y)))
  (put 'add '(rational rational)
       (lambda (x y) (tag (add-rat x y))))
  (put 'sub '(rational rational)
       (lambda (x y) (tag (sub-rat x y))))
  (put 'mul '(rational rational)
       (lambda (x y) (tag (mul-rat x y))))
  (put 'div '(rational rational)
       (lambda (x y) (tag (div-rat x y))))
  (put 'cosine '(rational) cosine-rat)
  (put 'sine '(rational) sine-rat)
  (put 'arctangent '(rational) arctangent-rat)
  (put 'squareroot '(rational) squareroot-rat)
  (put 'square '(rational) square-rat)
  (put 'negate '(rational)
       (lambda (x) (tag (make-rat (- (numer x)) (denom x)))))
  (put 'make 'rational
       (lambda (n d) (tag (make-rat n d))))
  'done)

(define (make-rational n d)
  ((get 'make 'rational) n d))

(define (install-complex-package)
  ;; imported procedures from rectangular and polar packages
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))
  ;; internal procedures
  (define (equ?-complex x y)
    (and (equ? (real-part x) (real-part y))
         (equ? (imag-part x) (imag-part y))))
  (define (add-complex z1 z2)
    (make-from-real-imag (add (real-part z1) (real-part z2))
                         (add (imag-part z1) (imag-part z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag (add (real-part z1) (real-part z2))
                         (add (imag-part z1) (imag-part z2))))
  (define (mul-complex z1 z2)
    (make-from-mag-ang (mul (magnitude z1) (magnitude z2))
                       (add (angle z1) (angle z2))))
  (define (div-complex z1 z2)
    (make-from-mag-ang (div (magnitude z1) (magnitude z2))
                       (sub (angle z1) (angle z2))))

;; interface to rest of the system
  (define (tag z) (attach-tag 'complex z))
  (put '=zero? '(complex)
       (lambda (z) (zero? (magnitude z))))
  (put 'equ? '(complex complex)
       (lambda (z1 z2) (equ?-complex z1 z2)))
  (put 'add '(complex complex)
       (lambda (z1 z2) (tag (add-complex z1 z2))))
  (put 'sub '(complex complex)
       (lambda (z1 z2) (tag (sub-complex z1 z2))))
  (put 'mul '(complex complex)
       (lambda (z1 z2) (tag (mul-complex z1 z2))))
  (put 'div '(complex complex)
       (lambda (z1 z2) (tag (div-complex z1 z2))))
  (put 'make-from-real-imag 'complex
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'complex
       (lambda (r a) (tag (make-from-mag-ang r a))))
  (put 'real-part '(complex)
       (lambda (z) (real-part z)))
  (put 'imag-part '(complex)
       (lambda (z) (imag-part z)))
  (put 'magnitude '(complex)
       (lambda (z) (magnitude z)))
  (put 'angle '(complex)
       (lambda (z) (angle z)))
  (put 'negate '(complex)
       (lambda (z) (tag (make-from-real-imag (negate (real-part z))
                                             (negate (imag-part z))))))
  'done)

(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))

(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))

;;----------------------------------------------------------
(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
(define (negate x) (apply-generic 'negate x))

(define (magnitude x) (apply-generic 'magnitude x))
(define (angle x)     (apply-generic 'angle x))
(define (real-part x) (apply-generic 'real-part x))
(define (imag-part x) (apply-generic 'imag-part x))
(define (equ? x)      (apply-generic 'equ? x))
(define (=zero? x)    (apply-generic '=zero? x))

(install-rectangular-package)
(install-polar-package)
(install-scheme-number-package)
(install-rational-package)
(install-complex-package)

;;----------------------------------------------------------
(define (scheme-number->rational n)
  (make-rational (inexact->exact (truncate (* factor-rational (contents n))))
                 factor-rational))
(define (scheme-number->complex n)
  (make-complex-from-real-imag n 0))
(define (rational->complex n)
  (make-complex-from-real-imag n 0))

(define coercion-table (make-table))
(define get-coercion (coercion-table 'lookup-proc))
(define put-coercion (coercion-table 'insert-proc!))

(put-coercion 'scheme-number 'rational scheme-number->rational)
(put-coercion 'scheme-number 'complex scheme-number->complex)
(put-coercion 'rational 'complex rational->complex)

;;----------------------------------------------------------
(define (scheme-number->scheme-number n) n)
(define (complex->complex z) z)
(define (rational->rational r) r)

(put-coercion 'scheme-number 'scheme-number
              scheme-number->scheme-number)
(put-coercion 'complex 'complex complex->complex)
(put-coercion 'rational 'rational rational->rational)

(define (exp x y) (apply-generic 'exp x y))

(put-coercion 'dense-term 'sparse-term
              (lambda (d) (make-sparse-term (dense->sparse (contents d)))))
(put-coercion 'sparse-term 'dense-term
              (lambda (s) (make-dense-term (sparse->dense (contents s)))))
(put-coercion 'dense-term 'dense-term identity)
(put-coercion 'sparse-term 'sparse-term identity)

;;-----------------------------------------------------------
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (define (do-coerce x type)
      (let ((coercion (get-coercion (type-tag x) type)))
        (and coercion (coercion x))))
    (define (find-proc-coerceds op args types)
      (if (null? types)
          #f
          (let ((type (car types)))
            (let ((coerceds (map (lambda (x) (do-coerce x type)) args)))
              (if coerceds
                  (let ((proc (get op (map type-tag coerceds))))
                    (if proc
                        (cons proc coerceds)
                        (find-proc-coerceds op args (cdr types))))
                  (find-proc-coerceds op args (cdr types)))))))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (let ((proc-coerceds (find-proc-coerceds op args type-tags)))
            (if proc-coerceds
                (apply (car proc-coerceds) (map contents (cdr proc-coerceds)))
                (error "No method for these types -- APPLY-GENERIC"
                       (list op type-tags))))))))

;;----------------------------------------------------------
(define (install-sparse-term-package)
  (define (make-sparse-term order coeff) (list order coeff))
  (define (the-empty-sparse-termlist) '())
  (define (empty-sparse-termlist? ts) (null? ts))
  (define (first-sparse-term ts) (car ts))
  (define (rest-sparse-terms ts) (cdr ts))
  (define (order-sparse t) (car t))
  (define (coeff-sparse t) (cadr t))
  (define (adjoin-sparse-term t ts)
    (if (=zero? (coeff-sparse t))
        ts
        (cons t ts)))
  (define (=zero-sparse-term? L)
    (or (empty-termlist? L)
        (and (=zero? (coeff (first-term L)))
             (=zero-term? (rest-terms L)))))
  (define (add-sparse-terms L1 L2)
    (cond ((empty-sparse-termlist? L1) L2)
          ((empty-sparse-termlist? L2) L1)
          (else
           (let ((t1 (first-sparse-term L1)) (t2 (first-sparse-term L2)))
             (cond ((> (order-sparse t1) (order-sparse t2))
                    (adjoin-sparse-term
                     t1 (add-sparse-terms (rest-sparse-terms L1) L2)))
                   ((< (order-sparse t1) (order-sparse t2))
                    (adjoin-sparse-term
                     t2 (add-sparse-terms L1 (rest-sparse-terms L2))))
                   (else
                    (adjoin-sparse-term
                     (make-sparse-term (order-sparse t1)
                                (add (coeff-sparse t1) (coeff-sparse t2)))
                     (add-sparse-terms (rest-sparse-terms L1)
                                (rest-sparse-terms L2)))))))))
  (define (mul-sparse-terms L1 L2)
    (if (empty-sparse-termlist? L1)
        (the-empty-sparse-termlist)
        (add-sparse-terms (mul-sparse-term-by-all-sparse-terms
                           (first-sparse-term L1) L2)
                   (mul-sparse-terms (rest-sparse-terms L1) L2))))
  (define (mul-sparse-term-by-all-sparse-terms t1 L)
    (if (empty-sparse-termlist? L)
        (the-empty-sparse-termlist)
        (let ((t2 (first-sparse-term L)))
          (adjoin-sparse-term
           (make-sparse-term (+ (order-sparse t1) (order-sparse t2))
                             (mul (coeff-sparse t1) (coeff-sparse t2)))
           (mul-sparse-term-by-all-sparse-terms t1 (rest-sparse-terms L))))))
  (define (negate-saprse-term L)
    (if (empty-saprse-termlist? L)
        (the-empty-saprse-termlist)
        (let ((t (first-saprse-term L)))
          (adjoin-saprse-term
           (make-saprse-term (order-sparse t) (negate (coeff-sparse t)))
           (negate-saprse-term (rest-saprse-terms L))))))
  
  (define (tag x) (attach-tag 'sparse-term x))
  (put '=zero-term? '(sparse-term) =zero-sparse-term?)
  (put 'order '(sparse-term) order-sparse)
  (put 'add-terms '(sparse-term sparse-term)
       (lambda (x y) (tag (add-sparse-terms x y))))
  (put 'mul-terms '(sparse-tarm sparse-term)
       (lambda (x y) (tag (mul-sparse-terms x y))))
  (put 'negate-term '(sparse-term)
       (lambda (x) (tag (negate-sparse-term x))))
  (put 'make-from-sparse 'sparse-term
       (lambda (sparse-term-list) (tag sparse-term-list)))
  (put 'make-form-dense 'sparse-term
       (lambda (dense-term-list) (tag (dense->sparse dense-term-list))))
  'done)

(define (install-dense-term-package)
  (define (adjoin-dense-term term term-list)
    (cons term term-list))
  (define (the-empty-dense-termlist) '())
  (define (empty-dense-termlist? ts) (null? ts))
  (define (first-dense-term term-list) (car term-list))
  (define (rest-dense-terms term-list) (cdr term-list))
  (define (empty-dense-termlist? term-list) (null? term-list))
  (define (order-dense-term term-list) (length (rest-dense-terms term-list)))
  (define (coeff-dense-term term-list) (first-dense-term term-list))
  (define (=zero-dense-term? L)
    (or (empty-dense-termlist? L)
        (and (=zero? (coeff-dense-term L))
             (=zero-dense-term? (rest-dense-terms L)))))
    (define (normalize-dense-term L)
    (cond ((empty-dense-termlist? L) L)
          ((=zero? (first-dense-term L))
           (normalize-dense-term (rest-dense-terms L)))
          (else L)))
  (define (add-dense-terms L1 L2)
    (define (add-rterms R1 R2)
      (cond ((empty-dense-termlist? R1) R2)
            ((empty-dense-termlist? R2) R1)
            (else (adjoin-dense-term (add (first-dense-term R1)
                                          (first-dense-term R2))
                               (add-rterms (cdr R1) (cdr R2))))))
    (cond ((empty-dense-termlist? L1) L2)
          ((empty-dense-termlist? L2) L1)
          (else
           (normalize-dense-term (reverse (add-rterms (reverse L1)
                                                      (reverse L2)))))))
  (define (expand-dense-term L n)
    (if (= n 0)
        L
        (expand-dense-term
         (adjoin-dense-term (make-scheme-number 0) L) (- n 1))))
  (define (mul-dense-terms L1 L2)
    (define (mul-dense-terms-sub n L1 L2)
      (if (= n 0)
          (mul-dense-term-by-all-dense-terms 0 (first-dense-term L1) L2)
          (add-dense-terms
           (mul-dense-term-by-all-dense-terms n (first-dense-term L1) L2)
           (mul-dense-terms-sub (- n 1) (rest-dense-terms L1) L2))))
    (if (or (empty-dense-termlist? L1) (empty-dense-termlist? L2))
        (the-empty-dense-termlist)
        (mul-dense-terms-sub (order-dense-term L1) L1 L2)))
  (define (mul-dense-term-by-all-dense-terms n t1 L)
    (reverse (expand-dense-term (map (lambda (t) (mul t1 t)) (reverse L)) n)))
  (define (negate-dense-term L) (map negate L))
  (define (tag x) (attach-tag 'dense-term x))
  (put '=zero-term? '(dense-term) =zero-dense-term?)
  (put 'add-terms '(dense-term dense-term)
       (lambda (x y) (tag (add-dense-terms x y))))
  (put 'mul-terms '(dense-term dense-term)
       (lambda (x y) (tag (mul-dense-terms x y))))
  (put 'negate-term '(dense-term)
       (lambda (x) (tag (negate-dense-term x))))
  (put 'make-from-sparse 'dense-term
       (lambda (sparse-term-list) (tag (sparse->dense sparse-term-list))))
  (put 'make-from-dense 'dense-term
       (lambda (dense-term-list) (tag dense-term-list)))
  'done)

(define (dense->sparse ts)
  (define (iter rs i ts)
    (if (null? ts)
        rs
        (iter (cons (list i (car ts)) rs) (+ i 1) (cdr ts))))
  (iter '() 0 (reverse ts)))

(define (sparse->dense ts)
  (define (iter rs i ts)
    (if (null? ts)
        rs
        (let ((t (car ts)))
          (let ((j (car t)))
            (if (= i j)
                (iter (cons (cadr t) rs) (+ i 1) (cdr ts))
                (iter (cons (make-scheme-number 0) rs) (+ i 1) ts))))))
  (iter '() 0 (reverse ts)))

(define (install-polynomial-package)
  (define (make-poly variable term-list)
    (cons variable term-list))
  (define (variable p) (car p))
  (define (term-list p) (cdr p))
  (define (variable? x) (symbol? x))
  (define (same-variable? v1 v2)
    (and (variable? v1)
         (variable? v2)
         (eq? v1 v2)))
  (define (=zero-poly? p)
    (=zero-term? (term-list p)))
  (define (add-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (add-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- ADD-POLY"
               (list p1 p2))))
  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (mul-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- MUL-POLY"
               (list p1 p2))))
  (define (negate-poly p)
    (make-poly (variable p) (negate-term (term-list p))))
  (define (sub-poly p1 p2)
    (add-poly p1 (negate-poly p2)))
  (define (tag p) (attach-tag 'polynomial p))
  (put 'add '(polynomial polynomial) 
       (lambda (p1 p2) (tag (add-poly p1 p2))))
  (put 'sub '(polynomial polynomial) 
       (lambda (p1 p2) (tag (sub-poly p1 p2))))
  (put 'mul '(polynomial polynomial) 
       (lambda (p1 p2) (tag (mul-poly p1 p2))))
  (put '=zero? '(polynomial) =zero-poly?)
  (put 'negate '(polynomial)
       (lambda (p) (tag (negate-poly p))))
  (put 'make 'polynomial
       (lambda (var terms) (tag (make-poly var terms))))
  'done)

(define (make-polynomial var terms)
  ((get 'make 'polynomial) var terms))

(define (make-dense-term ts)
  ((get 'make-from-dense 'dense-term) ts))

(define (make-sparse-term ts)
  ((get 'make-from-sparse 'sparse-term) ts))

;;----------------------------------------------------------
(install-dense-term-package)
(install-sparse-term-package)

(define (add-terms x y) (apply-generic 'add-terms x y))
(define (mul-terms x y) (apply-generic 'mul-terms x y))

(install-polynomial-package)

(define p1 (make-polynomial 'x (make-sparse-term '((1 2) (0 1)))))
(define p2 (make-polynomial 'x (make-dense-term '(-1 -1))))

;(add p1 p1)
;(add p2 p2)
;(add p2 p1)
;(add p1 p2)