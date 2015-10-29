(load "./2.scm")

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
	  (cons '() elts)
	  (let ((left-size (quotient (- n 1) 2)))
		(let ((left-result (partial-tree elts left-size)))
		  (let ((left-tree (car left-result))
				(non-left-elts (cdr left-result))
				(right-size (- n (+ left-size 1))))
			(let ((this-entry (car non-left-elts))
				  (right-result (partial-tree (cdr non-left-elts)
											  right-size)))
			  (let ((right-tree (car right-result))
					(remaining-elts (cdr right-result)))
				(cons (make-tree this-entry left-tree right-tree)
					  remaining-elts))))))))

; 左の大きさを求める
; 左の答えを求める
; 左の木とそれ以外のリストを求める
; 右の大きさを求める
; エントリーを求める
