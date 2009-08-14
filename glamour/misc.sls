
(library

 (agave glamour misc)

 (export initialize-glut
         buffered-display-procedure
         background
         gl-matrix-excursion
         gl-begin
         gl-color-rgba
         gl-clear-color-rgba
         )

 (import (rnrs) (gl) (glut) (agave color rgba))

 (define (initialize-glut)

   (glutInit (vector 0) (vector ""))

   (glutInitDisplayMode GLUT_DOUBLE))

 (define (buffered-display-procedure procedure)

   (glutDisplayFunc

    (lambda ()

      (glMatrixMode GL_MODELVIEW)

      (glLoadIdentity)

      (procedure)

      (glutSwapBuffers))))

 (define background

   (case-lambda

    ( (r g b a)

      (glClearColor r g b a)

      (glClear GL_COLOR_BUFFER_BIT) )

    ( (r g b)

      (background r g b 1.0) )

    ( (grey alpha)

      (background grey grey grey alpha) )

    ( (grey)

      (background grey grey grey 1.0) )))

 (define-syntax gl-matrix-excursion

   (syntax-rules ()

     ( (gl-matrix-excursion expr ...)

       (begin

         (glPushMatrix)

         expr ...

         (glPopMatrix)))))

 (define-syntax gl-begin

   (syntax-rules ()

     ( (gl-begin mode expr ...)

       (begin

         (glBegin mode)

         expr ...

         (glEnd)) )))

 (define gl-color-rgba       (apply-rgba glColor4d))
 (define gl-clear-color-rgba (apply-rgba glClearColor))

 )

