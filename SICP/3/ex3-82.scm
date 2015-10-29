(use srfi-27)
(load "stream.scm")

(define random random-real)

(define (rand-update x)
  (define a 13)
  (define b 5)
  (define m 24)
  (remainder (+ (* a x) b) m))
(define random-init 10)
(define rand
  (let ((x random-init))
    (lambda ()
      (set! x (rand-update x))
      x)))
(define (map-successive-pairs f s)
  (cons-stream
   (f (stream-car s) (stream-car (stream-cdr s)))
   (map-successive-pairs f (stream-cdr (stream-cdr s)))))

(define (monte-carlo experiment-stream passed failed func)
  (define (next passed failed)
    (cons-stream
     (func (/ passed (+ passed failed)))
     (monte-carlo
      (stream-cdr experiment-stream) passed failed func)))
  (if (stream-car experiment-stream)
      (next (+ passed 1) failed)
      (next passed (+ failed 1))))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (* (random) range))))
;    (+ low (remainder (rand) range))))


(define (estimate-integral P x1 x2 y1 y2)
  (define (random-range-pairs-stream-parts1 x)
    (cons-stream x (random-range-pairs-stream-parts2 (random-in-range x1 x2))))
  (define (random-range-pairs-stream-parts2 x)
    (cons-stream x (random-range-pairs-stream-parts1 (random-in-range y1 y2))))
  (define random-range-pairs-stream
    (random-range-pairs-stream-parts2 (random-in-range x1 x2)))
  (define experiment-stream
    (map-successive-pairs P random-range-pairs-stream))
  (define (func x)
    (* (* (abs (- x1 x2)) (abs (- y1 y2)))
       x))
  (monte-carlo experiment-stream 0 0 func))

(define (square x) (* x x))
(define (P1 x y)
  (<= (+ (square (- x 5.0))
         (square (- y 7.0)))
      (square 3)))

; (display-stream (estimate-integral P1 2.0 8.0 4.0 10.0))