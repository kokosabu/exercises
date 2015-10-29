(load "./stream.scm")

(define (add-streams s1 s2)
  (streams-map + s1 s2))

(define (partial-sums s)
  (define new-s (cons-stream (stream-car s)
                             (add-streams new-s (stream-cdr s))))
  new-s)

(define try-count 0)

(define (stream-limit s n)
  (set! try-count (+ try-count 1))
  (let ((s1 (stream-car s))
        (s2 (stream-car (stream-cdr s))))
    (if (< (abs (- s1 s2)) n)
        s2
        (stream-limit (stream-cdr s) n))))

;;
(define (in2-stream-iter n)
  (cons-stream (/ 1.0 n)
               (stream-map - (in2-stream-iter (+ n 1)))))
(define in2-stream
  (partial-sums (in2-stream-iter 1)))

(define (in2-stream-limit)
  (stream-limit in2-stream 0.01))