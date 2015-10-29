(load "./stream.scm")

(define (add-streams s1 s2)
  (streams-map + s1 s2))
(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

(define (integral delayed-integrand initial-value dt)
  (cons-stream initial-value
               (let ((integrand (force delayed-integrand)))
                 (if (stream-null? integrand)
                     the-empty-stream
                     (integral (delay (stream-cdr integrand))
                               (+ (* dt (stream-car integrand))
                                  initial-value)
                               dt)))))

(define (RLC R L C dt)
  (define (RLC-stream vc0 il0)
    (define vc (integral (delay dvc) vc0 dt))
    (define il (integral (delay dil) il0 dt))
    (define dvc (scale-stream il (/ -1 C)))
    (define dil (add-streams (scale-stream vc (/ 1 L))
                             (scale-stream il (/ (- R) L))))
    (define (stream-iter s t)
      (cons-stream (cons (stream-car s) (stream-car t))
                   (stream-iter (stream-cdr s) (stream-cdr t))))
    (stream-iter vc il))
  RLC-stream)

(define test-stream
  ((RLC 1 1 0.2 0.1) 10 0))