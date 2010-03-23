
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Flexi Line by Jill Jackson

;; Original version in Processing:

;;   http://www.openprocessing.org/visuals/?visualID=323

;; Ported to Scheme by Ed Cavazos

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(import (rnrs)
        (only (surfage s1 lists) list-tabulate)
        (gl) (glut)
        (dharmalab records define-record-type)
        (dharmalab misc limit-call-rate)
        (agave glamour misc)
        (agave glamour window)
        (agave glamour mouse)
        (agave geometry pt))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(initialize-glut)

(window (size 500 500)
        (title "Flexi Line by Jill Jackson")
        (reshape (width height) invert-y))

(mouse mouse-button mouse-state mouse-x mouse-y)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-record-type++ point
  (fields pos vel))

(define (point::update p)
  (is-point p)
  (glVertex2d (pt-x p.pos) (pt-y p.pos))
  (make-point (pt+ p.pos p.vel)
              (if (= mouse-state GLUT_DOWN)
                  (let ((push/pull (if (= mouse-button GLUT_LEFT_BUTTON) 1 -1)))
                    (pt*n (pt+ p.vel
                               (pt*n (pt-normalize (pt- (pt mouse-x mouse-y) p.pos))
                                     push/pull))
                          0.98))
                  (pt*n p.vel 0.98))))

(define num 5000)

(define points
  (list-tabulate num
                 (lambda (i)
                   (make-point (pt (inexact (* (/ i num) width))
                                   (inexact (/ height 2)))
                               (pt 0.0 0.0)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(buffered-display-procedure
 (lambda ()
   (background 0.0)
   (glColor4d 1.0 1.0 1.0 1.0)
   (gl-begin GL_LINE_STRIP
     (set! points (map point::update points)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(glutIdleFunc (limit-call-rate 20 (glutPostRedisplay)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(for-each display
          '("\n"
            "Left  mouse button to pull\n"
            "Right mouse button to push\n"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(glutMainLoop)

