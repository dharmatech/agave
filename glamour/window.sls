
(library

 (agave glamour window)

 (export window invert-y)

 (import (rnrs) (gl) (glut))

 (define (invert-y w h)
   (glMatrixMode GL_PROJECTION)
   (glLoadIdentity)
   (glOrtho 0.0 (inexact w) (inexact h) 0.0 -1000.0 1000.0))

 (define-syntax window

   (syntax-rules (size title reshape)

     ( (window (size width height)
               (title name)
               (reshape (width-var height-var) procedure ...))

       (begin

         (define width-var  width)
         (define height-var height)

         (glutInitWindowSize width height)

         (glutCreateWindow name)

         (glutReshapeFunc

          (lambda (w h)

            (glViewport 0 0 w h)

            (glMatrixMode GL_PROJECTION)

            (glLoadIdentity)

            (glOrtho 0.0 (inexact w) 0.0 (inexact h) -1000.0 1000.0)

            (procedure w h)
            ...

            (set! width-var  w)
            (set! height-var h)))) )))

 )