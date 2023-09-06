(define (map-stream f s)
    (if (null? s)
    	nil
    	(cons-stream (f (car s)) (map-stream f (cdr-stream s)))))

(define multiples-of-three
  (cons-stream 3 (map-stream (lambda (x) (+ 3 x)) multiples-of-three)))

(define (rle s)
  (define (inc pair)
    (let
      ((val (car pair))
       (cnt (car (cdr pair))))
      (list val (+ 1 cnt))))
      
  (define (helper pair lst)
    (if (null? lst)
      (cons-stream pair nil)
      (let
        ((val (car pair))
         (cur (car lst))
         (rest (cdr-stream lst)))
        (if (equal? val cur)
          (helper (inc pair) rest)
          (cons-stream pair (helper (list cur 1) rest))))))

  (if (null? s)
    '()
    (helper (list (car s) 1) (cdr-stream s))))