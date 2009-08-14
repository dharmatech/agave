(library

 (agave glamour frames-per-second)

 (export frames-per-second)

 (import (rnrs) (srfi :19) (glut))

 (define (current-time-in-nanoseconds)
   (let ((val (current-time)))
     (+ (* (time-second val) 1000000000)
        (time-nanosecond val))))

 (define (frames-per-second n)

   (let ( (window (glutGetWindow))
          (last-display-time 0) )

     (let ( (nanoseconds-per-frame
             (lambda ()
               (/ 1000000000.0 n)))

            (nanoseconds-since-last-display
             (lambda ()
               (- (current-time-in-nanoseconds)
                  last-display-time))) )

       (lambda ()
         (if (> (nanoseconds-since-last-display)
                (nanoseconds-per-frame))
             (begin
               (set! last-display-time (current-time-in-nanoseconds))
               (glutSetWindow window)
               (glutPostRedisplay))))))))