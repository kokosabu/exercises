;; -*- Scheme -*-
;; 
;; Code for Exercise 2.97
;; $Id: ex-2.97.scm,v 1.2 2005/12/07 05:14:30 nobsun Exp $

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
  (define (reduce-integers n d)
    (let ((g (gcd n d)))
      (list (/ n g) (/ d g))))
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
  (put 'reduce '(scheme-number scheme-number) reduce-integers)
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
  ;;(define (make-rat n d)
  ;;  (let ((g (gcd n d)))
  ;;    (cons (/ n g) (/ d g))))

  ;;(define (make-rat n d) (cons n d))

  (define (make-rat n d)
    (cond ((and (eq? 'scheme-number (type-tag n))
	       (eq? 'scheme-number (type-tag d)))
	   (let* ((result (reduce n d))
		  (numer (car result))
		  (denom (cadr result)))
	     (if (> 0 denom)
		 (cons (negate numer) (negate denom))
		 (cons (car result) (cadr result)))))
          ((and (eq? 'polynomial (type-tag n))
		(eq? 'polynomial (type-tag d)))
           (let* ((result (reduce n d))
		  (numer (car result))
		  (denom (cadr result)))
	     (if (> 0 (coeff 1 denom))
		 (cons (negate numer) (negate denom))
		 (cons (car result) (cadr result)))))))

  (define (equ?-rat x y)
    (equ? (mul (numer x) (denom y))
	  (mul (denom x) (numer y))))
  (define (add-rat x y)
    (make-rat (add (mul (numer x) (denom y))
		   (mul (numer y) (denom x)))
              (mul (denom x) (denom y))))
  (define (sub-rat x y)
    (make-rat (sub (mul (numer x) (denom y))
		   (mul (numer y) (denom x)))
              (mul (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (mul (numer x) (numer y))
              (mul (denom x) (denom y))))
  (define (div-rat x y)
    (make-rat (mul (numer x) (denom y))
              (mul (denom x) (numer y))))
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

(define (coeff n x) (apply-generic 'coeff n x))

(define (gcd-poly x y) (apply-generic 'gcd-poly x y))
(define (greatest-common-divisor p1 p2)
  (cond ((and (eq? 'polynomial (type-tag p1))
	      (eq? 'polynomial (type-tag p2)))
         (gcd-poly p1 p2))
        ((and (not (eq? 'polynomial (type-tag p1)))
              (not (eq? 'polynomial (type-tag p2))))
         (gcd p1 p2))
        (else 
          (error "Bad type -- GREATEST-COMMON-DIVISOR"
                 (list p1 p2)))))

(define (reduce n d) (apply-generic 'reduce n d))

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
  (define (adjoin-term term term-list)
    (if (=zero? (coeff term))
        term-list
        (cons term term-list)))
  (define (the-empty-termlist) '())
  (define (first-term term-list) (car term-list))
  (define (rest-terms term-list) (cdr term-list))
  (define (empty-termlist? term-list) (null? term-list))
  (define (make-term order coeff) (list order coeff))
  (define (order term) (car term))
  (define (coeff term) (cadr term))
  (define (nth-coeff n p)
    (let loop ((n n)
	       (tl (term-list p)))
      (if (= n 1)
	  (coeff (first-term tl))
	  (loop (- n 1) (rest-terms tl)))))
  (define (=zero-term? L)
    (or (empty-termlist? L)
        (and (=zero? (coeff (first-term L)))
             (=zero-term? (rest-terms L)))))
  (define (=zero-poly? p)
    (=zero-term? (term-list p)))
  (define (add-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (add-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- ADD-POLY"
               (list p1 p2))))
  (define (add-terms L1 L2)
    (cond ((empty-termlist? L1) L2)
          ((empty-termlist? L2) L1)
          (else
           (let ((t1 (first-term L1)) (t2 (first-term L2)))
             (cond ((> (order t1) (order t2))
                    (adjoin-term
                     t1 (add-terms (rest-terms L1) L2)))
                   ((< (order t1) (order t2))
                    (adjoin-term
                     t2 (add-terms L1 (rest-terms L2))))
                   (else
                    (adjoin-term
                     (make-term (order t1)
                                (add (coeff t1) (coeff t2)))
                     (add-terms (rest-terms L1)
                                (rest-terms L2)))))))))
  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (mul-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- MUL-POLY"
               (list p1 p2))))
  (define (mul-terms L1 L2)
    (if (empty-termlist? L1)
        (the-empty-termlist)
        (add-terms (mul-term-by-all-terms (first-term L1) L2)
                   (mul-terms (rest-terms L1) L2))))
  (define (mul-term-by-all-terms t1 L)
    (if (empty-termlist? L)
        (the-empty-termlist)
        (let ((t2 (first-term L)))
          (adjoin-term
           (make-term (+ (order t1) (order t2))
                      (mul (coeff t1) (coeff t2)))
           (mul-term-by-all-terms t1 (rest-terms L))))))
  (define (negate-poly p)
    (make-poly (variable p) (negate-term (term-list p))))
  (define (negate-term L)
    (if (empty-termlist? L)
        (the-empty-termlist)
        (let ((t (first-term L)))
          (adjoin-term
           (make-term (order t) (negate (coeff t)))
           (negate-term (rest-terms L))))))
  (define (sub-poly p1 p2)
    (add-poly p1 (negate-poly p2)))
  (define (div-terms L1 L2)
    (if (empty-termlist? L1)
        (list (the-empty-termlist) (the-empty-termlist))
        (let ((t1 (first-term L1))
              (t2 (first-term L2)))
          (if (> (order t2) (order t1))
              (list (the-empty-termlist) L1)
              (let ((new-c (div (coeff t1) (coeff t2)))
                    (new-o (- (order t1) (order t2))))
                (let ((rest-of-result
                       (div-terms
                        (add-terms
                         L1
                         (negate-term
                          (mul-terms
                           L2
                           (list (make-term new-o new-c)))))
                        L2)))
                  (list (add-terms (list (make-term new-o new-c))
                                   (car rest-of-result))
                        (cadr rest-of-result))))))))
  (define (div-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (div-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- DIV-POLY"
               (list p1 p2))))
  (define (gcd-terms a b)
    (if (empty-termlist? b)
        (let ((gcdcoeff (apply gcd (map coeff a))))
          (car (div-terms
		a 
		(adjoin-term 
		 (make-term 0 gcdcoeff) 
		 (the-empty-termlist)))))
        (gcd-terms b (pseudoremainder-terms a b))))
  (define (remainder-terms a b)
    (cadr (div-terms a b)))
  (define (pseudoremainder-terms t1 t2)
    (let ((itf (integerizing-factor t1 t2))) 
      (let ((newt1 (mul-term-by-all-terms (make-term 0 itf) t1)))
        (let ((result (div-terms newt1 t2)))
          (cadr result)))))
  (define (integerizing-factor t1 t2)
    (let ((o1 (order (first-term t1)))
          (o2 (order (first-term t2)))
          (c  (coeff (first-term t2))))
      (exp c (add (sub o1 o2) 1))))
  (define (gcd-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
	(make-polynomial (variable p1) 
			 (gcd-terms (term-list p1) (term-list p2)))
	(error "Polys not in same var -- GCD-POLY"
	       (list p1 p2))))
  (define (reduce-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (map (lambda (x) (make-polynomial (variable p1) x))
             (reduce-terms (term-list p1)
                           (term-list p2)))
        (error "Polys not in same var -- REDUCE-POLY"
               (list p1 p2))))
  (define (reduce-terms t1 t2)
    (let ((gcdterms (gcd-terms t1 t2)))
      (list (car (div-terms t1 gcdterms))
            (car (div-terms t2 gcdterms)))))
  (define (tag p) (attach-tag 'polynomial p))
  (put 'add '(polynomial polynomial) 
       (lambda (p1 p2) (tag (add-poly p1 p2))))
  (put 'sub '(polynomial polynomial) 
       (lambda (p1 p2) (tag (sub-poly p1 p2))))
  (put 'mul '(polynomial polynomial) 
       (lambda (p1 p2) (tag (mul-poly p1 p2))))
  (put 'div '(polynomial polynomial) 
       (lambda (p1 p2) (tag (div-poly p1 p2))))
  (put '=zero? '(polynomial) =zero-poly?)
  (put 'negate '(polynomial)
       (lambda (p) (tag (negate-poly p))))
  (put 'gcd-poly '(polynomial polynomial) gcd-poly)
  (put 'reduce '(polynomial polynomial) reduce-poly)
  (put 'coeff '(scheme-number polynomial) nth-coeff)
  (put 'make 'polynomial
       (lambda (var terms) (tag (make-poly var terms))))
  'done)

(define (make-polynomial var terms)
  ((get 'make 'polynomial) var terms))

(install-polynomial-package)

#|

(define p1 (make-polynomial 'x '((1 1) (0 1))))  ;; x + 1
(define p2 (make-polynomial 'x '((3 1) (0 -1)))) ;; x^3 - 1
(define p3 (make-polynomial 'x '((1 1))))        ;; x
(define p4 (make-polynomial 'x '((2 1) (0 -1)))) ;; x^2 - 1

(reduce p1 p2)
(reduce p1 p4)
(reduce p2 p4)

(define rf1 (make-rational p1 p2))
(define rf2 (make-rational p3 p4))

(add rf1 rf2)

|#
