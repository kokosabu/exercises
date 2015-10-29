(define (=zero-term? L)
  (or (empty-termlist? L)
      (and (=zero? (coeff (fistr-term L)))
           (=zero-term? (rest-terms L)))))

(define (=zero-poly? p)
  (=zero-term? (term-list p)))
