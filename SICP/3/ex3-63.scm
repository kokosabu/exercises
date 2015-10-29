(load "./stream.scm")

(define (sqrt-stream x)
  (cons-stream 1.0
	       (stream-map (lambda (guess)
			     (sqrt-improve guess x))
			   (sqrt-stream x))))

; 上のものは必要桁回sqrt-streamが呼ばれ、
; 呼ばれるたびにストリームが生成される。
; 生成されたストリームの先頭は不必要であるが
; 再計算される。
; そのため冗長である。
; 一方guessesを使用するものは、memo-procを
; 使用しておれば計算する必要がない。
; もし、(lambda () <exp)を使用すると、
; guessesを使用していても再計算されるため
; 二つの版の効率に違いがなくなる。
