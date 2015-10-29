(load "./3.scm")

(define (transfer from-account to-account amount)
  ((from-account 'withdraw) amount)
  ((to-account 'deposit) amount))

; Louis Reasonerは正しい。
; 直列化しないとfrom-accountが負の値になる可能性がある