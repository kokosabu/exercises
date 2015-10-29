(load "./ex2-10.scm")

(define (mul-interval x y)
  (let ((xl (lower-bound x))
        (xu (upper-bound x))
        (yl (lower-bound y))
        (yu (upper-bound y)))
    ; 最小
    (define small
      (cond
            ; x+ : ?
            ((and (> xl 0) (< yu 0)) (* xu yl))
            ((and (> xl 0) (> yl 0)) (* xl yl))
            ((> xl 0)                (* xu yl))
            ; x- : ?
            ((and (< xu 0) (< yu 0)) (* xu yu))
            ((< xu 0)                (* xl yu))
            ; x+- : ?
            ((> yl 0)                (* xl yu))
            ((< yu 0)                (* xu yl))
            (else (if (> (+ (abs xl) yu)
                         (+ xu (abs yl)))
                      (* xl yu)
                      (* xu yl)))))
    ; 最大
    (define big
      (cond
            ; x+ : ?
            ((and (> xl 0) (< yu 0)) (* xl yu))
            ((> xl 0)                (* xu yu))
            ; x- : ?
            ((and (< xu 0) (< yu 0)) (* xl yl))
            ((and (< xu 0) (> yl 0)) (* xu yl))
            ((< xu 0)                (* xl yl))
            ; x+- : ?
            ((> yl 0)                (* xu yu))
            ((< yu 0)                (* xl yl))
            (else (if (> (+ (abs xl) (abs yl))
                         (+ xu yu))
                      (* xl yl)
                      (* xu yu)))))
    (make-interval small big)))


; bugとりがすんだ

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))
