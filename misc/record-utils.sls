
(library

 (agave misc record-utils)

 (export field-changer)

 (import (rnrs))

 (define (field-changer rtd field-name)

   (let ((field-names (record-type-field-names rtd)))

     (let ((index (let loop ((i 0))
                    (if (eq? (vector-ref field-names i) field-name)
                        i
                        (loop (+ i 1))))))

       (let ((accessor (record-accessor rtd index))
             (mutator  (record-mutator  rtd index)))

         (lambda (record procedure)

           (mutator record (procedure (accessor record))))))))

 )