(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))



;; Problem 17
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 17
  (define (helper res i lst)
    (if (null? lst)
      res
      (helper (append res (list i (car lst))) )))
  )
 ; END PROBLEM 17

;; Problem 18

(define (zip pairs)
  ; BEGIN PROBLEM 18
  (define get-first (lambda (x) (car x)))
  (define get-second (lambda (x) (cadr x)))
  (define (helper res lst)
    (if (null? lst)
      res
      (helper
        (list
          (append (get-first res) (list (get-first (car lst))))
          (append (get-second res) (list (get-second (car lst)))))
        (cdr lst))))
  (helper '(() ()) pairs))
  ; END PROBLEM 18


;; Problem 19
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((quoted? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (cons form (cons params (map let-to-lambda body)))
           ; END PROBLEM 19
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (and
            (define params (car (zip values)))
            (define args (cadr (zip values)))
            (append
              (list (cons 'lambda (cons params (map let-to-lambda body))))
              (map let-to-lambda args)))
           ; END PROBLEM 19
           ))
        (else
         ; BEGIN PROBLEM 19
         (cons (car expr) (map let-to-lambda (cdr expr)))
         ; END PROBLEM 19
         )))
