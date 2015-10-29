(load "./stream.scm")

;; 入力想定ストリーム
;; (('reset . 10) 'generate 'generate ...)

(define (gen-rand a b m x)
  (define (rand-update x)
    (remainder (+ (* a x) b) m))
  (define (dispatch request-stream seed)
    (if (stream-null? request-stream)
        the-empty-stream
        (let ((request (stream-car request-stream)))
          (cond ((eq? request 'generate)
                 (cons-stream (rand-update seed)
                              (dispatch (stream-cdr request-stream) (rand-update seed))))
                ((and (pair? request)
                      (eq? (car request) 'reset))
                 (dispatch (stream-cdr request-stream) (cdr request)))
                (else (error "Error"))))))
  (define (dispatch2 request-stream)
    (dispatch request-stream x))
  dispatch2)


(define generate-stream
  (cons-stream 'generate
               generate-stream))
(define input-stream1
  (cons-stream (cons 'reset 10)
               generate-stream))
(define input-stream2
  (cons-stream 'generate
               (cons-stream 'generate
                            (cons-stream 'generate
                                         the-empty-stream))))

;; 動作例
;; gosh> (display-stream ((gen-rand 13 5 24 10) input-stream2))
;;
;; 15
;; 8
;; 13done
;; gosh> (display-stream ((gen-rand 13 5 24 10) (cons-stream (cons 'reset 3) input-stream2)))
;;
;; 20
;; 1
;; 18done
