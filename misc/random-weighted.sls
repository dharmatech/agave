
(library

 (misc random-weighted)

 (export random-weighted call-random-weighted)

 (import (rnrs)
         (only (srfi :1) iota take list-index)
         (srfi :27)
         )

 (define (probabilities weights)
   (let ((sum (apply + weights)))
     (map (lambda (w) (/ w sum))
          weights)))

 (define (layers probabilities)
   (let ((n (+ (length probabilities) 1)))
     (map (lambda (l) (apply + l))
          (cdr
           (map (lambda (num)
                  (take probabilities num))
                (iota n))))))

 (define (random-weighted weights)
   (list-index (let ((n (random-integer 1000)))
                 (lambda (elt)
                   (> elt n)))
               (map (lambda (elt) (* elt 1000))
                    (layers (probabilities weights)))))

 (define-syntax call-random-weighted
   
   (syntax-rules ()

     ( (call-random-weighted (weight procedure) ...)

       (let ((weights    (list   weight    ...))
             (procedures (vector procedure ...)))

         ((vector-ref procedures (random-weighted weights)))))))

 )

         

   
        
