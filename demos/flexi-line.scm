
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Flexi Line by Jill Jackson

;; Original version in Processing:

;;   http://www.openprocessing.org/visuals/?visualID=323

;; Ported to Scheme by Ed Cavazos

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(import (rnrs) (gl) (glut))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; From SRFI 1

(define (iota n)
  (let loop ((i 0))
    (if (= i n)
        '()
        (cons i (loop (+ i 1))))))

(define (list-tabulate n procedure)
  (map procedure (iota n)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(glutInit (vector 0) (vector ""))

(glutInitDisplayMode GLUT_DOUBLE)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define width  500)
(define height 500)

(glutInitWindowSize 500 500)

(glutCreateWindow "Flexi Line by Jill Jackson")

(glutReshapeFunc
 (lambda (w h)

   (glViewport 0 0 w h)

   (glMatrixMode GL_PROJECTION)

   (glLoadIdentity)

   (glOrtho 0.0 (inexact w) (inexact h) 0.0 -1000.0 1000.0)
   
   (set! width  w)
   (set! height h)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define mouse-button #f)
(define mouse-state  GLUT_UP)
(define mouse-x      0)
(define mouse-y      0)

(glutMouseFunc
 (lambda (button state x y)
   (set! mouse-button button)
   (set! mouse-state  state)
   (set! mouse-x      x)
   (set! mouse-y      y)))

(glutMotionFunc
 (lambda (x y)
   (set! mouse-x x)
   (set! mouse-y y)))

(glutPassiveMotionFunc
 (lambda (x y)
   (set! mouse-x x)
   (set! mouse-y y)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define make-point

  (let ((pow 1))
    
    (lambda (x y)
      
      (let ((dx 0)
            (dy 0))

        (let ((update
               (lambda ()

                 ;; accelerate

                 (if (= mouse-state GLUT_DOWN)
                     (let ((k (* pow pow (if (= mouse-button GLUT_LEFT_BUTTON)
                                             1 -1)))
                           
                           (ang (atan (- mouse-y y)
                                      (- mouse-x x))))

                       (set! dx (+ dx (* k (cos ang))))
                       (set! dy (+ dy (* k (sin ang))))))

                 ;; move

                 (set! dx (* dx 0.98))
                 (set! dy (* dy 0.98))

                 (set! x (+ x dx))
                 (set! y (+ y dy))

                 ;; draw

                 (glVertex2d x y))))

          (vector 'point update))))))

(define (update-point p)
  ((vector-ref p 1)))

(define num 5000)

(define points
  (list-tabulate num
                 (lambda (i)
                   (make-point (inexact (* (/ i num) width))
                               (inexact (/ height 2))))))

(define (update-points)
  (for-each update-point points))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(glutDisplayFunc
 (lambda ()
   
   (glMatrixMode GL_MODELVIEW)
   
   (glLoadIdentity)

   (glClearColor 0.0 0.0 0.0 0.0)

   (glClear GL_COLOR_BUFFER_BIT)

   (glColor4d 1.0 1.0 1.0 1.0)

   (glBegin GL_LINE_STRIP)
   (update-points)
   (glEnd)
   
   (glutSwapBuffers)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(glutIdleFunc
 (lambda ()
   (glutPostRedisplay)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(for-each display
          '("\n"
            "Left  mouse button to pull\n"
            "Right mouse button to push\n"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(glutMainLoop)

