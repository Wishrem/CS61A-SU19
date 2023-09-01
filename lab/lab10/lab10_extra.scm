;; Scheme ;;


(define lst
  '((1) 2 (3 4) 5)
)

(define (composed f g)
  (lambda (x) (f (g x)))
)

(define (remove item lst)
  (filter-lst (lambda (x) (not (= x item))) lst)
)


;;; Tests
(remove 3 nil)
; expect ()
(remove 3 '(1 3 5))
; expect (1 5)
(remove 5 '(5 3 5 5 1 4 5 4))
; expect (3 1 4 4)

(define (no-repeats s)
  (if (null? s)
    nil
    (cons
      (car s)
      (no-repeats
        (filter-lst
          (lambda (x) (not (= x (car s))))
          (cdr s)
        )
      )
    )
  )
)

(define (substitute s old new)
  (if (null? s)
    nil
    (cons
      (if (pair? (car s))
        (substitute (car s) old new)
        (if (equal? (car s) old)
          new
          (car s)
        )
      )
      (substitute (cdr s) old new)
    )  
  )
)


(define (sub-all s olds news)
  (if (null? olds)
    s
    (sub-all
      (substitute s (car olds) (car news))
      (cdr olds)
      (cdr news)
    )
  )
)