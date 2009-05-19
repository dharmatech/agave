
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Based on an example from the Processing book
;;
;; Ported to Scheme by Ed Cavazos

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(import (except (rnrs) for-each)
        (rnrs mutable-pairs)
        (only (srfi :1) circular-list for-each iota)
        (gl)
        (glu)
        (glut)
        (glamour window)
        (glamour mouse)
        (glamour misc))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define circle

  (let ((quadric (gluNewQuadric)))

    (lambda (x y radius)

      (gl-matrix-excursion

       (glTranslated (inexact x) (inexact y) 0.0)

       (gluDisk quadric 0.0 radius 20 1)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(initialize-glut)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(window (size 500 500)
        (title "Trails")
        (reshape (width height) invert-y))

(glEnable GL_BLEND)
(glBlendFunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(passive-motion mouse-x mouse-y)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define trail-length 100)

(define indices (iota trail-length))

(define points
  (apply circular-list
         (map (lambda (i)
                (vector 0.0 0.0))
              indices)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(buffered-display-procedure

 (lambda ()

   (background 0.0)

   (glColor4d 1.0 1.0 1.0 0.1)

   (for-each (lambda (i point)
               (let ((fraction (/ i trail-length)))

                 (circle (vector-ref point 0)
                         (vector-ref point 1)
                         (max 5.0 (* fraction 14.0)))))

             indices points)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(glutIdleFunc

 (lambda ()
 
   (set-car! points (vector mouse-x mouse-y))

   (set! points (cdr points))

   (glutPostRedisplay)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(glutMainLoop)
