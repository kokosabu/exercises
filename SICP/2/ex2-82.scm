(load "./ex2-81.scm")

(define (apply-generic op . args)
  (define (coercion type sources result)
    (if (null? sources)
        result
        (let ((source (car sources)))
          (if (eq? type (type-tag source))
              (coercion type (cdr sources)
                        (append result (list source)))
              (let (source->type (get-coercion type (type-tag source)))
                (if source->type
                    (coercion type (cdr sources)
                              (append result (list (source->type source))))
                    #f))))))
  (define (all-coercion type-tags args)
    (if (not (pair? type-tags))
        #f
        (let (result (apply-generic (car type-tags) args '()))
          (if result
              result
              (all-coercion (cdr type-tags) args)))))
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (let ((result (all-coercion type-tags args)))
            (if result
                result
                (error "No method for these types"
                        (list op type-tags)))))
      (eror "No method for these types"
              (list op type-tags)))))

;; 他の解答(http://oss.timedia.co.jp/show/SICP/ex-2.82)
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    ; xをtypeへ型変換しようとする
    ; 変換できない場合#fとなる
    (define (do-coerce x type)
      (let ((coercion (get-coercion (type-tag x) type)))
        (and coercion (coercion x))))
    (define (find-proc-coerceds op args types)
      (if (null? types)
          #f
          (let ((type (car types)))
          (let ((coerceds (map (lambda (x) (do-coerce x type)) args)))
            (if coerceds
                ; 型変換できたら演算を探す
                (let ((proc (get op (map type-tag coerceds))))
                  (if proc
                      (cons proc coerceds)
                      (find-proc-coerceds op args (cdr types))))
                (find-proc-coerceds op args (cdr types)))))))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (let ((proc-coerceds (find-proc-coerceds op args type-tags)))
            (if proc-coerceds
                (apply (car proc-coerceds) (map contents (cdr proc-coerceds)))
                (error "No method for these types -- APPLY-GENERIC"
                       (list op type-tags))))))))
