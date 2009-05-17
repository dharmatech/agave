
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Empathy by Kyle McDonald

;; Original version in Processing:

;;     http://www.openprocessing.org/visuals/?visualID=1182

;; Ported to Scheme by Ed Cavazos

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(import (rnrs) (srfi :27) (gl) (glut)

        (glamour frames-per-second)
        (glamour mouse)

        )

(glutInit (vector 0) (vector ""))

(glutInitDisplayMode GLUT_DOUBLE)

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

(define pi  3.14159265358979323846)

(define (sq n) (* n n))

(define random

  (case-lambda

   ((a b)

    (cond ((and (integer? a)
                (integer? b))

           (+ a (random-integer (- b a))))

          (else

           (+ a (* (- b a)
                   (random-real))))))

   ((a)

    (cond ((integer? a) (random 0 a))

          (else (random 0.0 a))))

   (() (random-real))))

(define (dist x1 y1 x2 y2)
  (sqrt (+ (sq (- x2 x1))
           (sq (- y2 y1)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(random-source-randomize! default-random-source)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define width  500)
(define height 500)

(glutInitWindowSize 500 500)

(glutCreateWindow "Empathy by Kyle McDonald")

(glutReshapeFunc
 (lambda (w h)

   (glEnable GL_LINE_SMOOTH)

   (glEnable GL_BLEND)
   (glBlendFunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA)

   (glViewport 0 0 w h)

   (glMatrixMode GL_PROJECTION)

   (glLoadIdentity)

   (glOrtho 0.0 (inexact w) (inexact h) 0.0 -1000.0 1000.0)
   
   (set! width  w)
   (set! height h)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(passive-motion mouse-x mouse-y)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define number-of-cells     5000)
(define base-line-length    37)
(define rotation-speed-step 0.004)
(define slow-down-rate      0.97)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (det x1 y1 x2 y2 x3 y3)
  (-   (* (- x2 x1)
          (- y3 y1))

       (* (- x3 x1)
          (- y2 y1))))

(define p-mouse-x 0)
(define p-mouse-y 0)

(define (cell x y)

  (let ((spin-velocity 0)
        (current-angle 0))

    (let ((sense
           (lambda ()
             
             (if (or (not (= p-mouse-x 0))
                     (not (= p-mouse-y 0)))
                 
                 (set! spin-velocity

                   (+ spin-velocity

                      (/ (* rotation-speed-step

                            (det x y p-mouse-x p-mouse-y mouse-x mouse-y))

                         (+ (dist x y mouse-x mouse-y) 1)))))

             (set! spin-velocity (* spin-velocity slow-down-rate))

             (set! current-angle (+ current-angle spin-velocity))

             (let ((d (+ 0.001 (* base-line-length spin-velocity))))

               (glVertex2d x y)
               (glVertex2d (+ x (* d (cos current-angle)))
                           (+ y (* d (sin current-angle))))))))

      (vector 'cell sense))))

(define (sense cell)
  ((vector-ref cell 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define cells
  (list-tabulate number-of-cells
    (lambda (i)

      (let ((theta (+ i (random 0 (/ pi 9))))
            (dista (+ 3

                      (random -3 3)

                      (* (/ i number-of-cells)

                         (/ width 2)

                         (* (/ (- number-of-cells i) number-of-cells) 3.3)))))

        (cell (+   (/ width  2)   (* dista (cos theta)))
              (+   (/ height 2)   (* dista (sin theta))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(glutDisplayFunc
 (lambda ()

   (glMatrixMode GL_MODELVIEW)

   (glLoadIdentity)

   (glClearColor 1.0 1.0 1.0 1.0)

   (glClear GL_COLOR_BUFFER_BIT)

   (glColor4d 0.0 0.0 0.0 0.5)

   (glBegin GL_LINES)
   (for-each sense cells)
   (glEnd)

   (set! p-mouse-x mouse-x)
   (set! p-mouse-y mouse-y)

   (glutSwapBuffers)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(display "Don't move too fast, you might scare it.\n")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(glutIdleFunc
 (lambda ()
   (glutPostRedisplay)))

;; (glutIdleFunc
;;  (frames-per-second 10))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(glutMainLoop)

