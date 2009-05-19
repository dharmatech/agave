
(library

 (glamour misc)

 (export initialize-glut
         buffered-display-procedure
         background
         gl-matrix-excursion
         )

 (import (rnrs) (gl) (glut))

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

 )

