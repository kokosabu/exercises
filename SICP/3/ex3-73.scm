(load "./stream.scm")

(define ones (cons-stream 1 ones))

(define (add-streams s1 s2)
  (streams-map + s1 s2))
(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

(define (integral integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (add-streams (scale-stream integrand dt)
                              int)))
  int)

(define (RC R C dt)
  (define (RC-stream i v0)
    (add-streams
     (scale-stream i R)
     (integral (scale-stream i (/ 1 C))
               v0
               dt)))
  RC-stream)

(define RC1 (RC 5 1 0.5))