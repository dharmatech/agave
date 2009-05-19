
(library

 (processing math)

 (export map-number)

 (import (rnrs))

 (define (map-number value low1 high1 low2 high2)
   (+ low2
      (* (/ (- value low1)
            (- high1 low1))
         (- high2 low2))))
 )