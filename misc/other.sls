
(library

 (agave misc other)

 (export =to 
         equal-to
         eq-to 
         eqv-to)

 (import (rnrs)
         (agave misc curry))
  
 (define =to (curry = a b))

 (define equal-to (curry equal? a b))

 (define eq-to (curry equal? a b))

 (define eqv-to (curry eqv? a b)))

