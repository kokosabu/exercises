(load "./stream.scm")
(load "./ex3-50.scm")

(define sense-list '(1 2 1.5 1 0.5 -0.1 -2 -3 -2 -0.5 0.2 3 4))
(define (make-sense-data list)
  (if (null? list)
      '()
      (cons-stream (car list)
                   (make-sense-data (cdr list)))))
(define sense-data (make-sense-data sense-list))

(define (sign-change-detector s1 s2)
  (cond ((and (>= s1 0) (< s2 0))  1)
        ((and (< s1 0) (>= s2 0)) -1)
        (else                      0)))

(define (make-zero-crossings input-stream last-value)
  (cons-stream
   (sign-change-detector (stream-car input-stream) last-value)
   (make-zero-crossings (stream-cdr input-stream)
                        (stream-car input-stream))))

; ワンテンポずれる?
(define (smooth stream)
  (define (smooth-iter stream last-value)
    (let ((avpt (/ (+ (stream-car stream) last-value) 2)))
      (cons-stream
       avpt
       (smooth-iter (stream-cdr stream) (stream-car stream)))))
  (smooth-iter stream (stream-car stream)))

(define (smooth stream)
  (define (average x y) (/ (+ x y) 2))
  (streams-map average stream (stream-cdr stream)))

(define zero-crossings (make-zero-crossings (smooth sense-data) 0))