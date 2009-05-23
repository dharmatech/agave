
(import (rnrs) (misc random-weighted) (context-free-art))

(define (f-triangles)
  
  (when (iterate?)

        (block
         (lambda ()
           (x 0.1)
           (y 0.1)
           (alpha -0.33)
           (hue 20)
           (saturation 0.7)
           (brightness 0.80)
           (triangle)))

        (block
         (lambda () (hue 10) (saturation 0.9) (brightness 0.33) (triangle)))

        (block
         (lambda ()
           (size 0.9)
           (hue 10)
           (saturation 0.5)
           (brightness 1.00)
           (triangle)))

        (block (lambda () (size 0.8) (rotate 5) (f-triangles)))))

(define (f-squares)

  (when (iterate?)

        (block
         (lambda ()
           (x 0.1)
           (y 0.1)
           (alpha -0.33)
           (hue 250)
           (saturation 0.70)
           (brightness 0.80)
           (square)))

        (block
         (lambda () (hue 220) (saturation 0.90) (brightness 0.33) (square)))

        (block
         (lambda ()
           (size 0.9)
           (hue 220)
           (saturation 0.25)
           (brightness 1.00)
           (square)))

        (block (lambda () (size 0.8) (rotate 5) (f-squares)))))

(define (spiral)

  (when (iterate?)

        (call-random-weighted

         (1 (lambda ()

              (block (lambda () (f-squares)))

              (block (lambda () (x 0.5) (y 0.5) (rotate 45) (f-triangles)))

              (block (lambda () (y 1.0) (rotate 25) (size 0.9) (spiral)))))

         (0.022 (lambda ()
                  (block (lambda () (flip 90) (hue 50) (start))))))))

(define (start)
  (block (lambda ()              (spiral)))
  (block (lambda () (rotate 120) (spiral)))
  (block (lambda () (rotate 240) (spiral))))

(background (lambda () (hue 66) (saturation 0.4) (brightness 0.5)))

(viewport '(-5 10 -5 10))

(threshold 0.001)

(start-shape (lambda () (start)))

(run-model)