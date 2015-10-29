(load "./3.scm")

(define (mul-streams s1 s2)
  (streams-map * s1 s2))

(define factorials (cons-stream 1 (mul-streams (stream-cdr integers) factorials)))
