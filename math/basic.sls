
(library

 (agave math basic)

 (export pi sq multiply-by greater-than
         add
         subtract)

 (import (rnrs) (agave misc curry))

 (define pi  3.14159265358979323846)

 (define (sq n) (* n n))

 (define add           (curry + a b))

 (define multiply-by   (curry * a b))

 (define subtract-from (curry - a b))

 (define subtract      (curry - b a))

 (define divide        (curry / a b))

 (define divide-by     (curry / b a))

 (define greater-than  (curry >  b a))
 (define greater-than= (curry >= b a))

 (define less-than     (curry <  b a))
 (define less-than=    (curry <= b a))

 )