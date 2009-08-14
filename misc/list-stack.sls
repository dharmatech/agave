
(library

 (agave misc list-stack)

 (export push! pop!)

 (import (rnrs))

 (define-syntax push!
   (syntax-rules ()
     ( (push! lis elt)
       (set! lis (cons elt lis)) )))

 (define-syntax pop!
   (syntax-rules ()
     ( (pop! lis)
       (let ((elt (car lis)))
         (set! lis (cdr lis))
         elt) )))

 )

