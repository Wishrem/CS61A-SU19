;;;;;;;;;;;;;;;
;; Questions ;;
;;;;;;;;;;;;;;;

; Scheme

(define (cddr s)
  (cdr (cdr s)))

(define (cadr s)
  (car (cdr s)))

(define (caddr s)
  (car (cddr s)))

(define (unique s)
  (if (null? s)
    nil
    (cons 
      (car s)
      (unique (filter (lambda (x) (not (eq? x (car s)))) (cdr s))))))

(define (cons-all first rests)
  (map (lambda (item) (cons first item)) rests))

;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  (if (null? denoms)
    nil
    (if (zero? total)
      '(nil)
      (if (< total (car denoms))
        (list-change total (cdr denoms))
        (append
          (cons-all (car denoms) (list-change (- total (car denoms)) denoms))
          (list-change total (cdr denoms)))))))

; Tail recursion

(define (replicate x n)
  (define (replicate-tail res rest)
    (if (zero? rest)
      res
      (replicate-tail (cons x res) (- rest 1))))
  (replicate-tail '() n))

(define (accumulate combiner start n term)
  (define (for i)
    (if (= i n)
      (term i)
      (combiner (term i) (for (+ i 1)))))
  (combiner start (for 1)))

(define (accumulate-tail combiner start n term)
  (define (helper res i)
    (if (= i n)
      (combiner res (term i))
      (helper (combiner res (term i)) (+ i 1))))
  (helper start 1))


; Macros

(define-macro (list-of map-expr for var in lst if filter-expr)
  `(map (lambda (,var) ,map-expr) (filter (lambda (,var) ,filter-expr) ,lst)))