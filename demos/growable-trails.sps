
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Based on an example from the Processing book
;;
;; Ported to Scheme by Ed Cavazos

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(import (rnrs)
        (dharmalab misc queue)
        (gl)
        (agave glu)
        (glut)
        (agave glamour window)
        (agave glamour mouse)
        (agave glamour misc))

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

(mouse mouse-button mouse-state mouse-x mouse-y)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define initial-trail-length 100)

(define trail (new-queue))

(do ((i 0 (+ i 1)))
    ((>= i initial-trail-length))
  (set! trail (queue-insert trail (vector 0.0 0.0))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(buffered-display-procedure

 (lambda ()

   (background 0.0)

   (glColor4d 1.0 1.0 1.0 0.1)

   (let ((trail-length (queue-length trail)))

     (let loop ((i 0)
                (trail trail))

       (if (not (queue-empty? trail))

           (let ((fraction (/ i trail-length)))

             (queue-remove

              trail

              (lambda (point trail)

                (circle (vector-ref point 0)
                        (vector-ref point 1)
                        (max 5.0 (* fraction 14.0)))

                (loop (+ i 1) trail)))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(glutIdleFunc

 (lambda ()

   (cond ((and (= mouse-state  GLUT_DOWN)
               (= mouse-button GLUT_LEFT_BUTTON))
          (if (not (queue-empty? trail))
              (begin
                (set! trail (queue-insert trail (vector mouse-x mouse-y)))
                (set! trail (cdr (queue-remove trail cons)))
                (set! trail (cdr (queue-remove trail cons))))))

         ((and (= mouse-state  GLUT_DOWN)
               (= mouse-button GLUT_RIGHT_BUTTON))
          (set! trail (queue-insert trail (vector mouse-x mouse-y))))

         (else
          (set! trail (queue-insert trail (vector mouse-x mouse-y)))
          (set! trail (cdr (queue-remove trail cons)))))
         
   (glutPostRedisplay)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(display "Right mouse button: grow   trail\n")
(display "Left  mouse button: shrink trail\n")

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(glutMainLoop)
