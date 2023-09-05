(define-macro (switch expr cases)
  (let
    ((val (eval expr)))
    (cons
      'cond
      (map
        (lambda (case) (cons (equal? val (car case)) (cdr case)))
        cases))))

(define (flatmap f x)
  (define (helper res rest)
    (if (null? rest)
      res
      (helper
        (let
        ((val (f (car rest))))
        (append
          res
          (if (pair? val) val (list val))))
        (cdr rest))))
  (helper '() x))

(define (expand lst)
  (define (cases x)
    (cond
      ((equal? x 'x) '(x r y f r))
      ((equal? x 'y) '(l f x l y))
      (else x)))
  (flatmap cases lst))

(define (interpret instr dist)
  (define (draw lst)
    (if (null? lst)
      'finished
      (begin
        (let
          ((val (car lst)))
          (cond 
            ((equal? val 'f) (forward dist))
            ((equal? val 'l) (left 90))
            ((equal? val 'r) (right 90))))
        (draw (cdr lst)))))
  (draw instr))

(define (apply-many n f x)
  (if (zero? n)
      x
      (apply-many (- n 1) f (f x))))

(define (dragon n d)
  (interpret (apply-many n expand '(f x)) d))