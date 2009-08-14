
(library

 (agave misc concatenative-combinators)

 (export uni)

 (import (rnrs base))

 (define (uni f c)
   (lambda (x)
     (c (f x))))

 )


         