
(library

 (color hsva)

 (export (rename (hsva <hsva>)
                 (make-hsva hsva))
         hsva?
         hsva-hue hsva-saturation hsva-value hsva-alpha
         hsva-hue-set! hsva-saturation-set! hsva-value-set! hsva-alpha-set!
         hsva-clone
         hsva-hue-change!
         hsva-saturation-change!
         hsva-value-change!
         hsva-alpha-change!
         )

 (import (rnrs) (misc record-utils))

 (define-record-type hsva
   (fields (mutable hue)
           (mutable saturation)
           (mutable value)
           (mutable alpha)))

 (define (hsva-clone color)
   (make-hsva (hsva-hue        color)
              (hsva-saturation color)
              (hsva-value      color)
              (hsva-alpha      color)))

 (define hsva-hue-change!
   (field-changer (record-type-descriptor hsva) 'hue))

 (define hsva-saturation-change!
   (field-changer (record-type-descriptor hsva) 'saturation))

 (define hsva-value-change!
   (field-changer (record-type-descriptor hsva) 'value))
 
 (define hsva-alpha-change!
   (field-changer (record-type-descriptor hsva) 'alpha))
 

 )