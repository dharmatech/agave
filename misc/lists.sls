
(library

 (agave misc lists)

 (export every-is
         every-of
         any-are
         any-of)

 (import (rnrs)
         (only (srfi :1) every any)
         (agave misc curry))

 (define every-is (curry every a b))

 (define every-of (curry every b a))

 (define any-are (curry any a b))

 (define any-of  (curry any b a))

 )