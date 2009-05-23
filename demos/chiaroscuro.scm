
(import (rnrs) (misc random-weighted) (context-free-art))

(define (black)
  (when (iterate?)
        (call-random-weighted
         (60 (lambda ()
               (block
                (lambda ()
                  (size 0.6)
                  (circle)))
               (block
                (lambda ()
                  (x 0.1)
                  (rotate 5)
                  (size 0.99)
                  (brightness -0.01)
                  (alpha -0.01)
                  (black)))))
         (1 (lambda ()
              (block
               (lambda ()
                 (white)
                 (black))))))))

(define (white)
  (when (iterate?)
        (call-random-weighted
         (60 (lambda ()
               (block
                (lambda ()
                  (size 0.6)
                  (circle)))
               (block
                (lambda ()
                  (x 0.1)
                  (rotate -5)
                  (size 0.99)
                  (brightness 0.01)
                  (alpha -0.01)
                  (white)))))
         (1 (lambda ()
              (block
               (lambda ()
                 (black)
                 (white))))))))

(define (chiaroscuro)
  (when (iterate?)
        (block
         (lambda ()
           (brightness 0.5)
           (black)))))

(background (lambda () (brightness -0.5)))

(viewport '(-3 6 -2 6))

(threshold 0.03)

(start-shape (lambda () (chiaroscuro)))

(run-model)