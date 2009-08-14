
(library

 (agave misc symbols)

 (export symbol<?)

 (import (rnrs))

 (define (symbol<? a b)
   (string<? (symbol->string a)
             (symbol->string b)))

 )