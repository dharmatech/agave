
(library

 (agave misc bytevector-utils)

 (export make-f64-vector
         f64-vector
         f64-vector-ref
         f64-vector-set!)

 (import (rnrs))

 (define (make-f64-vector n)
   (make-bytevector (* n 8)))

 (define (f64-vector . vals)
   (let ((n (length vals)))
     (let ((bv (make-bytevector (* n 8))))
       (let loop ((vals vals) (i 0))
         (if (< i n)
             (begin
               (bytevector-ieee-double-native-set! bv (* i 8) (car vals))
               (loop (cdr vals) (+ i 1)))))
       bv)))

 (define (f64-vector-ref v i)
   (bytevector-ieee-double-native-ref v (* i 8)))

 (define (f64-vector-set! v i val)
   (bytevector-ieee-double-native-set! v (* i 8) val))

 )