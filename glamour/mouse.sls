(library

 (glamour mouse)

 (export mouse mouse-press pressed-motion passive-motion motion)

 (import (rnrs) (glut))

 (define-syntax mouse
   (syntax-rules ()
     ( (mouse var-button var-state var-x var-y)

       (begin

         (define var-x 0)
         (define var-y 0)

         (define var-button 0)
         (define var-state  1)

         (glutMouseFunc
          (lambda (button state x y)
            (set! var-button button)
            (set! var-state  state)
            (set! var-x      x)
            (set! var-y      y)))

         (glutMotionFunc
          (lambda (x y)
            (set! var-x x)
            (set! var-y y)))

         (glutPassiveMotionFunc
          (lambda (x y)
            (set! var-x x)
            (set! var-y y)))) )))

 (define-syntax mouse-press
   (syntax-rules ()

     ( (mouse-press var-button var-state var-x var-y)

       (begin

         (define var-x 0)
         (define var-y 0)

         (define var-button 0)
         (define var-state  1)

         (glutMouseFunc
          (lambda (button state x y)
            (set! var-button button)
            (set! var-state  state)
            (set! var-x      x)
            (set! var-y      y)))) )))

 (define-syntax pressed-motion
   (syntax-rules ()

     ( (pressed-motion var-x var-y)

       (begin

         (define var-x 0)
         (define var-y 0)

         (glutMotionFunc
          (lambda (x y)
            (set! var-x x)
            (set! var-y y)))) )))

 (define-syntax passive-motion
   (syntax-rules ()

     ( (passive-motion var-x var-y)

       (begin

         (define var-x 0)
         (define var-y 0)

         (glutPassiveMotionFunc
          (lambda (x y)
            (set! var-x x)
            (set! var-y y)))) )))
 
 (define-syntax motion
   (syntax-rules ()

     ( (motion var-x var-y)

       (begin

         (define var-x 0)
         (define var-y 0)

         (glutMotionFunc
          (lambda (x y)
            (set! var-x x)
            (set! var-y y)))

         (glutPassiveMotionFunc
          (lambda (x y)
            (set! var-x x)
            (set! var-y y)))) )))

 )