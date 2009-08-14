
(library

 (agave color hsva)

 (export <hsva> hsva hsva? hsva-clone hsva-assign! apply-hsva
           
         hsva-hue        hsva-hue-set!        hsva-hue-change!
         hsva-saturation hsva-saturation-set! hsva-saturation-change!
         hsva-value      hsva-value-set!      hsva-value-change!
         hsva-alpha      hsva-alpha-set!      hsva-alpha-change!)

 (import (rnrs) (agave misc define-record-type))

 (define-record-type++

   (<hsva> hsva hsva? hsva-clone hsva-assign! apply-hsva)
   
   (fields (mutable hue   hsva-hue   hsva-hue-set!   hsva-hue-change!)
           (mutable saturation
                    hsva-saturation
                    hsva-saturation-set!
                    hsva-saturation-change!)
           (mutable value  hsva-value  hsva-value-set!  hsva-value-change!)
           (mutable alpha hsva-alpha hsva-alpha-set! hsva-alpha-change!)))
 

 )