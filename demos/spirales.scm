
(import (rnrs) (context-free-art))

(define (chunk)
  (block (lambda () (circle)))
  (block (lambda () (size 0.3) (flip 60.0) (line))))

(define (a1)

  (when (iterate?)

        (block
         (lambda ()
           (size 0.95)
           (x 2.0)
           (rotate 12)
           (brightness 0.5)
           (hue 10.0)
           (saturation 1.5)
           (a1)))

        (block (lambda () (chunk)))))

(define (line)

  (alpha -0.3)

  (block (lambda () (rotate   0) (a1)))
  (block (lambda () (rotate 120) (a1)))
  (block (lambda () (rotate 240) (a1))))

(background (lambda () (brightness -1)))

(viewport '(-20 40 -20 40))

(start-shape (lambda () (line)))

(threshold 0.05)

(run-model)

        