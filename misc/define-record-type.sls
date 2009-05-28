
(library

 (misc define-record-type)

 (export define-record-type++)

 (import (rnrs))

 (define-syntax define-record-type++

   (syntax-rules (fields mutable)

     ( (define-record-type++
         (name constructor predicate cloner assigner applier)
         (fields (mutable field accessor mutator changer)
                 ...))

       (begin

         (define-record-type (name constructor predicate)
           (fields (mutable field accessor mutator)
                   ...))

         (define (cloner record)
           (constructor (accessor record)
                        ...))

         (define (assigner a b)
           (mutator a (accessor b))
           ...)

         (define applier

           (case-lambda ((procedure record)
                         (procedure (accessor record)
                                    ...))

                        ((procedure)
                         (lambda (record)
                           (procedure (accessor record)
                                      ...)))))

         (define (changer record procedure)
           (mutator record (procedure (accessor record))))
         ...

         ) )))

 )