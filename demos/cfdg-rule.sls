
(library

 (agave demos cfdg-rule)

 (export rule)

 (import (rnrs)
         (agave demos cfdg)
         (agave misc random-weighted))

 (define-syntax rule

   (syntax-rules ()

     ( (rule
        name
        (weight (shape adjustment ...) ...)
        ...)

       (define name

         (let ((selector (random-weighted* (list weight ...)))

               (procedures

                (vector

                 (lambda ()

                   (block

                    (lambda ()

                      adjustment ... (shape)))

                   ...)

                 ...)))

           (lambda ()
             
             (if (iterate?)

                 ((vector-ref procedures (selector))))))) )))
 )