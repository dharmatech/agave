
(library

 (agave color rgba)

 (export <rgba> rgba rgba? rgba-clone rgba-assign! apply-rgba
           
         rgba-red   rgba-red-set!   rgba-red-change!
         rgba-green rgba-green-set! rgba-green-change!
         rgba-blue  rgba-blue-set!  rgba-blue-change!
         rgba-alpha rgba-alpha-set! rgba-alpha-change!)

 (import (rnrs) (agave misc define-record-type))

 (define-record-type++

   (<rgba> rgba rgba? rgba-clone rgba-assign! apply-rgba)
   
   (fields (mutable red   rgba-red   rgba-red-set!   rgba-red-change!)
           (mutable green rgba-green rgba-green-set! rgba-green-change!)
           (mutable blue  rgba-blue  rgba-blue-set!  rgba-blue-change!)
           (mutable alpha rgba-alpha rgba-alpha-set! rgba-alpha-change!)))

 )