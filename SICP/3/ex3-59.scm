(load "./3.scm")

; a
(define (integrate-series a)
  (streams-map / a integers))

; b
(define exp-series
  (cons-stream 1 (integrate-series exp-series)))

(define consine-series
  (cons-stream 1 (stream-map - (integrate-series sine-series))))

(define sine-series
  (cons-stream 0 (integrate-series cons-stream)))
