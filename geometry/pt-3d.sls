
(library

 (geometry pt-3d)

 (export (rename (pt <pt>)
                 (make-pt pt))
         pt?
         pt-x
         pt-y
         pt-z
         pt+  pt-  pt*  pt/
         pt+n pt-n pt*n pt/n
         pt-norm
         pt-normalize
         pt-dot)

 (import (rnrs))

 (define-record-type pt
   (fields (mutable x)
           (mutable y)
           (mutable z)))

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (define binary-pt-procedure
   (lambda (op)
     (lambda (a b)
       (make-pt (op (pt-x a) (pt-x b))
                (op (pt-y a) (pt-y b))
                (op (pt-z a) (pt-z b))))))
 
 (define pt+ (binary-pt-procedure +))
 (define pt- (binary-pt-procedure -))
 (define pt* (binary-pt-procedure *))
 (define pt/ (binary-pt-procedure /))

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (define (pt-n-procedure op)
   (lambda (a n)
     (make-pt (op (pt-x a) n)
              (op (pt-y a) n)
              (op (pt-z a) n))))

 (define pt+n (pt-n-procedure +))
 (define pt-n (pt-n-procedure -))
 (define pt*n (pt-n-procedure *))
 (define pt/n (pt-n-procedure /))

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (define (pt-neg p)
   (make-pt (- (pt-x p))
            (- (pt-y p))
            (- (pt-z p))))

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (define (sq n) (* n n))

 (define (pt-norm p)
   (sqrt (+ (sq (pt-x p))
            (sq (pt-y p))
            (sq (pt-z p)))))

 (define (pt-normalize p)
   (pt/n p (pt-norm p)))

 (define (pt-dot a b)
   (let ((val (pt* a b)))
     (+ (pt-x val)
        (pt-y val)
        (pt-z val))))

 )