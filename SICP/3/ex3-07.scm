(load "./ex3-03.scm")

(define (make-joint account original-password new-password)
  (lambda (password message)
    (if (eq? password new-password)
	(account original-password message)
	(lambda (arg) "Incorrect password!!!"))))

(define peter-acc (make-account 100 'open-sesame))
(define paul-acc
  (make-joint peter-acc 'open-sesame 'rosebud))
