
(library (agave processing math)

 (export map-number random)

 (import (rnrs)
         (surfage s27 random-bits))

 (define (map-number value low1 high1 low2 high2)
   (+ low2
      (* (/ (- value low1)
            (- high1 low1))
         (- high2 low2))))

 (define random
   (case-lambda
    ((a b)
     (cond ((and (integer? a)
                 (integer? b))
            (+ a (random-integer (- b a))))
           (else
            (+ a (* (- b a)
                    (random-real))))))
    ((a)
     (cond ((integer? a) (random 0 a))
           (else (random 0.0 a))))
    (() (random-real))))
 
 )