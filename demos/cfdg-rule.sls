
(library

 (cfdg-rule)

 (export rule)

 (import (rnrs)
         (context-free-art)
         (misc random-weighted))

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